/**
 * Broadcast updates to client when the model changes
 */

'use strict';

var Project = require('./Project.model.js');

exports.register = function(socket) {
  Project.schema.post('save', function (doc) {
    onSave(socket, doc);
  });
  Project.schema.post('remove', function (doc) {
    onRemove(socket, doc);
  });
};

function onSave(socket, doc, cb) {
  socket.emit('Project:save', doc);
}

function onRemove(socket, doc, cb) {
  socket.emit('Project:remove', doc);
}
