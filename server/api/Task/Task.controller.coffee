handleError = (res, err) ->
  res.status(500).send err

'use strict'
_ = require('lodash')
Task = require('./Task.model.js')
# Get list of Tasks

exports.index = (req, res) ->
  Task.find (err, Tasks) ->
if err
  return handleError(res, err)
res.status(200).json Tasks
return

# Get a single Task

exports.show = (req, res) ->
  Task.findById req.params.id, (err, Task) ->
if err
  return handleError(res, err)
if !Task
  return res.status(404).send('Not Found')
res.json Task
return

# Creates a new Task in the DB.

  exports.create = (req, res) ->
  Task.create req.body, (err, Task) ->
if err
  return handleError(res, err)
res.status(201).json Task
return

# Updates an existing Task in the DB.

  exports.update = (req, res) ->
if req.body._id
  delete req.body._id
Task.findById req.params.id, (err, Task) ->
if err
  return handleError(res, err)
if !Task
  return res.status(404).send('Not Found')
updated = _.merge(Task, req.body)
updated.save (err) ->
if err
  return handleError(res, err)
res.status(200).json Task
return
return

# Deletes a Task from the DB.

  exports.destroy = (req, res) ->
  Task.findById req.params.id, (err, Task) ->
if err
  return handleError(res, err)
if !Task
  return res.status(404).send('Not Found')
Task.remove (err) ->
if err
  return handleError(res, err)
res.status(204).send 'No Content'
return
return
