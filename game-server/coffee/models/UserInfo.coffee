
module.exports = (app, mongoose, Schema) ->
	UserInfoSchema = new Schema
		#积分
		score: Number, default: 0
		#头像
		icon: String
		#等级
		level: Number, default: 0
		#名字
		name: String
		#自我描述
		desc: String


	UserInfo = mongoose.model 'user_info', UserInfoSchema
	app.models.UserInfo = UserInfo
