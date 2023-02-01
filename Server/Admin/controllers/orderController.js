const OrderModel = require("../model/orderModel");
const MemberModel = require("../model/memberModel");
const CustomerModel = require("../model/customerModel");

var nodemailer = require('nodemailer');


//Find Placed Orders
exports.findPlacedOrders = (req, res) => {
    
  OrderModel.find({
  $or: [
   { status: "IN-PROCESS", serviceProviderId: req.params.serviceProviderId},
    {  status: "PLACED",  serviceProviderId: req.params.serviceProviderId},
    {  status: "REJECT",  serviceProviderId: req.params.serviceProviderId},
  ],
})
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
      console.log("Find All Placed Orders Error: " + err);
      res.status(500).json({
        error: err,
      });
    });
};

//Send Order to Mechanic
exports.updateOrder = async (req, res) => {
  const orderId = req.params.orderId;
  let orderDetails = await OrderModel.findById(orderId);

  let mechanicDetails = await MemberModel.findById({ _id: req.body.mechanicId})
  let email = mechanicDetails.email

  let customerDetails = await CustomerModel.findById( {_id: orderDetails.customerId});

  //updateOne({ _id: id }, { $set: req.body }
  let transporter = nodemailer.createTransport({
   
    host: 'smtp.office365.com', // Office 365 server
         port: 587,     // secure SMTP
         secure: false,
         requireTLS: true,
     auth: {
       user: 'carsaz37@outlook.com',
       pass: 'carsaz654321'
       
       
     },
     attachments: [{
      // filename: 'image.png',
      // path: '/path/to/file',
      cid: mechanicDetails.image //same cid value as in the html img src
     }],
     tls: {
       ciphers: 'SSLv3'
   }
   });
  
  const mailOptions = {
     from:'carsaz37@outlook.com', // sender address
     to: email,
     subject: 'You have been assigned an order',// Subject line
     text: ' your order has been placed Successfully!!.\n',
    //  html : 'Service Provider details:\nService Provider name: $'
    html : `
    <h2>Choose a status of the order on your dashboard</h2>
    <p>Your service provider has assigned an order to you</p>.
    <p>Here are the details of your order and customer</p>
    <br/>
    <p>Customer Email: <span style="color:#e92e4a;">${orderDetails.email}</span></p>
    <br/>
    <p>Customer Name: <span style="color:#e92e4a;">${orderDetails.firstName}</span></p>
    <br/>
    <p>Customer Address: <span style="color:#e92e4a;">${orderDetails.custAddress}</span></p>
    <br/>
    <p>Customer car name: <span style="color:#e92e4a;">${orderDetails.carName}</span></p>
    <br/>
    <p>Customer car number: <span style="color:#e92e4a;">${orderDetails.carNumber}</span></p>
    <br/>
    <p>Service name: <span style="color:#e92e4a;">${orderDetails.serviceName}</span></p>
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
       to: customerDetails.email,
       subject: 'You have been assigned a mechanic',// Subject line
       text: ' your order has been placed Successfully!!.\n',
      //  html : 'Service Provider details:\nService Provider name: $'
      html : `
      <h2>Your mechanic information are as follows:</h2>
      <br/>
      <span> Mechanic picture: <img style="border-radius:50%; margin-left:450px" src="${mechanicDetails.image}" alt="Mechanic image" width="200" height="200"></span>
    <br/> 
      <p>Mechanic Email: <span style="color:#e92e4a;">${mechanicDetails.email}</span></p>
      <br/>
      
      <p>Mechanic Name: <span style="color:#e92e4a;">${mechanicDetails.firstname + " " + mechanicDetails.lastname}</span></p>
      <br/>
      <p>Mechanic Phone: <span style="color:#e92e4a;">${mechanicDetails.mobile}</span></p>
      <br/>
      <p>We’re glad you’re here!</p>
      <p style="color:#e92e4a;">The CarSaz team</p>`,
       
   // html : 'To reset your password, click this <a href="' + '"><span>link</span></a>.<br>This is a <b>test</b> email.'
      };


  OrderModel.updateOne(
    { _id: orderId },
    { $set: { status: "IN-PROCESS", mechanicId: req.body.mechanicId } }
  )
    .exec()
    .then((response) => {

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

      res.status(200).json({
        message: "Order Successfully Assign to Mechanic",
      });
    })

    


    .catch((err) => {
      console.log(err);
      res.status(500).json({
        error: err,
      });
    });
};
