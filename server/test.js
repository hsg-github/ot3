'use strict';

// Set default node environment to development
process.env.NODE_ENV = process.env.NODE_ENV || 'development';

var mongoose = require('mongoose');
var config = require('./config/environment');

// Connect to database
console.log('connecting to mongo...')
mongoose.connect(config.mongo.uri, config.mongo.options);
mongoose.connection.on('error', function(err) {
    console.error('MongoDB connection error: ' + err);
    process.exit(-1);
  }
);

//var Thing = require('./api/thing/thing.model')
//var aThing = new Thing({
//  name: 'a name',
//  info: 'some info',
//  active: true
//});
//
//aThing.save(function (err, thing) {
//  if (err) console.log('thing error: ' + err);
//});

var Timesheet = require('./api/Timesheet/Timesheet.model.js')
console.log('saving Timesheet')
Timesheet.create({
  submitted: false,
  startDate: new Date(),
  endDate: new Date(),
  extraArg: 'asd',
  createdAt: new Date()
}, function(err, timesheet) {
  if (err) console.log('Timesheet error: ' + err);
});
