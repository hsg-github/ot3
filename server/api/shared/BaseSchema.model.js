'use strict';

// Configure mongoose inheritance
var util = require('util');
var mongoose = require('mongoose');

function BaseSchema() {
  mongoose.Schema.apply(this, arguments);
  this.add({
    createdAt: Date,
    lastUpdatedAt: Date
  });
  this.pre('save', function (next) {
    this.lastUpdatedAt = new Date();
    if (util.isNullOrUndefined(this.createdAt)) this.createdAt = this.lastUpdatedAt;
    next();
  });

  // Validate start/end dates
  this
    .path('createdAt')
    .validate(function(createdAt) {
      return (createdAt <= this.lastUpdatedAt);
    }, 'createdAt must equal or preceed lastUpdatedAt');
  this
    .path('createdAt')
    .validate(function(createdAt) {
      return (createdAt && this._id) || (util.isNullOrUndefined(createdAt) && util.isNullOrUndefined(this._id));
    }, 'createdAt must not be present if the object has not been saved');

  // TODO: Make sure createdAt can't be passed in. Maybe just do it in middleware?
  //this
  //  .path('lastUpdatedAt')
  //  .validate(function(lastUpdatedAt, respond) {
  //    var self = this;
  //    this.constructor.findById(self._id, function(err, doc) {
  //      if (lastUpdatedAt != doc.lastUpdatedAt) return false;
  //    });
  //  }, "");
}
util.inherits(BaseSchema, mongoose.Schema);

module.exports = BaseSchema;
