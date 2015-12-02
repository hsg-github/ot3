###*
# Broadcast updates to client when the model changes
###
'use strict'
TimesheetEntry = require('./TimesheetEntry.model.coffee')

onSave = (socket, doc, cb) ->
  socket.emit 'TimesheetEntry:save', doc

onRemove = (socket, doc, cb) ->
  socket.emit 'TimesheetEntry:remove', doc


exports.register = (socket) ->
  TimesheetEntry.schema.post 'save', (doc) ->
    onSave socket, doc
  TimesheetEntry.schema.post 'remove', (doc) ->
    onRemove socket, doc
