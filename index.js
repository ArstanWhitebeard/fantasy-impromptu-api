var express = require('express');
var app = express();
var mysql = require('mysql');
var config = require('./config');

var connections = mysql.createPool(config.db);


app.get('/teamstandings/summary', function (req, res, next) {
    getTeamStandings(res, false);
});

app.get('/teamstandings/full', function (req, res, next) {
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
        position = previousRawRow.position;
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

app.use(function(err, req, res, next) {
  console.error(err.stack);
  res.status(500).send('Internal Server Error');
});

app.listen(3000, function () {
  console.log('Example app listening on port 3000!');
});
