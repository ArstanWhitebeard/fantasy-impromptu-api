module.exports = {
  db : {
      connectionLimit : 10,
      host     : 'localhost',
      user     : 'api',
      password : 'r4ms4ysD0gs',
      database : 'olympics2016',
      debug    :  false
  },

  rules : {
    countriesPerTeam : 3,
    countriesPerPool : [1,2]
  },

  scrape : {
    url : "https://en.wikipedia.org/wiki/2012_Summer_Olympics_medal_table"
  }
};
