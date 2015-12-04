'use strict'

log = require('loglevel');

svc = {}

svc.getWeekStartDate = (d) ->
  original = new Date(d)
  d = new Date(d)
  day = d.getDay()
  diff = d.getDate() - day + (if day == 0 then -6 else 1)
  # adjust when day is sunday
  d.setHours 0
  d.setMinutes 0
  d.setSeconds 0
  d.setMilliseconds 0
  d.setDate(diff)
  log.trace original + ' starts on ' + d + ' (diff=' + diff + ')'
  return d

svc.getWeekEndDate = (d) ->
  original = new Date(d)
  startDate = @getWeekStartDate(d)
  startDayOfMonth = startDate.getDate()
  endDate = new Date(startDate.setDate(startDayOfMonth + 6))
  endDate.setHours 23
  endDate.setMinutes 59
  endDate.setSeconds 59
  endDate.setMilliseconds 999
  log.trace original + ' ends on ' + endDate
  return endDate

svc.getNextTimesheet = (task, user, supervisor, date = new Date()) ->
  return null if task.isComplete()


exports = module.exports = svc
