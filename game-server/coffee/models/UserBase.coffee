
module.exports = (app, mongoose, Schema) ->
  UserBaseSchema = new Schema({
      username:       {type: String, required: true, index: {unique: true}},
      password:       String,
      created_at:     String
    })
  UserBase = mongoose.model('UserBase', UserBaseSchema)
  app.models.UserBase = UserBase
