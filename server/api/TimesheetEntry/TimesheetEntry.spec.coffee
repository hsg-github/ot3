'use strict'

User = require('../user/user.model')
Project = require('../Project/Project.model')
Task = require('../Task/Task.model.coffee')
Timesheet = require('../Timesheet/Timesheet.model.coffee')
TimesheetEntry = require('../TimesheetEntry/TimesheetEntry.model.coffee')

regularUser = new User(
  provider: 'local',
  firstName: 'Regular',
  lastName: 'User',
  email: 'regularUser@test.com',
  password: 'password'
);

supervisor = new User(
  provider: 'local',
  firstName: 'Supervisor',
  lastName: 'User',
  email: 'supervisor@test.com',
  password: 'password'
)

project = new Project(
  name: 'a Project'
  description: 'a Project description'
  startDate: new Date(2014, 0, 1, 0, 0, 0, 0)
  endDate: new Date(2016, 11, 31, 0, 0, 0, 0)
)

timesheet = new Timesheet(
  _user: {},
  _supervisor: {},
  startDate: new Date(2015, 11, 1, 0, 0, 0, 0),
  endDate: new Date(2015, 11, 15, 0, 0, 0, 0),
  submitted: true,
  approved: false
)

task = new Task(
  name: 'a task'
  description: 'a task description'
  startDate: new Date(2015, 0, 1, 0, 0, 0, 0)
  endDate: new Date(2015, 11, 31, 0, 0, 0, 0)
  _manager: {}
  _project: {}
)

timesheetEntryBase = new TimesheetEntry(
  description: 'a task description',
  hoursWorked: 4
  notes: 'some notes'
  dateWorked: new Date(2015, 11, 7, 0, 0, 0, 0)
  _timesheet: {}
  _task: {}
)
timesheetEntry = new TimesheetEntry(timesheetEntryBase)

describe 'TimesheetEntry model', ->
  before () ->
    # Clear objects before testing
    removeAll()

    # Create initial objects
    project.save().then(()   ->
      task._project = project._id
    ).then(() ->
      supervisor.save(() ->
        timesheet._supervisor = supervisor._id
        task._manager = supervisor._id
      )
    ).then(() ->
      regularUser.save(() ->
        timesheet._user = regularUser._id
      )
    ).then(() ->
      timesheet.save(() ->
        timesheetEntry._timesheet = timesheet._id
      )
    ).then(() ->
      task.save(() ->
        timesheetEntry._task = task._id
      )
    ).then(() ->
      timesheetEntry.save(() ->
      )
    )
  after () ->
    removeAll()

  it 'should begin with 1 Project', () ->
    return Project.find({}).should.eventually.have.length(1)

  it 'should begin with 2 Users', () ->
    return User.find({}).should.eventually.have.length(2)

  it 'should begin with 1 Timesheet', () ->
    return Timesheet.find({}).should.eventually.have.length(1)

  it 'should begin with 1 Task', () ->
    return Task.find({}).should.eventually.have.length(1)

  it 'should begin with 1 TimesheetEntry', () ->
    return TimesheetEntry.find({}).should.eventually.have.length(1)

  it 'should fail when saving a TimesheetEntry with a date before its parent Timesheet\'s date', (done) ->
    timesheetEntry.dateWorked = new Date(1492, 11, 7, 0, 0, 0, 0)
    timesheetEntry.save ((err) ->
      should.exist err.errors.dateWorked
      done()
    )

  it 'should fail when saving a TimesheetEntry with a date after its parent Timesheet\'s date', (done) ->
    timesheetEntry.dateWorked = new Date(4000, 11, 7, 0, 0, 0, 0)
    timesheetEntry.save ((err) ->
      should.exist err.errors.dateWorked
      done()
    )
