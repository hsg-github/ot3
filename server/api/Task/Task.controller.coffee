handleError = (res, err) ->
  res.status(500).send err

'use strict'
_ = require('lodash')
Task = require('./Task.model.coffee')
# Get list of Tasks

exports.index = (req, res) ->
  Task.find (err, Tasks) ->
    return handleError(res, err) if err
    res.status(200).json Tasks

# Get a single Task

exports.show = (req, res) ->
  Task.findById req.params.id, (err, task) ->
    return handleError(res, err) if err
    return res.status(404).send('Not Found') if !task
    res.json task

# Creates a new Task in the DB.

exports.create = (req, res) ->
  Task.create req.body, (err, Task) ->
  return handleError(res, err) if err
  res.status(201).json Task

# Updates an existing Task in the DB.

exports.update = (req, res) ->
  delete req.body._id if req.body._id
  Task.findById req.params.id, (err, task) ->
    return handleError(res, err) if err
    return res.status(404).send('Not Found') if !task
    updated = _.merge(task, req.body)
    updated.save (err) ->
      return handleError(res, err) if err
      res.status(200).json task

# Deletes a Task from the DB.

exports.destroy = (req, res) ->
  Task.findById req.params.id, (err, task) ->
    return handleError(res, err) if err
    return res.status(404).send('Not Found') if !task
    Task.remove (err) ->
      return handleError(res, err) if err
      res.status(204).send 'No Content'
