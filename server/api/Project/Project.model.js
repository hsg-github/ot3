'use strict';

var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var TimeWindowedSchema = require('../shared/TimeWindowedSchema.model');

var ContractSchema = new TimeWindowedSchema({
  name: {type: String, required: true},
  description: {type: String, required: true}
});

module.exports = mongoose.model('Contract', ContractSchema);
