'use strict'
mongoose = require('mongoose')
Schema = mongoose.Schema
TimeWindowedSchema = require('../shared/TimeWindowedSchema.model')
TaskSchema = new TimeWindowedSchema(
  name:
    type: String
    required: true
  description:
    type: String
    required: true
  _manager:
    type: Schema.Types.ObjectId
    ref: 'User'
    required: true
  _project:
    type: Schema.Types.ObjectId
    ref: 'Project'
    required: true
)
module.exports = mongoose.model('Task', TaskSchema)
