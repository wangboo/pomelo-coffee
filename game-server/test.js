var mongoose = require('mongoose');
var fs = require('fs')
mongoose.connect('mongodb://localhost/test');

var Schema = mongoose.Schema

var app = {}
app.models = {}
fs.readdirSync('./app/models/').forEach(function(file){
    require('./app/models/'+file)(app, mongoose, Schema)
})

mongoose.connection.on('error', function(err){
    console.log('err', err)
})

var UserBase = mongoose.model('UserBase')
// UserBase.create({username: 'wangbo', password: '0000'}, function(err, user) {
//     if(err) {
//         console.log(err)
//     } else {
//         console.log(user)
//     }
// })

