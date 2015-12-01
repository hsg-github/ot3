'use strict';

// Configure mongoose inheritance
var util = require('util');
var mongoose = require('mongoose');
var BaseSchema = require('./BaseSchema.model');
var x;

function TimeWindowedSchema() {
  BaseSchema.apply(this, arguments);
  this.add({
    startDate:  {
      type: Date,
      required: true
      //validate: {
      //  validator: function(startDate) {
      //    return (startDate < this.endDate);
      //  },
      //  message: 'startDate must preceed endDate'
      //}
    },
    endDate: {type: Date, required: true}
  });

  // Validate start/end dates
  this
    .path('startDate')
    .validate(function(startDate) {
      return (startDate < this.endDate);
    }, 'startDate must preceed endDate');
}
util.inherits(TimeWindowedSchema, BaseSchema);

module.exports = TimeWindowedSchema;
