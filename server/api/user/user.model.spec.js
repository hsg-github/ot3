'use strict';

var User = require('./user.model');

var user = {};

var buildUser = function () {
  return new User({
    provider: 'local',
    firstName: 'Fake',
    lastName: 'User',
    email: 'test@test.com',
    password: 'password'
  })
};

describe('User Model', function () {
  // Clear users before testing
  before(function (done) {
    User.remove().exec().then(function () {
      done();
    });
  });

  // Reset user object before each test
  beforeEach(function (done) {
    user = buildUser();
    done();
  });

  afterEach(function (done) {
    User.remove().exec().then(function () {
      done();
    });
  });

  it('should begin with no users', function (done) {
    User.find({}, function (err, users) {
      users.should.have.length(0);
      done();
    });
  });

  it('should fail when saving a duplicate user', function (done) {
    user.save(function () {
      var userDup = new User(user);
      userDup.save(function (err) {
        should.exist(err);
        done();
      });
    });
  });

  it('should fail when saving without an email', function (done) {
    user.email = '';
    user.save(function (err) {
      should.exist(err);
      done();
    });
  });

  it('should fail when saving with an invalid email', function (done) {
    user.email = '@this.com@is.not.valid123';
    user.save(function (err) {
      should.exist(err);
      done();
    });
  });

  it('should succeed when saving a valid User', function (done) {
    user.save(function (err) {
      should.not.exist(err);
      done();
    });
  });

  it("should authenticate user if password is valid", function () {
    return user.authenticate('password').should.be.true;
  });

  it("should not authenticate user if password is invalid", function () {
    return user.authenticate('blah').should.not.be.true;
  });
});

module.exports = user;
