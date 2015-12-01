'use strict';

var _ = require('lodash');
var Contract = require('./contract.model');

// Get list of contracts
exports.index = function(req, res) {
  Contract.find(function (err, contracts) {
    if(err) { return handleError(res, err); }
    return res.status(200).json(contracts);
  });
};

// Get a single contract
exports.show = function(req, res) {
  Contract.findById(req.params.id, function (err, contract) {
    if(err) { return handleError(res, err); }
    if(!contract) { return res.status(404).send('Not Found'); }
    return res.json(contract);
  });
};

// Creates a new contract in the DB.
exports.create = function(req, res) {
  Contract.create(req.body, function(err, contract) {
    if(err) { return handleError(res, err); }
    return res.status(201).json(contract);
  });
};

// Updates an existing contract in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  Contract.findById(req.params.id, function (err, contract) {
    if (err) { return handleError(res, err); }
    if(!contract) { return res.status(404).send('Not Found'); }
    var updated = _.merge(contract, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.status(200).json(contract);
    });
  });
};

// Deletes a contract from the DB.
exports.destroy = function(req, res) {
  Contract.findById(req.params.id, function (err, contract) {
    if(err) { return handleError(res, err); }
    if(!contract) { return res.status(404).send('Not Found'); }
    contract.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.status(204).send('No Content');
    });
  });
};

function handleError(res, err) {
  return res.status(500).send(err);
}