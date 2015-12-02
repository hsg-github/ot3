'use strict'
_ = require('lodash')
TimesheetEntry = require('./TimesheetEntry.model.coffee')

handleError = (res, err) ->
  res.status(500).send err

# Get list of TimesheetEntrys

exports.index = (req, res) ->
  TimesheetEntry.find (err, timesheetEntries) ->
    return handleError(res, err) if err
    res.status(200).json timesheetEntries

# Get a single TimesheetEntry

exports.show = (req, res) ->
  TimesheetEntry.findById req.params.id, (err, timesheetEntry) ->
    return handleError(res, err) if err
    return res.status(404).send('Not Found') if !timesheetEntry
    res.json timesheetEntry

# Creates a new TimesheetEntry in the DB.

exports.create = (req, res) ->
  TimesheetEntry.create req.body, (err, timesheetEntry) ->
    return handleError(res, err) if err
    res.status(201).json timesheetEntry

# Updates an existing TimesheetEntry in the DB.

exports.update = (req, res) ->
  delete req.body._id if req.body._id
  TimesheetEntry.findById req.params.id, (err, timesheetEntry) ->
    return handleError(res, err) if err
    return res.status(404).send('Not Found') if !timesheetEntry
    updated = _.merge(timesheetEntry, req.body)
    updated.save (err) ->
      return handleError(res, err) if err
      res.status(200).json timesheetEntry

# Deletes a TimesheetEntry from the DB.

exports.destroy = (req, res) ->
  TimesheetEntry.findById req.params.id, (err, timesheetEntry) ->
    return handleError(res, err) if err
    return res.status(404).send('Not Found') if !timesheetEntry
    timesheetEntry.remove (err) ->
      return handleError(res, err) if err
      res.status(204).send 'No Content'
