// API to receive a PMG image, then do nasty things to get it into Ghost as a new blog post.
// Ghost's public API doesn't currently support programmatic submission of posts,
// so this is reverse-engineered using DevTools and Ghost's own admin interface

var config = require('./config').image;
var express = require('express');
var app = express();
var bodyParser = require("body-parser");
var winston = require('winston');
var base64Img = require('base64-img');

if (config.logfile != null) {
  winston.add(winston.transports.File, { filename: config.logfile });
  winston.remove(winston.transports.Console);
} // else default to STDOUT

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE');
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});


app.post('/upload',function(req, res) {
  winston.info('/upload', req.body);

  var filepath = base64Img.imgSync(req.body.data, 'data', '2');

  res.status(200).send({});
});

app.use(function(err, req, res, next) {
  winston.error(err.stack);
  res.status(500).send('Internal Server Error');
});

app.listen(config.port, function () {
  winston.info('image-api.js listening on port ' + config.port);
});

var handleExit = function() {
  winston.info('image-api.js shutting down');
  process.exit();
};

process.on('SIGINT', handleExit);
process.on('SIGTERM', handleExit);
process.on('exit', handleExit);
