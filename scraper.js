var request = require('request');
var cheerio = require('cheerio');
var mysql = require('mysql');
var config = require('./config').scraper;
var winston = require('winston');

if (config.logfile != null) {
  winston.add(winston.transports.File, { filename: config.logfile });
  winston.remove(winston.transports.Console);
} // else default to STDOUT


var connections = mysql.createPool(config.db);

var scrapeMedalsTable = function() {
  winston.info(new Date(), "Beginning scrape from " + config.url);

  request(config.url, function(error, response, html) {
    if (error) {
      winston.error(error);
      return;
    }

    var $ = cheerio.load(html);

    if ($('.wikitable').length == 0) {
      winston.error("Unable to find .wikitable in scraped html");
      return;
    }

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
        if (medalsTable.standings.length == 0) {
          winston.error("No data found in scraped html");
          return;
        } else {
          return storeMedalsTable(medalsTable);
        }
      }
    });
  });
};

var storeMedalsTable = function(medalTable) {
  // convert into nested array for multi-row INSERT
  var values = [];
  for (var i=0; i<medalTable.standings.length; ++i) {
    var row = medalTable.standings[i];

    if (config.nameCorrections[row.country] != null)
      row.country = config.nameCorrections[row.country];

    values.push([row.country, row.golds, row.silvers, row.bronzes]);
  }

  connections.getConnection(function(err, connection) {
    connection.beginTransaction(function(err) {
      if (err) {
        winston.error(err);
        connection.release();
        return;
      }

      connection.query('DELETE FROM country_standings', function(err, rows) {
        if (err) {
          winston.error(err);
          return connection.rollback(function() {connection.release();});
        }

        connection.query('INSERT INTO country_standings (country, golds, silvers, bronzes) VALUES ?', [values], function(err, rows) {
          if (err) {
            winston.error(err);
            return connection.rollback(function() {connection.release();});
          }

          connection.query('CALL calculate_team_standings', function(err, rows, fields) {
            if (err) {
              winston.error(err);
              return connection.rollback(function() {connection.release();});
            }

            return connection.commit(function() {
              winston.info(new Date(), "Completed scrape");
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


var handleExit = function() {
  winston.info('scraper.js shutting down');
  process.exit();
};

process.on('SIGINT', handleExit);
process.on('SIGTERM', handleExit);
process.on('exit', handleExit);
