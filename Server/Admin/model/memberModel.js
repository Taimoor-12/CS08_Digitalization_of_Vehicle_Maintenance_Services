const mongoose = require("mongoose");
var bcrypt = require("bcryptjs");

const userSchema = mongoose.Schema({
  _id: mongoose.Schema.Types.ObjectId,
  firstname: {
    type: String,
    required: true,
  },
  lastname: {
    type: String,
    required: true,
  },
  serviceProviderId: { type: String},
  email: {
    type: String,
    required: true,
    unique: true,
    match: /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/,
  },
  password: { type: String, required: true },
  mobile: { type: String },
  role: {
    type: String,
    default: 'ADMIN',
  },
  verify:{
    type:String,
    default:'false'
      },
  status: { type: String, default: "AVAILABLE" },
  resetLink:{
    data:String,
    default:''
  },
  image: { type: String, required: true },
  address: String,
  cnic: String,
  // address: { type: String, required: true},
  // cnic: { type: String, required: true},
  
});


userSchema.methods.generateHashedPassword = async function () {
  let salt = await bcrypt.genSalt(10);
  this.password = await bcrypt.hash(this.password, salt);
};


module.exports = mongoose.model("members", userSchema);
