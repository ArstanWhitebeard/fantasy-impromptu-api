var express = require('express');
var app = express();
var mysql      = require('mysql');

// TODO pull out config.js
// TODO set up read-only db user!
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : 'root',
  database : 'olympics2016'
});



app.get('/teamstandings/', function (req, res) {
  connection.connect();

  connection.query('SELECT * from team_standings ORDER BY points DESC, golds DESC, silvers DESC', function(err, rows, fields) {
    if (!err)
      res.send(rows);
    else
      res.send([]);
  });

  connection.end();

});

app.get('/countries/', function (req, res) {
  connection.connect();

  connection.query('SELECT * from countries ORDER BY pool ASC, last_olympics_score DESC', function(err, rows, fields) {
    if (!err) {
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

    }
    else
      res.send([]);
  });

  connection.end();

});

app.listen(3000, function () {
  console.log('Example app listening on port 3000!');
});
