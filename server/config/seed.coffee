###
# Populate DB with sample data on server start
# to disable, edit config/environment/index.js, and set `seedDB: false`
###

'use strict'

Promise = require("bluebird");

User = require('../api/user/user.model')
Project = require('../api/Project/Project.model')
Task = require('../api/Task/Task.model')
Timesheet = require('../api/Timesheet/Timesheet.model')
TimesheetEntry = require('../api/TimesheetEntry/TimesheetEntry.model')
TimesheetService = require('../api/services/TimesheetService')

#regularUser = adminUser = project = task = timesheet = null

users = [
  new User(
    provider: 'local'
    role: 'admin'
    firstName: 'Admin'
    lastName: 'User'
    email: 'admin@admin.com'
    password: 'admin'
  ),
  new User(
    provider: 'local'
    firstName: 'Ada'
    lastName: 'Lovelace'
    email: 'ada@test.com'
    password: 'cs'
  ),
  new User(
    provider: 'local',
    role: 'supervisor'
    firstName: 'Wernher',
    lastName: 'von Braum',
    email: 'drstrangelove@test.com',
    password: 'rockets'
  ),
  new User(
    provider: 'local'
    firstName: 'Joe'
    lastName: 'Sixpack'
    email: 'construction@test.com'
    password: 'beer'
  ),
  new User(
    provider: 'local',
    role: 'supervisor'
    firstName: 'Joe',
    lastName: 'Foreman',
    email: 'foreman@test.com',
    password: 'hardhat'
  )
]

projects = [
  new Project(
    name: 'To the Moon!',
    description: 'The Apollo Missions',
    startDate: new Date(1961, 0, 1, 0, 0, 0, 0),
    endDate: new Date(2019, 11, 31, 0, 0, 0, 0)
  ),
  new Project(
    name: 'Big Dig',
    description: 'Boston\'s Big Dig',
    startDate: new Date(1990, 4, 1, 0, 0, 0, 0),
    endDate: new Date(2020, 8, 15, 0, 0, 0, 0)
  )
]

timesheet = new Timesheet(
  startDate: new Date(2015, 11, 1, 0, 0, 0, 0),
  endDate: new Date(2015, 11, 15, 0, 0, 0, 0),
  submitted: true,
  approved: false
)

tasks = [
  new Task(
    name: 'Permits'
    description: 'Obtain necessary permits'
    startDate: new Date(1990, 4, 1, 0, 0, 0, 0),
    endDate: new Date(1993, 11, 30, 0, 0, 0, 0)
  ),
  new Task(
    name: 'Bulldoze'
    description: 'Bulldoze anything in your way'
    startDate: new Date(1992, 4, 1, 0, 0, 0, 0),
    endDate: new Date(1997, 3, 15, 0, 0, 0, 0)
  ),
  new Task(
    name: 'Dig'
    description: 'Start digging'
    startDate: new Date(1994, 4, 1, 0, 0, 0, 0),
    endDate: new Date(2000, 7, 13, 0, 0, 0, 0)
  ),
  new Task(
    name: 'Build'
    description: 'Start building'
    startDate: new Date(new Date().getTime() - (1000 * 60 * 60 * 24 * 30)),
    endDate: new Date(new Date().getTime() + (1000 * 60 * 60 * 24 * 30))
  ),
  new Task(
    name: 'Research'
    description: 'Learn some physics'
    startDate: new Date(1961, 1, 1, 0, 0, 0, 0)
    endDate: new Date(1965, 11, 31, 0, 0, 0, 0)
  ),
  new Task(
    name: 'Mars'
    description: 'Become a Martian'
    startDate: new Date(new Date().getTime() - (1000 * 60 * 60 * 24 * 31 * 5)),
    endDate: new Date(new Date().getTime() + (1000 * 60 * 60 * 24 * 31 * 5))
  )
]

timesheetEntry = new TimesheetEntry(
  description: 'a task description',
  hoursWorked: 4
  notes: 'some notes'
  dateWorked: new Date(2015, 11, 7, 0, 0, 0, 0)
  _timesheet: {}
  _task: {}
)

# Delete initial objects
User.remove().exec()
Project.remove().exec()
Timesheet.remove().exec()
Task.remove().exec()
TimesheetEntry.remove().exec()

# Create initial objects
console.log 'begin populating objects...'
Promise.promisifyAll(require("mongoose"));

bigDig = apollo = ada = wernher = sixpack = foreman = build = mars = null
#createProjectsAndUsers = []
#createProjectsAndUsers.push Promise.map(projects, (project) -> project.save() )
#createProjectsAndUsers.push Promise.map(users, (user) -> user.save() )
#
#findUsersAndProjects = []
#findUsersAndProjects.push Project.findOne({name: 'To the Moon!'}).then((found) -> apollo = found)
#findUsersAndProjects.push Project.findOne({name: 'Big Dig'}).then((found) -> bigDig = found)
#findUsersAndProjects.push User.findOne({firstName: 'Ada'}).then((found) -> ada = found)
#findUsersAndProjects.push User.findOne({firstName: 'Wernher'}).then((found) -> wernher = found)
#findUsersAndProjects.push User.findOne({lastName: 'Sixpack'}).then((found) -> sixpack = found)
#findUsersAndProjects.push User.findOne({lastName: 'Foreman'}).then((found) -> foreman = found)
#
#createTasks = []
#createTasks.push Promise.map(tasks, Promise.method((task) -> task.save() )

#project.save() for project in projects
#user.save() for user in users

#Promise.all(createProjectsAndUsers).then((results) ->
#  Promise.all(findUsersAndProjects)
#).then(() ->
#  for task in tasks
#    if task.name in ['Permits', 'Bulldoze', 'Dig', 'Build']
#      task._project = bigDig._id
#      task._manager = wernher._id
#    else
#      task._project = apollo._id
#      task._manager = foreman._id
#).then(() ->
#  console.log tasks[0]
#)

console.log(task.name + 'is complete: ' + task.isComplete()) for task in tasks

Promise.each(users, (user) -> return user.save()
).then((results) ->
  for result in results
    if 'Ada' == result.firstName then ada = result
    if 'Wernher' == result.firstName then wernher = result
    if 'Sixpack' == result.lastName then sixpack = result
    if 'Foreman' == result.lastName then foreman = result
  Promise.each(projects, (project) -> return project.save()
  ).then((results) ->
    for result in results
      if 'To the Moon!' == result.name then apollo = result
      if 'Big Dig' == result.name then bigDig = result
  ).then(() ->
    Promise.each(tasks, (task) ->
      if task.name in ['Permits', 'Bulldoze', 'Dig', 'Build']
        task._project = bigDig._id
        task._manager = wernher._id
      else
        task._project = apollo._id
        task._manager = foreman._id
      return task.save()
    ).then((results) ->
      timesheets = []
      for num in [5..1]
        timesheets.push new Timesheet(
          _user: ada._id
          _supervisor: wernher._id
          startDate: new Date(2015, 11, 1, 0, 0, 0, 0)
          endDate: new Date(2015, 11, 15, 0, 0, 0, 0)
        )
    )
  )
).catch((err) ->
  console.log 'An error occurred during seed process: ' + err
)

#Promise.all(createProjectsAndUsers).then(
#  Promise.all(findUsersAndProjects).then(() ->
#    for task in tasks
#      if task.name in ['Permits', 'Bulldoze', 'Dig', 'Build']
#        task._project = bigDig._id
#        task._manager = wernher._id
#      else
#        task._project = apollo._id
#        task._manager = foreman._id
#      console.log task
#    promises.push Promise.method(task.save())
#  )

#Promise.each(promises, )

#Promise.delay(1000).then(
#  ()-> User.findOne({firstName: 'Ada'}).then((found) -> console.log found )
#)

#Project.find({name: 'To the Moon!'}).then((found) ->
#  apollo = found
#).then(() ->
#  Project.find({name: 'Big Dig'}).then((found) ->
#    bigDig = found
#  )
#).then(() ->
#  User.find({firstName: 'Ada'}).then((found) ->
#    ada = found
#  )
#).then(() ->
#  User.find({firstName: 'Wernher'}).then((found) ->
#    wernher = found
#  )
#).then(() ->
#  User.find({lastName: 'Sixpack'}).then((found) ->
#    sixpack = found
#  )
#).then(() ->
#  User.find({lastName: 'Foreman'}).then((found) ->
#    foreman = found
#  )
#).then(() ->
#  for task in tasks
#    if task.name in ['Permits', 'Bulldoze', 'Dig', 'Build']
#      task._project = bigDig._id
#      task._manager = wernher._id
#    else
#      task._project = apollo._id
#      task._manager = foreman._id
#    console.log task
##    promises.push Promise.method(task.save())
##  Promise.all(promises).then ->
##    console.log 'all tasks created'
#).then(() ->
#  Promise.map(tasks, (task) ->
#    console.log task
#    task.save()
#  ).then(() -> console.log 'done saving tasks')
#).then(() ->
#  for num in [10..1]
#    timesheet = new Timesheet(
#      startDate: new Date(2015, 11, 1, 0, 0, 0, 0),
#      endDate: new Date(2015, 11, 15, 0, 0, 0, 0)
#    )
#).then(() ->
#  console.log apollo
#  console.log bigDig
#)

promiseWhile = (condition, action) ->
  resolver = Promise.defer()
  theLoop = ->
    if !condition()
      return resolver.resolve()
    Promise.cast(action()).then(theLoop).catch resolver.reject
  process.nextTick theLoop
  resolver.promise

#for task in tasks
#  if task.name in ['Permits', 'Bulldoze', 'Dig']
#    Project.find({name: 'Big Dig'}).then((found) ->
#      console.log found
#    )

#project.save().then(()   ->
#  console.log 'saved project'
#  task._project = project._id
#).then(() ->
#  supervisor.save(() ->
#    console.log 'saved supervisor'
#    timesheet._supervisor = supervisor._id
#    task._manager = supervisor._id
#  )
#).then(() ->
#  regularUser.save(() ->
#    console.log 'saved regularUser'
#    timesheet._user = regularUser._id
#  )
#).then(() ->
#  timesheet.save(() ->
#    console.log 'saved timesheet'
#    timesheetEntry._timesheet = timesheet._id
#  )
#).then(() ->
#  task.save(() ->
#    console.log 'saved task'
#    timesheetEntry._task = task._id
#  )
#).then(() ->
#  timesheetEntry.save(() ->
#    console.log 'saved timesheetEntry'
#    console.log 'done populating objects'
#  )
#).catch((err) ->
#  console.log 'Error: ' + err
#)
