'use strict';

var Timesheet = require('./Timesheet.model.js');
var User = require('../user/user.model');
//var fakeUser = require('../user/user.model.spec');

var regularUser = new User({
  provider: 'local',
  firstName: 'Regular',
  lastName: 'User',
  email: 'regularUser@test.com',
  password: 'password'
});

var supervisor = new User({
  provider: 'local',
  firstName: 'Supervisor',
  lastName: 'User',
  email: 'supervisor@test.com',
  password: 'password'
});

var timesheetBase = new Timesheet({
  _user: {},
  _supervisor: {},
  startDate: new Date(2015, 11, 1, 0, 0, 0, 0),
  endDate: new Date(2015, 11, 15, 0, 0, 0, 0),
  submitted: true,
  approved: false
});

describe('Timesheets model', function() {

  before(function(done) {
    // Clear users & timesheets before testing
    User.remove().exec().then(function() {
      done();
    });
    Timesheet.remove().exec().then(function() {
      done();
    });

    // Create users
    regularUser.save(function(err, user) {
      if (err) return done(err);
      else {
        regularUser = new User(user);
        timesheetBase._user = regularUser._id;
      }
    });
    supervisor.save(function(err, user) {
      if (err) return done(err);
      else {
        supervisor = new User(user);
        timesheetBase._supervisor = supervisor._id;
      }
    });
  });

  afterEach(function(done) {
    //done();
    Timesheet.remove().exec().then(function() {
      done();
    });
  });

  it('should begin with two users', function(done) {
    User.find({}, function(err, users) {
      users.should.have.length(2);
      done();
    });
  });

  it('should begin with no timesheets', function(done) {
    Timesheet.find({}, function(err, timesheets) {
      timesheets.should.have.length(0);
      done();
    });
  });

  it('should fail when saving a Timesheet without a user', function(done) {
    var timesheet = new Timesheet(timesheetBase);
    // Must use closure here to safely set reference to undefined (See TypedArray.js, which sets the global 'undefined'
    (function(undefined) {
      timesheet._user = undefined;
    })();
    timesheet.save(function(err) {
      should.exist(err.errors._user);
      done();
    });
  });

  it('should fail when saving a Timesheet without a supervisor', function(done) {
    var timesheet = new Timesheet(timesheetBase);
    // Must use closure here to safely set reference to undefined (See TypedArray.js, which sets the global 'undefined'
    (function(undefined) {
      timesheet._supervisor = undefined;
    })();
    timesheet.save(function(err) {
      should.exist(err.errors._supervisor);
      done();
    });
  });

  it('should fail when saving a Timesheet which has been approved but has not been submitted', function(done) {
    var timesheet = new Timesheet(timesheetBase);
    timesheet.approved = true;
    timesheet.submitted = false;
    timesheet.save(function(err) {
      should.exist(err.errors.approved);
      done();
    });
  });

  it('should fail when saving a Timesheet with a startDate later than the endDate', function(done) {
    var timesheet = new Timesheet(timesheetBase);
    timesheet.startDate = new Date(timesheet.endDate.getTime() + 1);
    timesheet.save(function(err) {
      should.exist(err.errors.startDate);
      done();
    });
  });

  it('should succeed when saving a valid Timesheet', function(done) {
    var timesheet = new Timesheet(timesheetBase);
    timesheet._user = regularUser._id;
    timesheet._supervisor = supervisor._id;
    timesheet.save(function(err) {
      should.not.exist(err);

      // Also make sure we can populate() a model reference
      Timesheet
        .findOne({ _user: regularUser._id })
        .populate('_user')
        .exec(function (err, populatedTimesheet) {
          if (err) return done(err);
          populatedTimesheet._user.firstName.should.equal('Regular');
        });
      done();
    });
  });

});
