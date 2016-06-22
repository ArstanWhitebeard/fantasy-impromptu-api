var request = require('request');
var cheerio = require('cheerio');
var config = require('./config');

var url = config.scrape.url;

request(url, function(error, response, html) {
  if (error) {
    console.log(error);
    return;
  }

  var $ = cheerio.load(html);

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

        console.log(i, country, golds, silvers, bronzes);
      });
    }
  });
});
