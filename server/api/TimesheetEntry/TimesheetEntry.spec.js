'use strict';

var should = require('should');
var app = require('../../app');
var request = require('supertest');
var TimesheetEntry = require('./TimesheetEntry.model');
var TaskOrder = require('../TaskOrder/TaskOrder.model');
var Timesheet = require('../timesheet/timesheet.model');

var timesheetEntry = new TimesheetEntry({
  taskOrderDescription: String,
  hours: Number,
  notes: String,
  dateWorked: Date,
  _timesheet: {type: Schema.Types.ObjectId, ref: 'Timesheet'},
  _taskOrder: {type: Schema.Types.ObjectId, ref: 'TaskOrder'}
});

describe('TimesheetEntry model', function() {

});
