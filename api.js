var config = require('./config').api;
var express = require('express');
var app = express();
var bodyParser = require("body-parser");
var mysql = require('mysql');
var connections = mysql.createPool(config.db);
var winston = require('winston');

if (config.logfile != null) {
  winston.add(winston.transports.File, { filename: config.logfile });
  winston.remove(winston.transports.Console);
} // else default to STDOUT

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.get('/teamstandings/summary', function (req, res, next) {
    winston.info('/teamstandings/summary');

    getTeamStandings(res, false);
});

app.get('/teamstandings/full', function (req, res, next) {
    winston.info('/teamstandings/full');
    getTeamStandings(res, true);
});

var getTeamStandings = function(res, includeCountries) {
  connections.query('SELECT * from team_standings ORDER BY points DESC, golds DESC, silvers DESC', function(err, rows, fields) {
    if (err) {next(err); return;}

    var result = {standings: []}
    var previousRow = null;

    for (var i=0; i<rows.length; ++i) {
      var rawRow = rows[i];
      var position;

      if (previousRow != null &&
          rawRow.points == previousRow.points &&
          rawRow.golds == previousRow.golds &&
          rawRow.silvers == previousRow.silvers)
        position = previousRow.position;
      else
        position = i+1;

      var row = {
        "position" : position,
        "team" : rawRow.team,
        "username" : rawRow.username,
        "golds" : rawRow.golds,
        "silvers" : rawRow.silvers,
        "bronzes" : rawRow.bronzes,
        "points" : rawRow.points
      };

      result.standings.push(row);
      previousRow = row;
    }

    if (!includeCountries)
      res.send(result);
    else
      addCountriesToTeamStandings(result, res);
  });
}

var addCountriesToTeamStandings = function(teamStandings, res) {
  connections.query('SELECT cot.team, cs.*, c.flag_path, c.is_active ' +
                    'FROM countries_on_teams cot, country_standings cs, countries c ' +
                    'WHERE cot.country=cs.country AND cot.country = c.name', function(err, rows, fields) {

    // rows has format:
    // [{"team" : team1, "country" : country1, ...}, {"team" : team1, "country" : country2, ...}
    // convert to:
    // {team1 : [country1, country2...], ...}

    var teamToCountriesMap = {};

    for (var i=0; i<rows.length; ++i) {
      var row = rows[i];
      var team = row.team;

      if (teamToCountriesMap[team] == null) {
        teamToCountriesMap[team] = [];
      }

      teamToCountriesMap[team].push({
        "country" : row.country,
        "golds" : row.golds,
        "silver" : row.silvers,
        "bronzes" : row.bronzes,
        "isActive" : row.is_active == 1,
        "flagPath" : row.flag_path
      });
    }

    // now augment the teamStandings with each team's array of countries.

    for (var j=0; j<teamStandings.standings.length; ++j) {
      teamStandings.standings[j].countries = teamToCountriesMap[teamStandings.standings[j].team];
    }

    res.send(teamStandings);
  });
}

app.get('/countries/', function (req, res, next) {
  connections.query('SELECT * from countries ORDER BY pool ASC, last_olympics_score DESC', function(err, rows, fields) {
    if (err) {next(err); return;}

    var result = {"pools" : []};
    var pool = null;

    for(var i=0; i<rows.length; ++i) {
      var rawRow = rows[i];
      var row = {
        "name" : rawRow.name,
        "flagPath" : rawRow.flag_path,
        "isActive" : rawRow.is_active == 1,
        "lastOlympicsScore" : rawRow.last_olympics_score
      };

      if (pool == null || rawRow.pool != pool.index) {
        if (pool != null)
          result.pools.push(pool);
        pool = {"index":rawRow.pool, "countries":[row]};
      } else {
        pool.countries.push(row);
      }
    }

    result.pools.push(pool);

    res.send(result);
  });
});

app.post('/user',function(req, res) {
  winston.info('/user', req.body);

  var username = req.body.username;
  var team = req.body.team;
  var howKnown = req.body.howKnown;
  var countries = req.body.countries; // [country1, country2...]

  // validate the input

  if (username == null || team == null || countries == null) {
    res.status(400).send('Incomplete input');
    return;
  }

  if (countries.length != config.rules.countriesPerTeam) {
    res.status(400).send(config.rules.countriesPerTeam + ' countries required');
    return;
  }

  // use a single connection throughout so we can impose a transaction boundary
  connections.getConnection(function(err, connection) {
    connection.beginTransaction(function(err) {
      if (err) {
        res.status(500).send('Internal server error');
        winston.error(err);
        connection.release();
        return;
      }

      connection.query('SELECT * from countries WHERE name in (?)', [countries], function(err, rows, fields) {
        if (rows.length != countries.length) {
          res.status(400).send('Unknown country');
          return connection.rollback(function() {connection.release();});
        }

        var poolUsage = [];
        for (var i=0; i<config.rules.countriesPerPool.length; ++i) {
          poolUsage.push(0);
        }

        for (var j=0; j<rows.length; ++j) {
          poolUsage[rows[j].pool - 1]++;
        }

        for (var k=0; k<poolUsage.length; ++k) {
          if (poolUsage[k] != config.rules.countriesPerPool[k]) {
            res.status(400).send('Need ' + config.rules.countriesPerPool[k] + ' countries in pool ' + (k+1) + ", found " + poolUsage[k]);
            return connection.rollback(function() {connection.release();});
          }
        }

        connection.query('INSERT INTO users (name, how_known, team) VALUES (?, ?, ?)', [username, howKnown, team], function(err, rows, fields) {
          if (err) {
            if (err.sqlstate = 23000)
              res.status(400).send('Duplicate entry')
              else
              res.status(400).send('Cannot create user');
            winston.error(err);
            return connection.rollback(function() {connection.release();});
          }

          var insertValues = [];
          for (var i=0; i<countries.length; ++i)
            insertValues.push([team, countries[i]]);

          connection.query('INSERT INTO countries_on_teams (team, country) VALUES ?', [insertValues], function(err, rows, fields) {
            if (err) {
              res.status(400).send('Cannot add countries');
              winston.error(err);
              return connection.rollback(function() {connection.release();});
            }

            connection.query('CALL calculate_team_standings', function(err, rows, fields) {
              return connection.commit(function() {
                connection.release();
                res.send("OK");
              });
            });
          });
        });
      });
    });
  });
});

app.use(function(err, req, res, next) {
  winston.error(err.stack);
  res.status(500).send('Internal Server Error');
});

app.listen(config.port, function () {
  winston.info('api.js listening on port ' + config.port);
});

var handleExit = function() {
  winston.info('api.js shutting down');
  process.exit();
};

process.on('SIGINT', handleExit);
process.on('SIGTERM', handleExit);
process.on('exit', handleExit);
