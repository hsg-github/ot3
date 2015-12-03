'use strict'
_ = require('lodash')
Timesheet = require('./Timesheet.model')

handleError = (res, err) ->
  res.status(500).send err

# Get list of Timesheets

exports.index = (req, res) ->
  Timesheet.find (err, timesheets) ->
    return handleError(res, err) if err
    res.status(200).json timesheets

# Get a single Timesheet

exports.show = (req, res) ->
  Timesheet.findById req.params.id, (err, timesheet) ->
    return handleError(res, err) if err
    return res.status(404).send('Not Found') if !timesheet
    res.json timesheet

# Creates a new Timesheet in the DB.

exports.create = (req, res) ->
  Timesheet.create req.body, (err, timesheet) ->
    return handleError(res, err) if err
    res.status(201).json timesheet

# Updates an existing Timesheet in the DB.

exports.update = (req, res) ->
  delete req.body._id if req.body._id
  Timesheet.findById req.params.id, (err, timesheet) ->
    return handleError(res, err) if err
    return res.status(404).send('Not Found') if !timesheet
    updated = _.merge(timesheet, req.body)
    updated.save (err) ->
      return handleError(res, err) if err
      res.status(200).json timesheet

# Deletes a Timesheet from the DB.

exports.destroy = (req, res) ->
  Timesheet.findById req.params.id, (err, timesheet) ->
    return handleError(res, err) if err
    return res.status(404).send('Not Found') if !timesheet
    timesheet.remove (err) ->
      return handleError(res, err) if err
      res.status(204).send 'No Content'
