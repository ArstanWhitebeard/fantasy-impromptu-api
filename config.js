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
  }
};
