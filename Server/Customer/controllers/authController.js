const User = require("../model/customerModel");

const userOtpVerification = require("../model/userVerificationModel");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const bcrypt1 = require("bcrypt-nodejs");
const mongoose = require("mongoose");
// const config = require("config");
const authConfig = require("../config/authConfig");
var nodemailer = require('nodemailer');


exports.resetPassword= async (req,res,next)=>{
  const {resetLink,newPass}=req.body;
  //console.log(resetLink);
  if(resetLink){
    jwt.verify(resetLink, authConfig.secretKey,function(error,decodedData){
      if(error){
        return res.status(401).json({
          error:"Incorrect token or it is expired"
        })
      }
      
        User.findOne({resetLink}, async (err,user)=>{
        
              if(err || !user){
                return res.status(400).json({error:"User with this token does not exist."});
              }
          
        user.password=newPass
       
       await  user.generateHashedPassword();
        user.resetLink=''
         
              
           await  user.save((err,result)=>{
                if(err){
                  return res.status(400).json({error:"reset password error"});
                }else{
                  return res.status(200).json({message:'Your password has been changes'})
                }
              })
      })
    })
  }else{
    return res.status(401).json({error:"Authentication error!!!"});
  }

}


exports.forgotPassword= async (req,res,next)=>{
  let user =  await User.findOne({ email: req.body.email });
  if (!user) return res.status(400).send("User Not Registered");
  const token = jwt.sign(
    {
      userId: user._id,
    },
    authConfig.secretKey,
    {
      expiresIn: "1h",

    }
  );
 // const link='http://localhost:3000/ResetPassword/+{token}';
 let resetUrl = 'http' + '://' + 'localhost' + ':' + 3000 + '/ResetPassword/' + token
 
  let transporter = nodemailer.createTransport({
   
   host: 'smtp.office365.com', // Office 365 server
        port: 587,     // secure SMTP
        secure: false,
        requireTLS: true,
    auth: {
      user: 'carsaz37@outlook.com',
      pass: 'carsaz654321'
      
      
    },
    tls: {
      ciphers: 'SSLv3'
  }
  });
 
 const mailOptions = {
    from:'carsaz37@outlook.com', // sender address
    to: req.body.email,
    subject: 'reset your carsaz password!!!!',// Subject line
    text: 'The link will be expired in 1 Hour.\n',
  
 html : 'To reset your password, click this <a href="' + resetUrl + '"><span>link</span></a>.<br>This is a <b>test</b> email.'
   };
  return  user.updateOne({ resetLink:token },function(err,success){
    

  if (err){
    return res.status(400).json({error:"reset password link"});
  } 
  else {
  
    transporter.sendMail(mailOptions, function(error, info){
      if (error) {
        console.log(error);
      } else {
        console.log('Email sent: ' + info.response);
      return res.json({message:'Email has been sent'});
      }
    });
  }



  })
}

const SendOtpVerificationEmail =  async ({ _id, email },res) => {
  console.log('hamza');
  try {
   

    // Generated OTP
    const otp = Math.floor(1000 + Math.random() * 9000);
    // Mail Options
 /*   const mailOptions = {
      from: "otp.pethub@zohomail.com",
      to: email,
      subject: "Verify your Email",
      text: "OTP Verification Email",
      html: `
      <h2>Hello and Welcome to <span style="color:#e92e4a;">pethub.com</span></h2>
      <p>Your OTP verification code is <span style="color:#e92e4a; font-size:20px;">${otp}</span></p>.
      <p>Enter this code in our website or mobile app to activate your account.</p>
      <br/>
      <p>If you have any questions, send us an email <span style="color:blue;">support.pethub@zohomail.com</span>.</p>
      <br/>
      <p>We’re glad you’re here!</p>
      <p style="color:#e92e4a;">The PETHUB team</p>`,
    };*/
    let transporter = nodemailer.createTransport({
   
      host: 'smtp.office365.com', // Office 365 server
           port: 587,     // secure SMTP
           secure: false,
           requireTLS: true,
       auth: {
         user: 'carsaz37@outlook.com',
         pass: 'carsaz654321'
         
         
       },
       tls: {
         ciphers: 'SSLv3'
     }
     });
    
   /* const mailOptions = {
       from:'carsaz37@outlook.com', // sender address
       to: email,
       subject: 'reset your carsaz password!!!!',// Subject line
       text: 'The link will be expired in 1 Hour.\n',
     
    html : 'To reset your password, click this <a href="'  + '"><span>link</span></a>.<br>This is a <b>test</b> email.'
      };*/
      const mailOptions = {
        from: "carsaz37@outlook.com",
        to: email,
        subject: "Verify your Email",
        text: "OTP Verification Email",
        html: `
        <h2>Hello and Welcome to <span style="color:#e92e4a;">Carsaz.com</span></h2>
        <p>Your OTP verification code is <span style="color:#e92e4a; font-size:20px;">${otp}</span></p>.
        <p>Enter this code in our website or mobile app to activate your account.</p>
        <br/>
        <p>If you have any questions, send us an email <span style="color:blue;">support.carsaz37@outlook.com</span>.</p>
        <br/>
        <p>We’re glad you’re here!</p>
        <p style="color:#e92e4a;">The CarSaz team</p>`,
      };
    //hash the OTP
    const saltRounds = 10;

    // generating salt
    const salt = bcrypt1.genSaltSync(saltRounds);

    // getting Hashed OTP
    const hashedOTP = bcrypt1.hashSync(otp, salt);

    //OTP Verification DB object
    const newOtpVerfication = new userOtpVerification({
      userId: _id,
      otp: hashedOTP,
      createdAt: Date.now(),
      expiredAt: Date.now() + 3600000,
    });
   await  newOtpVerfication.save();
    transporter.sendMail(mailOptions, (err, info) => {
      console.log(err);
      if (err) {
        User.findByIdAndDelete({ _id: _id })
          .then(() => {
            return res.send({
              status: "failed",
              message: "Not able to send OTP" + err.message,
            });
          })
          .catch((err) => {
            return res.send({
              status: "failed",
              message: "Server Error" + err.message,
            });
          });
      } else {
        return res.send({
          status: "pending",
          message: "Verification OTP email sent.",
          data: {
            userId: _id,
            email,
          },
        });
      }
    });
  } catch (error) {
    console.log(error);
    res.json({
      
      status: "failed",
      message: error.message,
    });
  }
};

// exports.register = (req, res, next) => {
//   console.log("Inside Register");

//   if (!req.body.firstname || !req.body.lastname || !req.body.email || !req.body.password) {
//     return res.status(400).json({ message: "All fields are required" });
//   }

//   User.find({ email: req.body.email })
//     .exec()
//     .then((user) => {
//       if (user.length >= 1) {
//         return res.status(409).json({
//           message: "User Already Exist",
//         });
//       } else {
//         bcrypt.hash(req.body.password, 10, (err, hash) => {
//           if (err) {
//             return res.status(500).json({
//               error: err,
//             });
//           } else {
//             const user = new User({
//               _id: new mongoose.Types.ObjectId(),
//               firstname: req.body.firstname,
//               lastname: req.body.lastname,
//               email: req.body.email,
//               password: hash,
//               // role: req.body.role,
//             });
//             user
//               .save()
//               .then((result) => {
//                 console.log(result);
//                 res.status(201).json({
//                   message: "Registered Successfully",
//                   user: result,
//                 });
//               })
//               .catch((err) => {
//                 console.log("Registration Error" + err);
//                 res.status(500).json({
//                   Registartion_Error: err,
//                 });
//               });
//           }
//         });
//       }
//     });
// };


exports.register =  (req, res, next) => {
   
  console.log("Inside Register");

  if (!req.body.firstname || !req.body.lastname || !req.body.email || !req.body.password) {
    return res.status(400).json({ message: "All fields are required" });
  }

  

  User.find({ email: req.body.email })
    .exec()
    .then((user) => {
      if (user.length >= 1 && user[0]['verified'] == "false") {

      
        if(user[0]['verified']) {
          User.findByIdAndRemove(user[0]['_id']).exec()
        }

        // return res.status(409).json({
        //   message: "User Already Exist",
        // });
        // console.log(user[0]['firstname'])
        // var id = user[0]['_id']
         
        bcrypt.hash(req.body.password, 10, (err, hash) => {
          if (err) {
            return res.status(500).json({
              error: err,
            });
          } else {
            const user = new User({
              _id: new mongoose.Types.ObjectId(),
              firstname: req.body.firstname,
              lastname: req.body.lastname,
              email: req.body.email,
              password: hash,
              // role: req.body.role,
            });
            user
              .save()
              .then ( async (result) => {
                console.log(result);
               await SendOtpVerificationEmail(result,res);
               return res.status(200).json({
                message: "Authentication Successful",
                userId: user._id,
                firstname: user.firstname,
                lastname: user.lastname,
                email: user.email,
                // role: user.role,
               
              });
               
              })
              .catch((err) => {
                console.log("Registration Error" + err);
                res.status(500).json({
                  Registartion_Error: err,
                });
              });
          }
        });
        
        

      } 
      // else if(user.length >= 1 && user.verified == "false") {
      //   console.log('Inside here');
        
        
      // }
      
      else {
        bcrypt.hash(req.body.password, 10, (err, hash) => {
          if (err) {
            return res.status(500).json({
              error: err,
            });
          } else {
            const user = new User({
              _id: new mongoose.Types.ObjectId(),
              firstname: req.body.firstname,
              lastname: req.body.lastname,
              email: req.body.email,
              password: hash,
              // role: req.body.role,
            });
            user
              .save()
              .then ( async (result) => {
                console.log(result);
               await SendOtpVerificationEmail(result,res);
               return res.status(200).json({
                message: "Authentication Successful",
                userId: user._id,
                firstname: user.firstname,
                lastname: user.lastname,
                email: user.email,
                // role: user.role,
               
              });
               
              })
              .catch((err) => {
                console.log("Registration Error" + err);
                res.status(500).json({
                  Registartion_Error: err,
                });
              });
          }
        });
      }
    });
};

exports.verifyOTP= async (req,res,next)=>{
  //router.post("/verifyOTP", async (req, res) => {
    try {
      // Get data from Request body
      const { userId, otp } = req.body;
      // Check OTP Details
      if (!userId || !otp) {
        throw Error("Empty otp Details are not allowed");
      } else {
        // Find OTP
        const userVerificationRecords = await userOtpVerification.find({
          userId,
        });
        if (userVerificationRecords.length <= 0) {
          res.send({
            status: "failed",
            message:
              "Account record doesn't exist or has been verified already. Please Signup or Login.",
          });
        } else {
          const { expiredAt } = userVerificationRecords[0];
          const hashedOTP = userVerificationRecords[0].otp;
          // Check if Expired
          if (expiredAt < Date.now()) {
            await userOtpVerification.deleteMany({ userId });
            res.send({
              status: "failed",
              message: "Code has Expired. Please request again.",
            });
          } else {
            // Check OTP
            const validotp = bcrypt.compareSync(otp, hashedOTP);
            if (!validotp) {
              res.send({
                status: "failed",
                message: "Invalid OTP please check your Email.",
              });
            } else {
              // Update User Status
              await User.findByIdAndUpdate(
                { _id: userId },
                { verified: true }
              ).then(() => {
                userOtpVerification.deleteMany({ userId }).then(() => {
                  res.json({
                    status: "success",
                    message: "User Email Verified successfully.",
                  });
                });
              });
            }
          }
        }
      }
    } catch (error) {
      res.json({
        status: "failed",
        message: error.message,
      });
    }
  };

// exports.login = (req, res, next) => {
//   User.findOne({ email: req.body.email })
//     .exec()
//     .then((user) => {
//       if (!user) {
//         return res.status(401).json({
//           message: "Authentication Failed",
//         });
//       } else {
//         bcrypt.compare(req.body.password, user.password, (err, response) => {
//           if (err) {
//             return res.status(401).json({
//               message: "Authentication Failed",
//             });
//           } else if (response) {
//             const token = jwt.sign(
//               {
//                 userId: user._id,
//               },
//               authConfig.secretKey,
//               {
//                 expiresIn: "1h",
//               }
//             );
//             return res.status(200).json({
//               message: "Authentication Successful",
//               userId: user._id,
//               firstname: user.firstname,
//               lastname: user.lastname,
//               email: user.email,
//               role: user.role,
//               token: token,
//             });
//           } else {
//             return res.status(401).json({
//               message: "Authentication Failed",
//             });
//           }
//         });
//       }
//     })
//     .catch((err) => {
//       console.log("Login Error: " + err);
//       res.status(500).json({
//         Login_Error: err,
//       });
//     });
// };

exports.login = async(req, res, next) => {

  let user = await User.findOne({ email: req.body.email})
  let date_ob = new Date();

// current date
// adjust 0 before single digit date
let date = ("0" + date_ob.getDate()).slice(-2);

// current month
let month = ("0" + (date_ob.getMonth() + 1)).slice(-2);

// current year
let year = date_ob.getFullYear();

// current hours
let hours = date_ob.getHours();
// current minutes
let minutes = date_ob.getMinutes();

// current seconds
let seconds = date_ob.getSeconds();
  User.findOne({ email: req.body.email })
    .exec()
    .then((user) => {
      if (!user && user.verified==="true") {
        return res.status(401).json({
          message: "Authentication Failed",
        });
      } else {
        bcrypt.compare(req.body.password, user.password, async (err, response) => {
          if (err) {
            return res.status(401).json({
              message: "Authentication Failed",
            });
          } else if (response) {
            const token = jwt.sign(
              {
                userId: user._id,
              },
              authConfig.secretKey,
              {
                expiresIn: "24h",

              }
              
            );
            let resetUrl = 'http' + '://' + 'localhost' + ':' + 3000 + '/ResetPassword/' + token
            await user.updateOne({resetLink: token})

            let transporter = nodemailer.createTransport({
   
              host: 'smtp.office365.com', // Office 365 server
                   port: 587,     // secure SMTP
                   secure: false,
                   requireTLS: true,
               auth: {
                 user: 'carsaz37@outlook.com',
                 pass: 'carsaz654321'
                 
                 
               },
               tls: {
                 ciphers: 'SSLv3'
             }
             });
            
            const mailOptions = {
               from:'carsaz37@outlook.com', // sender address
               to: req.body.email,
               subject: 'Login activity detected',// Subject line
               text: 'The link will be expired in 1 Hour.\n',
             html: `
             <h2>You logged into your account @ <span style="color:#e92e4a;">${hours}Hr:${minutes}Min:${seconds}Secs</span></h2>
             <br/>
             <p>If this is you then ignore this email</p>.
             <br/>
             <p><span style="color:#e92e4a;">If this isn't you then you can reset your password at: ${resetUrl}</span></p>
             <br/>
             <p>If you have any questions, send us an email <span style="color:blue;">support.carsaz37@outlook.com</span>.</p>
             <br/>
             <p>We’re glad you’re here!</p>
             <p style="color:#e92e4a;">The CarSaz team</p>`,
            // html : 'You have logged into your accountTo reset your password, click this <a href="' + resetUrl + '"><span>link</span></a>.<br>This is a <b>test</b> email.'
              };


              transporter.sendMail(mailOptions, function(error, info){
                if (error) {
                  console.log(error);
                } else {
                  console.log('Email sent: ' + info.response);
                return res.json({message:'Email has been sent'});
                }
              });
            return res.status(200).json({
              message: "Authentication Successful",
              userId: user._id,
              firstname: user.firstname,
              lastname: user.lastname,
              email: user.email,
              role: user.role,
              verified:user.verified,
              token: token,
              image: user.image
            });
          } else {
            return res.status(401).json({
              message: "Authentication Failed",
            });
          }
        });
      }
    })
    .catch((err) => {
      console.log("Login Error: " + err);
      res.status(500).json({
        Login_Error: err,
      });
    });
};


exports.tokenValidOrNot = async(req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) return res.json(false);
    const verified = jwt.verify(token, authConfig.secretKey);
    if (!verified) return res.json(false);

    const user = await User.findById(verified.userId);
    if (!user) return res.json(false);
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
}

exports.persistentLogin = async (req, res, next) => {
  const user = await User.findById(req.userId);
  res.json({...user._doc});
}


