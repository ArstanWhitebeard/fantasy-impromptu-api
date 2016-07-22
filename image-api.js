// API to receive a PMG image, then do nasty things to get it into Ghost as a new blog post.
// Ghost's public API doesn't currently support programmatic submission of posts,
// so this is reverse-engineered using DevTools and Ghost's own admin interface

var config = require('./config').image;
var express = require('express');
var app = express();
var bodyParser = require("body-parser");
var winston = require('winston');
var base64Img = require('base64-img');
var request = require('request');

if (config.logfile != null) {
  winston.add(winston.transports.File, { filename: config.logfile });
  winston.remove(winston.transports.Console);
} // else default to STDOUT

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json({limit: '50mb'}));

app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE');
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});


app.post('/upload',function(req, res) {
  winston.info('/upload', req.body);

  var title = req.body.title;
  var author = req.body.author;
  var age = req.body.age;

  if (title == null || author == null || age == null) {
    res.status(400).send({"message":'Incomplete input'});
    return;
  }

  var markdown = '#### "' + title + '" by ' + author + ', aged ' + age;

  // first, save the image to the filesystem so we can recover if all else fails
  var filename = Date.now() + (Math.random().toString(36).substring(7));
  var imageFile;
  try {
    imageFile = base64Img.imgSync(req.body.data, config.targetPath, filename);
  } catch (error) {
    winston.error(error);
    res.status(500).send({"message":'Internal server error'});
    return;
  }

  winston.info('Saved to ' + imageFile);

  // next, open a session in the ghost api
  var ghost = config.ghost;
  request({
    url : ghost.url + '/authentication/token',
    method : "POST",
    form : {
      grant_type: "password",
      username: ghost.username,
      password: ghost.password,
      client_id: ghost.clientId,
      client_secret: ghost.clientSecret
    }
  }, function(error, response, body) {
    if (error) {
      winston.error(error);
      res.status(500).send({"message":'Internal server error'});
      return;
    }

    var token = JSON.parse(body).access_token;

    if (token == null) {
      winston.error("no token");
      res.status(500).send({"message":'Internal server error'});
      return;
    }

    winston.info('Acquired token ', token.substr(0, 6) + '...');

    // now create a slug for our post
    request({
      url : ghost.url + '/slugs/post/' + filename,
      method : "GET",
      headers : {
        "Authorization" : "Bearer " + token
      }
    }, function(error, response, body) {
      if (error) {
        winston.error(error);
        res.status(500).send({"message":'Internal server error'});
        return;
      }

      winston.info('Created slug ' + filename);

      // now create the post, and link it to the file we already saved
      request({
        url : ghost.url + '/posts/?include=tags',
        method : "POST",
        json: true,
        headers : {
          "Authorization" : "Bearer " + token
        },
        body : {
          "posts":[
            {"title":title,
            "slug":filename,
            "markdown":markdown,
            "image":ghost.imagePath + "/" + filename + '.png',
            "featured":true,
            "page":false,
            "status":"published",
            "language":"en_US",
            "meta_title":null,
            "meta_description":null,
            "author":ghost.author,
            "publishedBy":null,
            "tags":[]
          }
        ]}
      }, function(error, response, body) {
        if (error) {
          winston.error(error);
          res.status(500).send({"message":'Internal server error'});
          return;
        }

        res.status(200).send({});
      });
    });
  });
});

app.use(function(err, req, res, next) {
  winston.error(err.stack);
  res.status(500).send('Internal Server Error');
});

app.listen(config.port, function () {
  winston.info('image-api.js listening on port ' + config.port);
});

// var handleExit = function() {
//   winston.info('image-api.js shutting down');
//   process.exit();
// };
//
// process.on('SIGINT', handleExit);
// process.on('SIGTERM', handleExit);
// process.on('exit', handleExit);
