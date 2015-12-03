# Set default node environment to development
process.env.NODE_ENV = process.env.NODE_ENV or 'development'

require 'coffee-script/register'
express = require('express')
mongoose = require('mongoose')
config = require('./environment')
Promise = require("bluebird");
mongoose.Promise = Promise;
#mongoose.Promise = global.Promise;

# Connect to database
mongoose.connect config.mongo.uri, config.mongo.options
mongoose.connection.on 'error', (err) ->
  console.error 'MongoDB connection error: ' + err
  process.exit -1

require('./seed')
