// Generated by CoffeeScript 1.7.1
var Handler, log;

log = require('pomelo-logger').getLogger('entryHandler');

module.exports = function(app) {
  return new Handler(app);
};

Handler = (function() {
  function Handler(app) {
    this.app = app;
  }

  Handler.prototype.entry = function(msg, session, next) {
    return next(null, {
      code: 200,
      msg: 'game server is ok'
    });
  };

  Handler.prototype.regist = function(msg, session, next) {
    var UserBase;
    log.debug('regist', msg);
    UserBase = this.app.models.UserBase;
    UserBase.create({
      username: msg.username,
      password: msg.password
    }, function(err, users) {
      var rst;
      rst = err ? err.code === 11000 ? {
        _r: "用户名已经存在"
      } : {
        _r: "err"
      } : {
        _r: 's'
      };
      return next(null, rst);
    });
    return UserBase.count({
      username: msg.username
    }, function(err, count) {
      if (err || count > 0) {
        return next(null, {
          _r: "用户名存在"
        });
      }
    });
  };

  return Handler;

})();