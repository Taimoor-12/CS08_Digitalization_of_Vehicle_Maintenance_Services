const { Otp } = require("../model/otpModel");
const { Num } = require("../model/numberModel");
var bcrypt = require("bcryptjs");
const _ = require("lodash");
const jwt = require("jsonwebtoken");
const otpGenerator=require('otp-generator');
const authConfig = require("../config/authConfig");

const accountSid = 'AC27a14bc84564d3e77c4f94d0794baa1b'
const authToken = 'fe40d4a9622d1f67ec42055b642349f8'
const client = require('twilio')(accountSid, authToken);

exports.registerPhone = async(req, res) => {
    const user = await Num.findOne({ number: req.body.number });
    if (user) {
     
   return res.status(400).send("User  already exist");
  }else{
  
    const OTP=otpGenerator.generate(6,{
      digits:true,alphabets:false,upperCaseAlphabets:false,lowerCaseAlphabets:false,specialChars: false,
    });
    const number=req.body.number;
    console.log(OTP);
    client.messages
  .create({body:'Verification code sent: '+OTP, from: '+12405712487', to: '+923325865614'})
  .then(message => console.log(message.sid));
    const otp=new Otp({number:number,otp:OTP});
    const salt=await bcrypt.genSalt(10)
    otp.otp=await bcrypt.hash(otp.otp,salt);
    const result=await otp.save();
    return res.status(200).send("Otp sent successfully!");
  }

}

exports.verifyOtp = async(req, res) => {
    const otpHolder=await Otp.find({
        number:req.body.number
      });
      console.log(otpHolder.length);
      if(otpHolder.length===0)
      return res.status(400).send("You used an expired OTP");
      const rightOtpFind=otpHolder[otpHolder.length-1];
      console.log(rightOtpFind);
      const validUser=await bcrypt.compare(req.body.otp,rightOtpFind.otp);
    if(rightOtpFind.number===req.body.number && validUser){
      const user=new Num(_.pick(req.body,["number"],["password"],['firstname'], ['lastname']))
      await user.generateHashedPassword();
    
    // const users=new User(_.pick(req.body,["number"]))
      let token = jwt.sign(
        { _id: user._id, name: user.number },
        authConfig.secretKey
      );
      const result=await user.save();
     // const results=await users.save();
      const OTPDelete=await Otp.deleteMany({
              number:rightOtpFind.number
      });
      return res.status(200).send({
        message:'User Registered Successfully!!',
        token:token,
        data: result
       
      });
    }else{
      return res.status(400).send("Your OTP Was wrong")
    }

}


exports.loginPhone = async (req, res) => {
    let user = await Num.findOne({ number: req.body.number });
    if (!user) return res.status(400).send("User Not Registered");
    let isValid = await bcrypt.compare(req.body.password, user.password);
    if (!isValid) return res.status(401).send("Invalid Password");
    let token = jwt.sign(
      { _id: user._id, name: user.number },
      authConfig.secretKey,
    );
    res.json({ token, ...user._doc});
}

exports.tokenValidOrNot = async(req, res, next) => {
    try {
      const token = req.header("x-auth-token");
      if (!token) return res.json(false);
      const verified = jwt.verify(token, authConfig.secretKey);
      if (!verified) return res.json(false);
  
      const user = await Num.findById(verified._id);
      if (!user) return res.json(false);
      res.json(true);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }

  exports.persistentLogin = async (req, res, next) => {
    const user = await Num.findById(req._id);
    res.json({...user._doc});
    
  }