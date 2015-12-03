###*
# Broadcast updates to client when the model changes
###

onSave = (socket, doc, cb) ->
  socket.emit 'Task:save', doc

onRemove = (socket, doc, cb) ->
  socket.emit 'Task:remove', doc

'use strict'
Task = require('./Task.model')

exports.register = (socket) ->
  Task.schema.post 'save', (doc) ->
    onSave socket, doc
  Task.schema.post 'remove', (doc) ->
    onRemove socket, doc
