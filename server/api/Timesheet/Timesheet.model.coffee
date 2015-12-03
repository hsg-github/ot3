'use strict'
mongoose = require('mongoose')
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId
TimeWindowedSchema = require('../shared/TimeWindowedSchema.model.coffee')

TimesheetSchema = new TimeWindowedSchema(
  _user:
    type: ObjectId
    ref: 'User'
    required: true
  _supervisor:
    type: ObjectId
    ref: 'User'
    required: true
  submitted: Boolean
  approved: Boolean
)

# Validate start/end dates
#TimesheetSchema
#  .path('startDate')
#  .validate(function(startDate) {
#    return (startDate < this.endDate);
#  }, 'startDate must preceed endDate');

#alignDates = () ->
#
#
#TimesheetSchema.methods =
#  next: () -> console.log 'get next timesheet'
#
#UserSchema.pre 'save', (next) ->


# Validate approved state
TimesheetSchema.path('approved').validate ((approved) ->
  @submitted or !@submitted and !approved
), 'cannot approved if not submitted'
module.exports = mongoose.model('Timesheet', TimesheetSchema)
