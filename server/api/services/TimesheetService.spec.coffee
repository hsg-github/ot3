'use strict'

svc = require('./TimesheetService')

describe 'TimesheetService', ->

  describe '#getWeekStartDate', ->
    it 'should always return a Monday', () ->
      begin = new Date()
      for num in [100..1]
        expect(svc.getWeekStartDate(new Date(begin - 1000 * 60 * 60 * 12 * num))).to.match(/^Mon/)
    it 'should return different dates when input date is incremented by more than a week', () ->
      begin = new Date()
      dates = []
      for num in [20..1]
        weekStart = svc.getWeekStartDate(new Date(begin - 1000 * 60 * 60 * 24 * 8 * num))
        expect(dates).to.not.include(weekStart)
        dates.push weekStart

  describe '#getWeekEndDate', ->
    it 'should always return a Monday', () ->
      begin = new Date()
      for num in [100..1]
        expect(svc.getWeekEndDate(new Date(begin - 1000 * 60 * 60 * 12 * num))).to.match(/^Sun/)
    it 'should return different dates when input date is incremented by more than a week', () ->
      begin = new Date()
      dates = []
      for num in [20..1]
        weekEnd = svc.getWeekEndDate(new Date(begin - 1000 * 60 * 60 * 24 * 8 * num))
        expect(dates).to.not.include(weekEnd)
        dates.push weekEnd
