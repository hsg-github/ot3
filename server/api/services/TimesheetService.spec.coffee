'use strict'

svc = require('./TimesheetService')
chai = require("chai");

describe 'TimesheetService', ->

  describe '#getWeekStartDate', ->
    it 'should always return a Monday', () ->
      begin = new Date()
      for num in [20..1]
        expect(svc.getWeekStartDate(new Date(begin - 1000 * 60 * 60 * 12 * num))).to.match(/^Mon/)
    it 'should return different dates when input date is incremented by more than a week', () ->
      begin = new Date()
      dates = []
      for num in [20..1]
        weekStart = svc.getWeekStartDate(new Date(begin - 1000 * 60 * 60 * 24 * 8 * num))
        console.log weekStart
        expect(dates).to.not.include(weekStart)
        dates.push weekStart
