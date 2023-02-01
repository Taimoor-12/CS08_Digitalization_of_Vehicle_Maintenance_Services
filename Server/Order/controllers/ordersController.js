const Order = require("../model/orderModel");
const MemberModel = require("../model/MemberModel");

var nodemailer = require('nodemailer');
//TO place an Order
exports.addOrder = async (req, res) => {
  const order = new Order({
    customerId: req.body.customerId,
    firstName: req.body.firstName,
    email:req.body.email,
    carName: req.body.carName,
    carNumber: req.body.carNumber,
    custAddress: req.body.custAddress,
    serviceName: req.body.serviceName,
    servicePrice: req.body.servicePrice,
    serviceProviderId: req.body.serviceProviderId,
    paymentMethod: req.body.paymentMethod
  });

  let provider = await MemberModel.findById({_id : req.body.serviceProviderId});
  console.log(provider)
  var email = provider.email;
  /*  let Member =  MemberModel.findById( ).exec();
  console.log(Member[0]['email']);*/
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
     subject: 'Your Order has been Placed Successfully!!!!',// Subject line
     text: ' your order has been placed Successfully!!.\n',
    //  html : 'Service Provider details:\nService Provider name: $'
    html : `
    <h2>Thanks for choosing <span style="color:#e92e4a;">Carsaz</span></h2>
    <p>Your Order has been placed</p>.
    <p>Here are the details of your service provider</p>
    <br/>
    <p>Service Provider Name: <span style="color:#e92e4a;">${provider.firstname + " " + provider.lastname}</span></p>
    <br/>
    <p>Service Provider Email: <span style="color:#e92e4a;">${provider.email}</span></p>
    <br/>
    <p>Service Provider Phone: <span style="color:#e92e4a;">${provider.mobile}</span></p>
    <p>We’re glad you’re here!</p>
    <p style="color:#e92e4a;">The CarSaz team</p>`,
     
 // html : 'To reset your password, click this <a href="' + '"><span>link</span></a>.<br>This is a <b>test</b> email.'
    };


    let transporter1 = nodemailer.createTransport({
   
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
    
    const mailOptions1 = {
       from:'carsaz37@outlook.com', // sender address
       to: email,
       subject: 'You have received an order from a customer',// Subject line
       text: 'Kindly check your dashboard to check the order details.\n',
       html: `
       <h2>Kindly check your dashboard to see the order details of <span style="color:#e92e4a;">${req.body.email}</span></h2>
       <p>Here are the details of your customer</p>
       <br/>
       <p>Customer Name: <span style="color:#e92e4a;">${req.body.firstName}</span></p>
       <br/>
       <p>Customer address: <span style="color:#e92e4a;">${req.body.custAddress}</span></p>
       <br/>
       <p>Customer car name: <span style="color:#e92e4a;">${req.body.carName}</span></p>
       <br/>
       <p>Customer car number: <span style="color:#e92e4a;">${req.body.carNumber}</span></p>
       <p>Happy selling!</p>
       <p style="color:#e92e4a;">The CarSaz team</p>`
      //  html : 'Assign a mechanic to the order so it can process further ahead.'
   // html : 'To reset your password, click this <a href="' + '"><span>link</span></a>.<br>This is a <b>test</b> email.'
      };

  order
    .save()
    .then((result) => {
      




      transporter.sendMail(mailOptions, function(error, info){
        if (error) {
          console.log(error);
        } else {
        //  console.log('Email sent: ' + info.response);
        return res.json({message:'Email has been sent'});
        }
      });

      transporter1.sendMail(mailOptions1, function(error, info){
        if (error) {
          console.log(error);
        } else {
        //  console.log('Email sent: ' + info.response);
        return res.json({message:'Email has been sent'});
        }
      });

      
 

      console.log("Order Placed: " + result);
      res.status(201).json({
        message: "Thank you for your order.",
        result,
      });
    })
    .catch((err) => {
      console.log("Placing Order Error" + err);
      res.status(500).json({
        error: err,
      });
    });
};

exports.addOrderPhone = async (req, res) => {
  const order = new Order({
    customerId: req.body.customerId,
    firstName: req.body.firstName,
    carName: req.body.carName,
    carNumber: req.body.carNumber,
    custAddress: req.body.custAddress,
    serviceName: req.body.serviceName,
    servicePrice: req.body.servicePrice,
    serviceProviderId: req.body.serviceProviderId
  });

  let provider = await MemberModel.findById({_id : req.body.serviceProviderId});
  console.log(provider)
  var email = provider.email;

  let transporter1 = nodemailer.createTransport({
   
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
  
  const mailOptions1 = {
     from:'carsaz37@outlook.com', // sender address
     to: email,
     subject: 'You have received an order from a customer',// Subject line
     text: 'Kindly check your dashboard to check the order details.\n',
     html: `
       <h2>Kindly check your dashboard to see the order details of <span style="color:#e92e4a;">${req.body.email}</span></h2>
       <p>Here are the details of your customer</p>
       <br/>
       <p>Customer Name: <span style="color:#e92e4a;">${req.body.firstName}</span></p>
       <br/>
       <p>Customer address: <span style="color:#e92e4a;">${req.body.custAddress}</span></p>
       <br/>
       <p>Customer car name: <span style="color:#e92e4a;">${req.body.carName}</span></p>
       <br/>
       <p>Customer car number: <span style="color:#e92e4a;">${req.body.carNumber}</span></p>
       <p>Happy selling!</p>
       <p style="color:#e92e4a;">The CarSaz team</p>`
 // html : 'To reset your password, click this <a href="' + '"><span>link</span></a>.<br>This is a <b>test</b> email.'
    };


  order
    .save()
    .then((result) => {

      transporter1.sendMail(mailOptions1, function(error, info){
        if (error) {
          console.log(error);
        } else {
        //  console.log('Email sent: ' + info.response);
        return res.json({message:'Email has been sent'});
        }
      });


      console.log("Order Placed: " + result);
      res.status(201).json({
        message: "Thank you for your order.",
        result,
      });
    })
    .catch((err) => {
      console.log("Placing Order Error" + err);
      res.status(500).json({
        error: err,
      });
    });
};

//Find Completed Orders
exports.findCompltedOrders = (req, res) => {
  Order.find({ status: "COMPLETED", serviceProviderId: req.params.serviceProviderId })
    .exec()
    .then((response) => {
      if (response.length == 0) {
        res.status(200).json({
          message: "No Orders are available",
        });
      } else {
        res.status(200).json({
          orders: response,
        });
      }
    })
    .catch((err) => {
      console.log("Find All Completed Orders Error: " + err);
      res.status(500).json({
        error: err,
      });
    });
};

// "Request Placed",
//           "Request Cancel",
//           "Request in Process",
//           "Request Accepted",
//           "Request Rejected",
//           "Request Completed",
