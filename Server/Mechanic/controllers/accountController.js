const MemberModel = require("../model/mechanicModel");
var nodemailer = require('nodemailer');
exports.updateProfile = (req, res) => {
  const id = req.params.mechId;
  MemberModel.updateMany({ _id: id }, { $set: req.body })
    .exec()
    .then((response) => {
      console.log("Profile Updated Successfully: " + response);
      res.status(200).json({
        message: " Profile Updated Successfully",
        response,
      });
    })
    .catch((err) => {
      console.log("Profile Update error: " + err);
      res.status(500).json({ "Profile Update error ": err });
    });
};

exports.deleteProfile = (req, res) => {
  const id = req.params.mechId;
  MemberModel.deleteOne({ _id: id })
    .exec()
    .then((response) => {
      res.status(200).json({
        message: "Account Deleted",
      });
    })
    .catch((err) => {
      console.log("Account Delete error: " + err);
      res.status(500).json({ "Account Delete error ": err });
    });
};

exports.mechanicDetail = async (req, res) => {
  const id = req.params.mechId;
   
  try {
    let mechanic = await MemberModel.findById(id);
    return res.json(mechanic)
  }
  catch (e) {
      
  }
  

  MemberModel.deleteOne({ _id: id })
    .exec()
    .then((response) => {
      res.status(200).json({
        message: "Account Deleted",
      });
    })
    .catch((err) => {
      console.log("Account Delete error: " + err);
      res.status(500).json({ "Account Delete error ": err });
    });
};


exports.deleteServiceProvider = (req, res) => {
  const id = req.params.serviceId;
  MemberModel.deleteOne({ _id: id })
    .exec()
    .then((response) => {
      res.status(200).json({
        message: "Account Deleted",
      });
    })
    .catch((err) => {
      console.log("Account Delete error: " + err);
      res.status(500).json({ "Account Delete error ": err });
    });
};




exports.updateServiceProvider = async (req, res) => {
  const id = req.params.serviceId;

  let providerDetails = await MemberModel.findById(id)

  MemberModel.updateMany({ _id: id }, { $set: req.body })
    .exec()
    .then((response) => {


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
         to: providerDetails.email,
         subject: 'Your verification status',// Subject line
         text: ' your order has been placed Successfully!!.\n',
        //  html : 'Service Provider details:\nService Provider name: $'
        html : `
        <h2>Your account's verification status: <span style="color:#e92e4a;">${providerDetails.verify}</span></h2>
        <br/>
        <p>We’re glad you’re here!</p>
        <p style="color:#e92e4a;">The CarSaz team</p>`,
         
     // html : 'To reset your password, click this <a href="' + '"><span>link</span></a>.<br>This is a <b>test</b> email.'
        };

      transporter.sendMail(mailOptions, function(error, info){
        if (error) {
          console.log(error);
        } else {
        //  console.log('Email sent: ' + info.response);
        return res.json({message:'Email has been sent'});
        }
      });


      console.log("Profile Updated Successfully: " + response);
      res.status(200).json({
        message: " Profile Updated Successfully",
        response,
      });
    })
    .catch((err) => {
      console.log("Profile Update error: " + err);
      res.status(500).json({ "Profile Update error ": err });
    });
};
