'use strict';

var Project = require('./Project.model.js');

var projectBase = new Project({
  name: 'Project Test',
  description: 'The Project under test',
  startDate: new Date(2015, 11, 1, 0, 0, 0, 0),
  endDate: new Date(2015, 11, 15, 0, 0, 0, 0)
});

describe('Project model', function() {

  before(function(done) {
    // Clear objects before testing
    Project.remove().exec().then(function() {
      done();
    });
  });

  afterEach(function(done) {
    Project.remove().exec().then(function() {
      done();
    });
  });

  it('should begin with no objects', function(done) {
    Project.find({}, function(err, objects) {
      objects.should.have.length(0);
      done();
    });
  });

  // Test inherited params
  it('should not allow a caller to manually set lastUpdatedAt', function(done) {
    var project = new Project(projectBase);
    project.lastUpdatedAt = new Date(0);
    project.save(function(err, savedProject) {
      should.not.exist(err);
      savedProject.lastUpdatedAt.should.not.equal(new Date(0));
      done();
    });
  });

  it('should fail when saving a Project without a name', function(done) {
    var project = new Project(projectBase);
    (function(undefined) {
      project.name = undefined;
    })();
    project.save(function(err) {
      should.exist(err.errors.name);
      done();
    });
  });

  it('should fail when saving a Project without a description', function(done) {
    var project = new Project(projectBase);
    (function(undefined) {
      project.description = undefined;
    })();
    project.save(function(err) {
      should.exist(err.errors.description);
      done();
    });
  });

  it('should succeed when saving a valid Project', function(done) {
    var project = new Project(projectBase);
    project.save(function(err) {
      should.not.exist(err);
      done();
    });
  });
});
