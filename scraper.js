var request = require('request');
var cheerio = require('cheerio');
var mysql = require('mysql');
var config = require('./config').scraper;

var connections = mysql.createPool(config.db);

var url = config.url;

var nameCorrections = {
  "United States" : "USA"
};

var scrapeMedalsTable = function() {
  console.log(new Date(), "Beginning scrape from " + url);

  request(url, function(error, response, html) {
    if (error) {
      console.log(error);
      return;
    }

    var $ = cheerio.load(html);

    $('.wikitable').each(function(i, element) {
      if($(this).children('caption').html().indexOf("medal table") != -1) {
        var medalsTable = {"standings" : []};

        $(this).children('tr').each(function(i, element) {
          var tds = $(this).children('td');
          var country = $(this).children('th').children('a').html();
          if (country != null)
            country = country.replace(/["']/g, "");
          else
            return;
          var golds = parseInt(tds.slice(1).html());
          var silvers = parseInt(tds.slice(2).html());
          var bronzes = parseInt(tds.slice(3).html());

          medalsTable.standings.push({
            "country" : country,
            "golds" : golds,
            "silvers" : silvers,
            "bronzes" : bronzes
          });
        });

        // each() is synchronous so we can trust its callbacks have finished executing
        storeMedalsTable(medalsTable);
      }
    });
  });
};

var storeMedalsTable = function(medalTable) {
  // convert into nested array for multi-row INSERT
  var values = [];
  for (var i=0; i<medalTable.standings.length; ++i) {
    var row = medalTable.standings[i];

    if (nameCorrections[row.country] != null)
      row.country = nameCorrections[row.country];

    values.push([row.country, row.golds, row.silvers, row.bronzes]);
  }

  connections.getConnection(function(err, connection) {
    connection.beginTransaction(function(err) {
      if (err) {
        console.log(err);
        connection.release();
        return;
      }

      connection.query('DELETE FROM country_standings', function(err, rows) {
        if (err) {
          console.log(err);
          return connection.rollback(function() {connection.release();});
        }

        connection.query('INSERT INTO country_standings (country, golds, silvers, bronzes) VALUES ?', [values], function(err, rows) {
          if (err) {
            console.log(err);
            return connection.rollback(function() {connection.release();});
          }

          connection.query('CALL calculate_team_standings', function(err, rows, fields) {
            if (err) {
              console.log(err);
              return connection.rollback(function() {connection.release();});
            }

            return connection.commit(function() {
              console.log(new Date(), "Completed scrape");
              connection.release();
            });
          });
        });
      });
    });
  });
};

// run immediately on startup
scrapeMedalsTable();

// run periodically
setInterval(scrapeMedalsTable, config.interval);
