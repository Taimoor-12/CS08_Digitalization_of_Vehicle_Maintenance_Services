var mongoose = require("mongoose");
var bcrypt = require("bcryptjs");
// const Joi = require("@hapi/joi");
// const { serviceSchema }  = require("./ServiceProvider");
var numberSchema = mongoose.Schema({
 
    firstname: {
        type: String,
        min: 4,
        max: 20,
      },
      lastname: {
        type: String,
        min: 4,
        max: 20,
      },
  number:{
    type:String,
    required:true
  },
  password: { type: String },
  role: {
    type: String,
    default: "CUSTOMER",
  },
  resetLink:{
    data:String,
    default:''
  },

  image: String,

  
  
},{timestamps:true});
numberSchema.methods.generateHashedPassword = async function () {
  let salt = await bcrypt.genSalt(10);
  this.password = await bcrypt.hash(this.password, salt);
};
var Num = mongoose.model("numbers", numberSchema);

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
module.exports.Num = Num;
// module.exports.validate = validateUser; //for sign up
// module.exports.validateUserLogin = validateUserLogin; // for login
