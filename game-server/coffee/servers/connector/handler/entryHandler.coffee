log = require('pomelo-logger').getLogger('entryHandler')
sync = require 'sync'

module.exports = (app) ->
  new Handler(app)

class Handler
  constructor: (@app) ->

  # 登陆
  entry: (msg, session, next) ->
    sync.waterFall([
      (cb) ->
        UserBase.findOne({username: msg.username}, (err, user) ->
          if err
            next.server_err()
          else if users == null
            cb "账号不存在"
          else if user.password == msg.password
            cb null, user
          else
            cb "账号密码错误"
        )
      ,
      (user, cb) ->
        user.set_online cb
      ], 
      (err) -> 
        if err
          next.fail err
        else
          next.suc
    )
    

  # 注册
  regist: (msg, session, next) ->
    log.debug 'regist', msg
    UserBase = @app.models.UserBase
    UserBase.create({username: msg.username, password: msg.password}, (err, users) ->
      rst = if err
        next.fail('用户名已经存在')
      else
        next.suc()
    )



