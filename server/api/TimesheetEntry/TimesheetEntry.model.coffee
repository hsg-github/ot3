'use strict'
mongoose = require('mongoose')
Schema = mongoose.Schema
BaseSchema = require('../shared/BaseSchema.model')

TimesheetEntrySchema = new BaseSchema(
  description: String
  hoursWorked:
    type: Number
    required: true
    min: 0
    max: 24
  notes: String
  dateWorked:
    type: Date
    required: true
  _timesheet:
    type: Schema.Types.ObjectId
    ref: 'Timesheet'
    required: true
  _task:
    type: Schema.Types.ObjectId
    ref: 'Task'
    required: true
)

#TimesheetEntrySchema.methods =
#  makeSalt: ->
#    @crypto.randomBytes(16).toString 'base64'

# TODO: disallow timesheet entries which
#   exceed a total of 24 hours when combined with other entries for that user
#   would be a duplicate day worked + task combination

#return self.dateWorked >= populated._timesheet.startDate && self.dateWorked <= populated._timesheet.endDate

TimesheetEntrySchema.path('dateWorked').validate ((value, respond) ->
  self = this
  this.populate('_timesheet', (err, populated) ->
    return respond(self.dateWorked >= populated._timesheet.startDate && self.dateWorked <= populated._timesheet.endDate)
  )
), 'dateWorked must fall within Timesheet time window.'

module.exports = mongoose.model('TimesheetEntry', TimesheetEntrySchema)
