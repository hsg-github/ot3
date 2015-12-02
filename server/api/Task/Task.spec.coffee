'use strict';

var should = require('should');
var app = require('../../app');
var request = require('supertest');
var Task = require('./Task.model.js');
var User = require('../user/user.model');
var Project = require('../Project/Project.model.js');

var taskBase = new Task({
  name: 'a task',
  description: 'a task description',
  startDate: new Date(2015, 11, 1, 0, 0, 0, 0),
  endDate: new Date(2015, 11, 15, 0, 0, 0, 0),
  _manager: {},
  _contract: {}
});

var manager = new User({
  provider: 'local',
  firstName: 'Task Manager',
  lastName: 'User',
  email: 'manager@test.com',
  password: 'password'
});

var project = new Project({
  name: 'a Project',
  description: 'a Project description',
  startDate: new Date(2015, 0, 1, 0, 0, 0, 0),
  endDate: new Date(2015, 11, 31, 0, 0, 0, 0)
});

// TODO: Validate task dates fall within Project date

describe('Task model', function() {

  before(function(done) {
    // Clear objects before testing
    User.remove().exec().then(function() {
      done();
    });
    Task.remove().exec().then(function() {
      done();
    });
    Project.remove().exec().then(function() {
      done();
    });

    // Create manager
    manager.save(function(err, user) {
      if (err) return done(err);
      else {
        manager = new User(user);
        taskBase._manager = manager._id;
      }
    });
    // Create Project
    project.save(function(err, saved) {
      if (err) return done(err);
      else {
        project = new Project(saved);
        taskBase._contract = project._id;
      }
    });
  });

  afterEach(function(done) {
    Task.remove().exec().then(function() {
      done();
    });
  });

  it('should begin with no objects', function(done) {
    Task.find({}, function(err, objects) {
      objects.should.have.length(0);
      done();
    });
  });

  it('should fail when saving a Task without a name', function(done) {
    var task = new Task(taskBase);
    (function(undefined) {
      task.name = undefined;
    })();
    task.save(function(err) {
      should.exist(err.errors.name);
      done();
    });
  });

  it('should fail when saving a Task without a description', function(done) {
    var task = new Task(taskBase);
    (function(undefined) {
      task.description = undefined;
    })();
    task.save(function(err) {
      should.exist(err.errors.description);
      done();
    });
  });

  it('should fail when saving a Task without a manager', function(done) {
    var task = new Task(taskBase);
    // Must use closure here to safely set reference to undefined (See TypedArray.js, which sets the global 'undefined'
    (function(undefined) {
      task._manager = undefined;
    })();
    task.save(function(err) {
      should.exist(err.errors._manager);
      done();
    });
  });

  it('should fail when saving a Task without a Project', function(done) {
    var task = new Task(taskBase);
    // Must use closure here to safely set reference to undefined (See TypedArray.js, which sets the global 'undefined'
    (function(undefined) {
      task._contract = undefined;
    })();
    task.save(function(err) {
      should.exist(err.errors._contract);
      done();
    });
  });

  it('should succeed when saving a valid Task', function(done) {
    var task = new Task(taskBase);
    task._contract = project._id;
    task._manager = manager._id;
    task.save(function(err, savedTask) {
      should.not.exist(err);

      // Also make sure we can populate() a model reference
      Task
        .findById(savedTask._id)
        .populate('_contract')
        .populate('_manager')
        .exec(function (err, populatedTask) {
          if (err) return done(err);
          populatedTask._contract.name.should.equal(project.name);
          populatedTask._manager.firstName.should.equal(manager.firstName);
        });
      done();
    });
  });

});
