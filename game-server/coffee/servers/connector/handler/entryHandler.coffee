log = require('pomelo-logger').getLogger('entryHandler')

module.exports = (app) ->
  new Handler(app)

class Handler
  constructor: (@app) ->

  # 登陆
  entry: (msg, session, next) ->
    next(null, {code: 200, msg: 'game server is ok'})

  # 注册
  regist: (msg, session, next) ->
    log.debug 'regist', msg
    UserBase = @app.models.UserBase
    UserBase.create({username: msg.username, password: msg.password}, (err, users) ->
      rst = if err
        if err.code == 11000
          {_r: "用户名已经存在"}
        else
          {_r: "err"}
      else
        {_r: 's'}
      next(null, rst)
    )
    UserBase.count({username: msg.username}, (err, count) ->
      if err or count > 0 then next(null, {_r: "用户名存在"})
    )
