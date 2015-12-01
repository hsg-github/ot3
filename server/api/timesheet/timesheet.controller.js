'use strict';

var _ = require('lodash');
var Timesheet = require('./timesheet.model');

// Get list of timesheets
exports.index = function(req, res) {
  Timesheet.find(function (err, timesheets) {
    if(err) { return handleError(res, err); }
    return res.status(200).json(timesheets);
  });
};

// Get a single timesheet
exports.show = function(req, res) {
  Timesheet.findById(req.params.id, function (err, timesheet) {
    if(err) { return handleError(res, err); }
    if(!timesheet) { return res.status(404).send('Not Found'); }
    return res.json(timesheet);
  });
};

// Creates a new timesheet in the DB.
exports.create = function(req, res) {
  Timesheet.create(req.body, function(err, timesheet) {
    if(err) { return handleError(res, err); }
    return res.status(201).json(timesheet);
  });
};

// Updates an existing timesheet in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  Timesheet.findById(req.params.id, function (err, timesheet) {
    if (err) { return handleError(res, err); }
    if(!timesheet) { return res.status(404).send('Not Found'); }
    var updated = _.merge(timesheet, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.status(200).json(timesheet);
    });
  });
};

// Deletes a timesheet from the DB.
exports.destroy = function(req, res) {
  Timesheet.findById(req.params.id, function (err, timesheet) {
    if(err) { return handleError(res, err); }
    if(!timesheet) { return res.status(404).send('Not Found'); }
    timesheet.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.status(204).send('No Content');
    });
  });
};

function handleError(res, err) {
  return res.status(500).send(err);
}