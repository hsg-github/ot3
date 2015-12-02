/**
 * Broadcast updates to client when the model changes
 */

'use strict';

var Contract = require('./Project.model.js');

exports.register = function(socket) {
  Contract.schema.post('save', function (doc) {
    onSave(socket, doc);
  });
  Contract.schema.post('remove', function (doc) {
    onRemove(socket, doc);
  });
}

function onSave(socket, doc, cb) {
  socket.emit('Project:save', doc);
}

function onRemove(socket, doc, cb) {
  socket.emit('Project:remove', doc);
}
