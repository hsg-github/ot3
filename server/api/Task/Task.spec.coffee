'use strict'

Task = require('./Task.model.coffee')
User = require('../user/user.model')
Project = require('../Project/Project.model.js')

taskBase = new Task(
  name: 'a task'
  description: 'a task description'
  startDate: new Date(2015, 11, 1, 0, 0, 0, 0)
  endDate: new Date(2015, 11, 15, 0, 0, 0, 0)
  _manager: {}
  _project: {}
)

manager = new User(
  provider: 'local'
  firstName: 'Task Manager'
  lastName: 'User'
  email: 'manager@test.com'
  password: 'password'
)

project = new Project(
  name: 'a Project'
  description: 'a Project description'
  startDate: new Date(2015, 0, 1, 0, 0, 0, 0)
  endDate: new Date(2015, 11, 31, 0, 0, 0, 0)
)

# TODO: Validate task dates fall within Project date
describe 'Task model', ->
  before () ->
    # Clear objects before testing
    removeAll()

    # Create initial objects
    project.save().then(()   ->
      taskBase._project = project._id
    ).then(() ->
      manager.save(() ->
        taskBase._manager = manager._id
      )
    )
  after () ->
    removeAll()
  afterEach () ->
    Task.remove().exec()

  it 'should begin with no objects', () ->
    return Task.find({}).should.eventually.have.length(0)

  it 'should fail when saving a Task without a name', (done) ->
    task = new Task(taskBase)
    (->
      task.name = undefined
    )()
    task.save ((err) ->
      should.exist err.errors.name
      done()
    )

  it 'should fail when saving a Task without a description', (done) ->
    task = new Task(taskBase)
    (->
      task.description = undefined
    )()
    task.save (err) ->
      should.exist err.errors.description
      done()

  it 'should fail when saving a Task without a manager', (done) ->
    task = new Task(taskBase)
    # Must use closure here to safely set reference to undefined (See TypedArray.js, which sets the global 'undefined'
    (->
      task._manager = undefined
    )()
    task.save (err) ->
      should.exist err.errors._manager
      done()

  it 'should fail when saving a Task without a Project', (done) ->
    task = new Task(taskBase)
    # Must use closure here to safely set reference to undefined (See TypedArray.js, which sets the global 'undefined'
    (->
      task._project = undefined
    )()
    task.save (err) ->
      should.exist err.errors._project
      done()

  it 'should succeed when saving a valid Task', () ->
    task = new Task(taskBase)
    task._project = project._id
    task._manager = manager._id
    task.save (err, savedTask) ->
      should.not.exist err
      # Also make sure we can populate() a model reference
      Task.findById(savedTask._id).populate('_project').populate('_manager').exec (err, populatedTask) ->
        if err
          return done(err)
        populatedTask._project.name.should.equal project.name
        populatedTask._manager.firstName.should.equal manager.firstName
