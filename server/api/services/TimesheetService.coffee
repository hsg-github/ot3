'use strict'

svc = {}

svc.getWeekStartDate = (d) ->
  d = new Date(d)
  day = d.getDay()
  diff = d.getDate() - day + (if day == 0 then -6 else 1)
  # adjust when day is sunday
  return new Date(d.setDate(diff))

svc.getNextTimesheet = (task, user, supervisor) ->
  return null if task.isComplete()


exports = module.exports = svc
