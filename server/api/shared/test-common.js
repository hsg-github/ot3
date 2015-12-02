var app = require('../../app');
var request = require('supertest');
var mongoose = require('mongoose');

var chai = require("chai");
var chaiAsPromised = require("chai-as-promised");
should = chai.should();
chai.use(chaiAsPromised);

var Promise = require("bluebird");
//require('mongoose').Promise = Promise;
mongoose.Promise = global.Promise

//global.chaiAsPromised = chaiAsPromised;
//global.expect = chai.expect;
//global.AssertionError = chai.AssertionError;
//global.Assertion = chai.Assertion;
//global.assert = chai.assert;
//
//global.fulfilledPromise = Q.resolve;
//global.rejectedPromise = Q.reject;
//global.defer = Q.defer;
//global.waitAll = Q.all;

User = require('../user/user.model')
Project = require('../Project/Project.model')
Task = require('../Task/Task.model.coffee')
Timesheet = require('../Timesheet/Timesheet.model')
TimesheetEntry = require('../TimesheetEntry/TimesheetEntry.model.coffee')

removeAll = function() {
  User.remove().exec();
  Project.remove().exec();
  Timesheet.remove().exec();
  Task.remove().exec();
  TimesheetEntry.remove().exec();
}


