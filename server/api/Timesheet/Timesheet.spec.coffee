'use strict'

Timesheet = require('./Timesheet.model.coffee')
User = require('../user/user.model')

regularUser = new User(
  provider: 'local'
  firstName: 'Regular'
  lastName: 'User'
  email: 'regularUser@test.com'
  password: 'password')
supervisor = new User(
  provider: 'local'
  firstName: 'Supervisor'
  lastName: 'User'
  email: 'supervisor@test.com'
  password: 'password')
timesheetBase = new Timesheet(
  _user: {}
  _supervisor: {}
  startDate: new Date(2015, 11, 1, 0, 0, 0, 0)
  endDate: new Date(2015, 11, 15, 0, 0, 0, 0)
  submitted: true
  approved: false)

describe 'Timesheets model', ->

  before () ->
    removeAll()

    # Create users
    regularUser.save().then((saved) ->
      timesheetBase._user = regularUser._id
    ).then(() ->
      supervisor.save(() ->
        timesheetBase._supervisor = supervisor._id
      )
    )

  afterEach () ->
    Timesheet.remove().exec()

  it 'should begin with 1 Project', () ->
    return User.find({}).should.eventually.have.length(2)

  it 'should begin with 0 Timesheets', () ->
    return Timesheet.find({}).should.eventually.have.length(0)

  it 'should fail when saving a Timesheet without a user', (done) ->
    timesheet = new Timesheet(timesheetBase)
    # Must use closure here to safely set reference to undefined (See TypedArray.js, which sets the global 'undefined'
    (->
      timesheet._user = undefined
    )()
    timesheet.save ((err) ->
      should.exist err.errors._user
      done()
    )

  it 'should fail when saving a Timesheet without a supervisor', (done) ->
    timesheet = new Timesheet(timesheetBase)
    # Must use closure here to safely set reference to undefined (See TypedArray.js, which sets the global 'undefined'
    (->
      timesheet._supervisor = undefined
    )()
    timesheet.save ((err) ->
      should.exist err.errors._supervisor
      done()
    )

  it 'should fail when saving a Timesheet which has been approved but has not been submitted', (done) ->
    timesheet = new Timesheet(timesheetBase)
    timesheet.approved = true
    timesheet.submitted = false
    timesheet.save ((err) ->
      should.exist err.errors.approved
      done()
    )

  it 'should fail when saving a Timesheet with a startDate later than the endDate', (done) ->
    timesheet = new Timesheet(timesheetBase)
    timesheet.startDate = new Date(timesheet.endDate.getTime() + 1)
    timesheet.save ((err) ->
      should.exist err.errors.startDate
      done()
    )

  it 'should succeed when saving a valid Timesheet', (done) ->
    timesheet = new Timesheet(timesheetBase)
    timesheet._user = regularUser._id
    timesheet._supervisor = supervisor._id
    timesheet.save ((err) ->
      should.not.exist err
      # Also make sure we can populate() a model reference
      Timesheet.findOne(_user: regularUser._id).populate('_user').exec (err, populatedTimesheet) ->
        if err
          return done(err)
        populatedTimesheet._user.firstName.should.equal 'Regular'
      done()
    )
