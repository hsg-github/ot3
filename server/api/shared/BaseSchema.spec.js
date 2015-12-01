//'use strict';
//
//var should = require('should');
//var app = require('../../app');
//var request = require('supertest');
//var BaseSchema = require('./BaseSchema.model');
//
//var obj = new BaseSchema({
//  createdAt: new Date(2015, 11, 1, 0, 0, 0, 0),
//  lastUpdatedAt: new Date(2015, 11, 15, 0, 0, 0, 0)
//});
//
//describe('BaseSchema model', function() {
//
//  before(function(done) {
//    // Clear objects before testing
//    BaseSchema.remove().exec().then(function() {
//      done();
//    });
//  });
//
//  afterEach(function(done) {
//    BaseSchema.remove().exec().then(function() {
//      done();
//    });
//  });
//
//  it('should begin with no objects', function(done) {
//    BaseSchema.find({}, function(err, objects) {
//      objects.should.have.length(0);
//      done();
//    });
//  });
//
//  it('should fail when saving a timesheet without a user', function(done) {
//    var timesheet = new Timesheet(timesheetBase);
//    // Must use closure here to safely set reference to undefined (See TypedArray.js, which sets the global 'undefined'
//    (function(undefined) {
//      timesheet._user = undefined;
//    })();
//    timesheet.save(function(err) {
//      should.exist(err.errors._user);
//      done();
//    });
//  });
//
//});
