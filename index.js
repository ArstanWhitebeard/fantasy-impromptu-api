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



app.get('/', function (req, res) {
  connection.connect();

  connection.query('SELECT * from team_standings ORDER BY points DESC, golds DESC, silvers DESC', function(err, rows, fields) {
    if (!err)
      res.send(rows);
    else
      res.send([]);
  });

  connection.end();

});

app.listen(3000, function () {
  console.log('Example app listening on port 3000!');
});
