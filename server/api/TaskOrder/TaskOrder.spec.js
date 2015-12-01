'use strict';

var should = require('should');
var app = require('../../app');
var request = require('supertest');
var TaskOrder = require('./TaskOrder.model');
var User = require('../user/user.model');
var Contract = require('../contract/contract.model');

var taskOrderBase = new TaskOrder({
  name: 'a task order',
  description: 'a task order description',
  startDate: new Date(2015, 11, 1, 0, 0, 0, 0),
  endDate: new Date(2015, 11, 15, 0, 0, 0, 0),
  _manager: {},
  _contract: {}
});

var manager = new User({
  provider: 'local',
  firstName: 'Task Order Manager',
  lastName: 'User',
  email: 'manager@test.com',
  password: 'password'
});

var contract = new Contract({
  name: 'a contract',
  description: 'a contract description',
  startDate: new Date(2015, 0, 1, 0, 0, 0, 0),
  endDate: new Date(2015, 11, 31, 0, 0, 0, 0)
});

// TODO: Validate task order dates fall within contract date

describe('TaskOrder model', function() {

  before(function(done) {
    // Clear objects before testing
    User.remove().exec().then(function() {
      done();
    });
    TaskOrder.remove().exec().then(function() {
      done();
    });
    Contract.remove().exec().then(function() {
      done();
    });

    // Create manager
    manager.save(function(err, user) {
      if (err) return done(err);
      else {
        manager = new User(user);
        taskOrderBase._manager = manager._id;
      }
    });
    // Create contract
    contract.save(function(err, saved) {
      if (err) return done(err);
      else {
        contract = new Contract(saved);
        taskOrderBase._contract = contract._id;
      }
    });
  });

  afterEach(function(done) {
    TaskOrder.remove().exec().then(function() {
      done();
    });
  });

  it('should begin with no objects', function(done) {
    TaskOrder.find({}, function(err, objects) {
      objects.should.have.length(0);
      done();
    });
  });

  it('should fail when saving a Task Order without a name', function(done) {
    var taskOrder = new TaskOrder(taskOrderBase);
    (function(undefined) {
      taskOrder.name = undefined;
    })();
    taskOrder.save(function(err) {
      should.exist(err.errors.name);
      done();
    });
  });

  it('should fail when saving a Task Order without a description', function(done) {
    var taskOrder = new TaskOrder(taskOrderBase);
    (function(undefined) {
      taskOrder.description = undefined;
    })();
    taskOrder.save(function(err) {
      should.exist(err.errors.description);
      done();
    });
  });

  it('should fail when saving a Task Order without a manager', function(done) {
    var taskOrder = new TaskOrder(taskOrderBase);
    // Must use closure here to safely set reference to undefined (See TypedArray.js, which sets the global 'undefined'
    (function(undefined) {
      taskOrder._manager = undefined;
    })();
    taskOrder.save(function(err) {
      should.exist(err.errors._manager);
      done();
    });
  });

  it('should fail when saving a Task Order without a contract', function(done) {
    var taskOrder = new TaskOrder(taskOrderBase);
    // Must use closure here to safely set reference to undefined (See TypedArray.js, which sets the global 'undefined'
    (function(undefined) {
      taskOrder._contract = undefined;
    })();
    taskOrder.save(function(err) {
      should.exist(err.errors._contract);
      done();
    });
  });

  it('should succeed when saving a valid Task Order', function(done) {
    var taskOrder = new TaskOrder(taskOrderBase);
    taskOrder._contract = contract._id;
    taskOrder._manager = manager._id;
    taskOrder.save(function(err, savedTaskOrder) {
      should.not.exist(err);

      // Also make sure we can populate() a model reference
      TaskOrder
        .findById(savedTaskOrder._id)
        .populate('_contract')
        .populate('_manager')
        .exec(function (err, populatedTaskOrder) {
          if (err) return done(err);
          populatedTaskOrder._contract.name.should.equal(contract.name);
          populatedTaskOrder._manager.firstName.should.equal(manager.firstName);
        });
      done();
    });
  });

});
