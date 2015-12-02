'use strict';

var should = require('should');
var app = require('../../app');
var request = require('supertest');
var TimesheetEntry = require('./TimesheetEntry.model');
var Task = require('../Task/Task.model');
var Timesheet = require('../Timesheet/Timesheet.model');

//var timesheetEntry = new TimesheetEntry({
//  taskOrderDescription: String,
//  hours: Number,
//  notes: String,
//  dateWorked: Date,
//  _timesheet: {type: Schema.Types.ObjectId, ref: 'Timesheet'},
//  _taskOrder: {type: Schema.Types.ObjectId, ref: 'Task'}
//});

describe('TimesheetEntry model', function() {

});
