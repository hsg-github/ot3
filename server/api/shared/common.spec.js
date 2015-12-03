var app = require('../../app');
var request = require('supertest');
var mongoose = require('mongoose');

var chai = require("chai");
var chaiAsPromised = require("chai-as-promised");
should = chai.should();
expect = chai.expect;
chai.use(chaiAsPromised);
//chai.config.includeStack = true;

var Bluebird = require("bluebird");
require('mongoose').Promise = Bluebird;
Bluebird.onPossiblyUnhandledRejection(function(){});
//mongoose.Promise = global.Promise;

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

User = require('../user/user.model');
Project = require('../Project/Project.model');
Task = require('../Task/Task.model.coffee');
Timesheet = require('../Timesheet/Timesheet.model.coffee');
TimesheetEntry = require('../TimesheetEntry/TimesheetEntry.model.coffee');

removeAll = function() {
  User.remove().exec();
  Project.remove().exec();
  Timesheet.remove().exec();
  Task.remove().exec();
  TimesheetEntry.remove().exec();
};


