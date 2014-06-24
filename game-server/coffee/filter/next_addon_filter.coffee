module.exports = (msg, session, next) ->
	# 增加成功方法
	next.success = () ->
		next null, {_r: 's'}
	next.suc = next.success

	# 增加失败方法
	next.fail = (msg, code="1") ->
		next null, {_r: code, _m: msg}
	next.err = next.fail

	# 服务器失败
	next.server_err = () ->
		next null, {_r: "1", _m: "服务器出问题啦"}