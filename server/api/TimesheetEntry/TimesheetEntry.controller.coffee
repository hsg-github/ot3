'use strict';

var _ = require('lodash');
var TimesheetEntry = require('./TimesheetEntry.model.coffee');

// Get list of TimesheetEntrys
exports.index = function(req, res) {
  TimesheetEntry.find(function (err, TimesheetEntrys) {
    if(err) { return handleError(res, err); }
    return res.status(200).json(TimesheetEntrys);
  });
};

// Get a single TimesheetEntry
exports.show = function(req, res) {
  TimesheetEntry.findById(req.params.id, function (err, TimesheetEntry) {
    if(err) { return handleError(res, err); }
    if(!TimesheetEntry) { return res.status(404).send('Not Found'); }
    return res.json(TimesheetEntry);
  });
};

// Creates a new TimesheetEntry in the DB.
exports.create = function(req, res) {
  TimesheetEntry.create(req.body, function(err, TimesheetEntry) {
    if(err) { return handleError(res, err); }
    return res.status(201).json(TimesheetEntry);
  });
};

// Updates an existing TimesheetEntry in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  TimesheetEntry.findById(req.params.id, function (err, TimesheetEntry) {
    if (err) { return handleError(res, err); }
    if(!TimesheetEntry) { return res.status(404).send('Not Found'); }
    var updated = _.merge(TimesheetEntry, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.status(200).json(TimesheetEntry);
    });
  });
};

// Deletes a TimesheetEntry from the DB.
exports.destroy = function(req, res) {
  TimesheetEntry.findById(req.params.id, function (err, TimesheetEntry) {
    if(err) { return handleError(res, err); }
    if(!TimesheetEntry) { return res.status(404).send('Not Found'); }
    TimesheetEntry.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.status(204).send('No Content');
    });
  });
};

function handleError(res, err) {
  return res.status(500).send(err);
}
