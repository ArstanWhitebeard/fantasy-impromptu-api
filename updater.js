var request = require('request');
var cheerio = require('cheerio');
var mysql = require('mysql');
var config = require('./config');

var connections = mysql.createPool(config.db);

var url = config.scrape.url;

var nameCorrections = {
  "United States" : "USA"
};

var medalsTable = { standings:
   [ { country: 'United States', golds: 46, silvers: 28, bronzes: 29 },
     { country: 'China', golds: 38, silvers: 29, bronzes: 21 },
     { country: 'Great Britain', golds: 29, silvers: 17, bronzes: 19 },
     { country: 'Russia', golds: 22, silvers: 25, bronzes: 32 },
     { country: 'South Korea', golds: 13, silvers: 8, bronzes: 7 },
     { country: 'Germany', golds: 11, silvers: 19, bronzes: 14 },
     { country: 'France', golds: 11, silvers: 11, bronzes: 12 },
     { country: 'Australia', golds: 8, silvers: 15, bronzes: 12 },
     { country: 'Italy', golds: 8, silvers: 9, bronzes: 11 },
     { country: 'Hungary', golds: 8, silvers: 4, bronzes: 6 },
     { country: 'Japan', golds: 7, silvers: 14, bronzes: 17 },
     { country: 'Kazakhstan', golds: 7, silvers: 1, bronzes: 5 },
     { country: 'Netherlands', golds: 6, silvers: 6, bronzes: 8 },
     { country: 'Ukraine', golds: 6, silvers: 5, bronzes: 9 },
     { country: 'New Zealand', golds: 6, silvers: 2, bronzes: 5 },
     { country: 'Cuba', golds: 5, silvers: 3, bronzes: 7 },
     { country: 'Iran', golds: 4, silvers: 5, bronzes: 3 },
     { country: 'Jamaica', golds: 4, silvers: 4, bronzes: 4 },
     { country: 'Czech Republic', golds: 4, silvers: 3, bronzes: 3 },
     { country: 'North Korea', golds: 4, silvers: 0, bronzes: 2 },
     { country: 'Spain', golds: 3, silvers: 10, bronzes: 4 },
     { country: 'Brazil', golds: 3, silvers: 5, bronzes: 9 },
     { country: 'South Africa', golds: 3, silvers: 2, bronzes: 1 },
     { country: 'Ethiopia', golds: 3, silvers: 1, bronzes: 3 },
     { country: 'Croatia', golds: 3, silvers: 1, bronzes: 2 },
     { country: 'Belarus', golds: 2, silvers: 5, bronzes: 5 },
     { country: 'Romania', golds: 2, silvers: 5, bronzes: 2 },
     { country: 'Kenya', golds: 2, silvers: 4, bronzes: 5 },
     { country: 'Denmark', golds: 2, silvers: 4, bronzes: 3 },
     { country: 'Azerbaijan', golds: 2, silvers: 2, bronzes: 6 },
     { country: 'Poland', golds: 2, silvers: 6, bronzes: 10 },
     { country: 'Turkey', golds: 2, silvers: 2, bronzes: 1 },
     { country: 'Switzerland', golds: 2, silvers: 2, bronzes: 0 },
     { country: 'Lithuania', golds: 2, silvers: 1, bronzes: 2 },
     { country: 'Norway', golds: 2, silvers: 1, bronzes: 1 },
     { country: 'Canada', golds: 1, silvers: 5, bronzes: 12 },
     { country: 'Sweden', golds: 1, silvers: 4, bronzes: 3 },
     { country: 'Colombia', golds: 1, silvers: 3, bronzes: 4 },
     { country: 'Georgia', golds: 1, silvers: 3, bronzes: 3 },
     { country: 'Mexico', golds: 3, silvers: 3, bronzes: 7 },
     { country: 'Ireland', golds: 1, silvers: 1, bronzes: 4 },
     { country: 'Argentina', golds: 1, silvers: 1, bronzes: 2 },
     { country: 'Serbia', golds: 1, silvers: 2, bronzes: 4 },
     { country: 'Slovenia', golds: 1, silvers: 2, bronzes: 4 },
     { country: 'Tunisia', golds: 2, silvers: 0, bronzes: 1 },
     { country: 'Dominican Republic',
       golds: 1,
       silvers: 1,
       bronzes: 0 },
     { country: 'Trinidad and Tobago',
       golds: 1,
       silvers: 0,
       bronzes: 3 },
     { country: 'Uzbekistan', golds: 1, silvers: 0, bronzes: 2 },
     { country: 'Latvia', golds: 1, silvers: 0, bronzes: 1 },
     { country: 'Algeria', golds: 1, silvers: 0, bronzes: 0 },
     { country: 'Bahamas', golds: 0, silvers: 0, bronzes: 1 },
     { country: 'Grenada', golds: 0, silvers: 0, bronzes: 1 },
     { country: 'Uganda', golds: 0, silvers: 0, bronzes: 1 },
     { country: 'Venezuela', golds: 0, silvers: 0, bronzes: 1 },
     { country: 'India', golds: 0, silvers: 2, bronzes: 4 },
     { country: 'Mongolia', golds: 0, silvers: 2, bronzes: 3 },
     { country: 'Thailand', golds: 0, silvers: 2, bronzes: 1 },
     { country: 'Egypt', golds: 0, silvers: 2, bronzes: 0 },
     { country: 'Slovakia', golds: 0, silvers: 1, bronzes: 3 },
     { country: 'Armenia', golds: 0, silvers: 1, bronzes: 2 },
     { country: 'Belgium', golds: 1, silvers: 2, bronzes: 3 },
     { country: 'Finland', golds: 1, silvers: 2, bronzes: 3 },
     { country: 'Bulgaria', golds: 0, silvers: 1, bronzes: 1 },
     { country: 'Estonia', golds: 1, silvers: 1, bronzes: 2 },
     { country: 'Indonesia', golds: 1, silvers: 1, bronzes: 2 },
     { country: 'Malaysia', golds: 1, silvers: 1, bronzes: 2 },
     { country: 'Puerto Rico', golds: 1, silvers: 1, bronzes: 2 },
     { country: 'Chinese Taipei', golds: 1, silvers: 1, bronzes: 2 },
     { country: 'Botswana', golds: 0, silvers: 1, bronzes: 0 },
     { country: 'Cyprus', golds: 1, silvers: 0, bronzes: 1 },
     { country: 'Gabon', golds: 1, silvers: 0, bronzes: 1 },
     { country: 'Guatemala', golds: 1, silvers: 0, bronzes: 1 },
     { country: 'Montenegro', golds: 1, silvers: 0, bronzes: 1 },
     { country: 'Portugal', golds: 1, silvers: 0, bronzes: 1 },
     { country: 'Greece', golds: 0, silvers: 0, bronzes: 2 },
     { country: 'Moldova', golds: 0, silvers: 2, bronzes: 2 },
     { country: 'Qatar', golds: 0, silvers: 2, bronzes: 2 },
     { country: 'Singapore', golds: 0, silvers: 2, bronzes: 2 },
     { country: 'Afghanistan', golds: 0, silvers: 0, bronzes: 1 },
     { country: 'Bahrain', golds: 0, silvers: 1, bronzes: 1 },
     { country: 'Hong Kong', golds: 0, silvers: 1, bronzes: 1 },
     { country: 'Saudi Arabia', golds: 0, silvers: 1, bronzes: 1 },
     { country: 'Kuwait', golds: 0, silvers: 1, bronzes: 1 },
     { country: 'Morocco', golds: 0, silvers: 1, bronzes: 1 },
     { country: 'Tajikistan', golds: 0, silvers: 1, bronzes: 1 } ] };

var scrapeMedalsTable = function() {
  request(url, function(error, response, html) {
    if (error) {
      console.log(error);
      return;
    }

    var $ = cheerio.load(html);

    var medalTable = {"standings" : []};

    $('.wikitable').filter(function(i, element) {
      if($(this).children('caption').html().indexOf("medal table") != -1) {
        $(this).children('tr').filter(function(i, element) {
          var tds = $(this).children('td');
          var country = $(this).children('th').children('a').html();
          if (country != null)
            country = country.replace(/["']/g, "");
          else
            return;
          var golds = parseInt(tds.slice(1).html());
          var silvers = parseInt(tds.slice(2).html());
          var bronzes = parseInt(tds.slice(3).html());

          medalTable.standings.push({
            "country" : country,
            "golds" : golds,
            "silvers" : silvers,
            "bronzes" : bronzes
          });
        });
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
              connection.release();
            });
          });
        });
      });
    });
  });
};

storeMedalsTable(medalsTable);
