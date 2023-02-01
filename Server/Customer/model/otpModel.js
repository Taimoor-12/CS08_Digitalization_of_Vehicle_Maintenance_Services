var mongoose = require("mongoose");
var bcrypt = require("bcryptjs");
// const Joi = require("@hapi/joi");
var otpSchema = mongoose.Schema({ 
  number:{
type:String,
required:true
  },
  otp:{
  type:String,
 
  },
  createdAt:{type:Date,default:Date.now,index:{expires:300000}}
},{timestamps:true});
otpSchema.methods.generateHashedPassword = async function () {
  let salt = await bcrypt.genSalt(10);
  this.password = await bcrypt.hash(this.password, salt);
};
var Otp= mongoose.model("signups", otpSchema);

// function validateUser(data) {
//   const schema = Joi.object({
//     name: Joi.string().min(3).max(10).required(),
//     email: Joi.string().email().min(3).max(10).required(),
//     password: Joi.string().min(3).max(10).required(),
//   });
//   return schema.validate(data, { abortEarly: false });
// }
// function validateUserLogin(data) {
//   const schema = Joi.object({
//     email: Joi.string().email().min(3).max(10).required(),
//     password: Joi.string().min(3).max(10).required(),
//   });
//   return schema.validate(data, { abortEarly: false });
// }
module.exports.Otp=Otp;
// module.exports.validate = validateUser; //for sign up
// module.exports.validateUserLogin = validateUserLogin; // for login