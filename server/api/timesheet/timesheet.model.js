'use strict';

var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var ObjectId = Schema.Types.ObjectId;
var TimeWindowedSchema = require('../shared/TimeWindowedSchema.model');

var TimesheetSchema = new TimeWindowedSchema({
  _user: {type: ObjectId, ref: 'User', required: true},
  _supervisor: {type: ObjectId, ref: 'User', required: true},
  //startDate: {type: Date, required: true},
  //endDate: {type: Date, required: true},
  submitted: Boolean,
  approved: Boolean
});

// Validate start/end dates
//TimesheetSchema
//  .path('startDate')
//  .validate(function(startDate) {
//    return (startDate < this.endDate);
//  }, 'startDate must preceed endDate');

// Validate approved state
TimesheetSchema
  .path('approved')
  .validate(function(approved) {
    return this.submitted || (!this.submitted && !approved);
  }, 'cannot approved if not submitted');

module.exports = mongoose.model('Timesheet', TimesheetSchema);
