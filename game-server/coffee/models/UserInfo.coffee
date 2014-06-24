
module.exports = (app, mongoose, Schema) ->
	UserInfoSchema = new Schema
		silver: Number,
		gold: Number,
		ps: Number,
		base: {type: Schema.Types.ObjectId, ref: 'UserBase'}
