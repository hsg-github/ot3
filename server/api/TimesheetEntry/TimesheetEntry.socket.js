/**
 * Broadcast updates to client when the model changes
 */

'use strict';

var TimesheetEntry = require('./TimesheetEntry.model');

exports.register = function(socket) {
  TimesheetEntry.schema.post('save', function (doc) {
    onSave(socket, doc);
  });
  TimesheetEntry.schema.post('remove', function (doc) {
    onRemove(socket, doc);
  });
}

function onSave(socket, doc, cb) {
  socket.emit('TimesheetEntry:save', doc);
}

function onRemove(socket, doc, cb) {
  socket.emit('TimesheetEntry:remove', doc);
}