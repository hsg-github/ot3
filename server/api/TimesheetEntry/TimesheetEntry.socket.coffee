###*
# Broadcast updates to client when the model changes
###

onSave = (socket, doc, cb) ->
  socket.emit 'TimesheetEntry:save', doc
return

onRemove = (socket, doc, cb) ->
  socket.emit 'TimesheetEntry:remove', doc
return

'use strict'
TimesheetEntry = require('./TimesheetEntry.model')

exports.register = (socket) ->
  TimesheetEntry.schema.post 'save', (doc) ->
onSave socket, doc
return
TimesheetEntry.schema.post 'remove', (doc) ->
onRemove socket, doc
return
return
