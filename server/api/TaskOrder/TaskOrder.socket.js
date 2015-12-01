/**
 * Broadcast updates to client when the model changes
 */

'use strict';

var TaskOrder = require('./TaskOrder.model');

exports.register = function(socket) {
  TaskOrder.schema.post('save', function (doc) {
    onSave(socket, doc);
  });
  TaskOrder.schema.post('remove', function (doc) {
    onRemove(socket, doc);
  });
}

function onSave(socket, doc, cb) {
  socket.emit('TaskOrder:save', doc);
}

function onRemove(socket, doc, cb) {
  socket.emit('TaskOrder:remove', doc);
}