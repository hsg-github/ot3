'use strict';

var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var TimeWindowedSchema = require('../shared/TimeWindowedSchema.model');

var TaskOrderSchema = new TimeWindowedSchema({
  name: {type: String, required: true},
  description: {type: String, required: true},
  _manager: {type: Schema.Types.ObjectId, ref: 'User', required: true},
  _contract: {type: Schema.Types.ObjectId, ref: 'Contract', required: true}
});

module.exports = mongoose.model('TaskOrder', TaskOrderSchema);
