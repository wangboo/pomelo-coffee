
module.exports = (app, mongoose, Schema) ->
  UserBaseSchema = new Schema({
      username:       {type: String, required: true, index: {unique: true}},
      password:       String,
      created_at:     String,
      is_online:			Boolean
    })

  UserBaseSchema.methods.set_online = (cb) ->
  	@update({online: true}, cb)



  UserBase = mongoose.model('user_base', UserBaseSchema)
  app.models.UserBase = UserBase

