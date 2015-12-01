'use strict';

var mongoose = require('mongoose');
var Schema = mongoose.Schema;
var BaseSchema = require('../shared/BaseSchema.model');

var TimesheetEntrySchema = new BaseSchema({
  description: String,
  hours: Number,
  notes: String,
  dateWorked: Date,
  _timesheet: {type: Schema.Types.ObjectId, ref: 'Timesheet'},
  _taskOrder: {type: Schema.Types.ObjectId, ref: 'TaskOrder'}
});

module.exports = mongoose.model('TimesheetEntry', TimesheetEntrySchema);
