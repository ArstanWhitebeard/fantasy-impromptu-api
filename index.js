var express = require('express');
var app = express();
var mysql = require('mysql');

// TODO pull out config.js
// TODO set up read-only db user!
var connections = mysql.createPool({
    connectionLimit : 10, //important
    host     : 'localhost',
    user     : 'root',
    password : 'root',
    database : 'olympics2016',
    debug    :  false
});


app.get('/teamstandings/summary', function (req, res, next) {
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

    res.send(result);
  });
});

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
