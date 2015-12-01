'use strict';

var _ = require('lodash');
var TaskOrder = require('./TaskOrder.model');

// Get list of TaskOrders
exports.index = function(req, res) {
  TaskOrder.find(function (err, TaskOrders) {
    if(err) { return handleError(res, err); }
    return res.status(200).json(TaskOrders);
  });
};

// Get a single TaskOrder
exports.show = function(req, res) {
  TaskOrder.findById(req.params.id, function (err, TaskOrder) {
    if(err) { return handleError(res, err); }
    if(!TaskOrder) { return res.status(404).send('Not Found'); }
    return res.json(TaskOrder);
  });
};

// Creates a new TaskOrder in the DB.
exports.create = function(req, res) {
  TaskOrder.create(req.body, function(err, TaskOrder) {
    if(err) { return handleError(res, err); }
    return res.status(201).json(TaskOrder);
  });
};

// Updates an existing TaskOrder in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  TaskOrder.findById(req.params.id, function (err, TaskOrder) {
    if (err) { return handleError(res, err); }
    if(!TaskOrder) { return res.status(404).send('Not Found'); }
    var updated = _.merge(TaskOrder, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.status(200).json(TaskOrder);
    });
  });
};

// Deletes a TaskOrder from the DB.
exports.destroy = function(req, res) {
  TaskOrder.findById(req.params.id, function (err, TaskOrder) {
    if(err) { return handleError(res, err); }
    if(!TaskOrder) { return res.status(404).send('Not Found'); }
    TaskOrder.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.status(204).send('No Content');
    });
  });
};

function handleError(res, err) {
  return res.status(500).send(err);
}