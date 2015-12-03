'use strict'
util = require('util')
mongoose = require('mongoose')
BaseSchema = require('./BaseSchema.model')

TimeWindowedSchema = ->
  BaseSchema.apply this, arguments

  @methods =
    isComplete: () -> return new Date() > @endDate

  @add
    startDate:
      type: Date
      required: true
    endDate:
      type: Date
      required: true

  @path('startDate').validate ((startDate) ->
    startDate < @endDate
  ), 'startDate must preceed endDate'
  return

#TimeWindowedSchema.methods =
#  isComplete: () -> return new Date() > @endDate

util.inherits TimeWindowedSchema, BaseSchema
module.exports = TimeWindowedSchema
