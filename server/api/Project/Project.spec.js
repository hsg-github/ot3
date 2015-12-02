'use strict';

var should = require('should');
var app = require('../../app');
var request = require('supertest');
var Contract = require('./Project.model.js');

var contractBase = new Contract({
  name: 'a Project',
  description: 'a Project description',
  startDate: new Date(2015, 11, 1, 0, 0, 0, 0),
  endDate: new Date(2015, 11, 15, 0, 0, 0, 0)
});

describe('Contract model', function() {

  before(function(done) {
    // Clear objects before testing
    Contract.remove().exec().then(function() {
      done();
    });
  });

  afterEach(function(done) {
    Contract.remove().exec().then(function() {
      done();
    });
  });

  it('should begin with no objects', function(done) {
    Contract.find({}, function(err, objects) {
      objects.should.have.length(0);
      done();
    });
  });

  // Test inherited params
  it('should not allow a caller to manually set lastUpdatedAt', function(done) {
    var contract = new Contract(contractBase);
    contract.lastUpdatedAt = new Date(0);
    contract.save(function(err, savedContract) {
      should.not.exist(err);
      savedContract.lastUpdatedAt.should.not.equal(new Date(0));
      done();
    });
  });

  it('should fail when saving a Project without a name', function(done) {
    var contract = new Contract(contractBase);
    (function(undefined) {
      contract.name = undefined;
    })();
    contract.save(function(err) {
      should.exist(err.errors.name);
      done();
    });
  });

  it('should fail when saving a Project without a description', function(done) {
    var contract = new Contract(contractBase);
    (function(undefined) {
      contract.description = undefined;
    })();
    contract.save(function(err) {
      should.exist(err.errors.description);
      done();
    });
  });

  it('should succeed when saving a valid Project', function(done) {
    var contract = new Contract(contractBase);
    contract.save(function(err) {
      should.not.exist(err);
      done();
    });
  });
});
