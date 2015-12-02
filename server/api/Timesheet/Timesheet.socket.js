/**
 * Broadcast updates to client when the model changes
 */

'use strict';

var Timesheet = require('./Timesheet.model.js');

exports.register = function(socket) {
  Timesheet.schema.post('save', function (doc) {
    onSave(socket, doc);
  });
  Timesheet.schema.post('remove', function (doc) {
    onRemove(socket, doc);
  });
}

function onSave(socket, doc, cb) {
  socket.emit('Timesheet:save', doc);
}

function onRemove(socket, doc, cb) {
  socket.emit('Timesheet:remove', doc);
}
