###*
# Broadcast updates to client when the model changes
###

'use strict'
Timesheet = require('./Timesheet.model.coffee')

onSave = (socket, doc, cb) ->
  socket.emit 'Timesheet:save', doc

onRemove = (socket, doc, cb) ->
  socket.emit 'Timesheet:remove', doc

exports.register = (socket) ->
  Timesheet.schema.post 'save', (doc) ->
    onSave socket, doc
  Timesheet.schema.post 'remove', (doc) ->
    onRemove socket, doc
