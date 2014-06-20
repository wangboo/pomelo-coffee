var pomelo = require('pomelo');
var mongoose = require('mongoose');
var fs = require('fs')

/**
* Init app for client.
*/
var app = pomelo.createApp();
app.set('name', 'pomelo-coffee');

// app configuration
app.configure('production|development', 'connector', function(){
  app.set('connectorConfig',
    {
      connector : pomelo.connectors.hybridconnector,
      heartbeat : 3,
      useDict : true,
      useProtobuf : true
    });
});

// start app
app.start();

process.on('uncaughtException', function (err) {
  console.error(' Caught exception: ' + err.stack);
});


mongoose.connect('mongodb://localhost/test');
var Schema = mongoose.Schema
app.mongoose = mongoose
app.models = {}

fs.readdirSync('./app/models/').forEach(function(file){
    require('./app/models/'+file)(app, mongoose, Schema)
})

mongoose.connection.on('error', function(err){
    console.log('err', err)
    app.stop()
})