const OrderModel = require("../model/orderModel");
const MemberModel = require("../model/mechanicModel");
const CustomerModel = require("../model/customerModel");
var nodemailer = require('nodemailer');
//Find IN-PROCESS Orders
exports.findInProcessOrders = (req, res) => {
  
  OrderModel.find({
    $or: [
      { mechanicId: req.params.mechId, status: "IN-PROCESS" },
      { mechanicId: req.params.mechId, status: "ACCEPTED" },
    ],
  })
    .exec()
    .then((response) => {
      console.log("RESPONSE")
      console.log(response)
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

//Update Status of Order
exports.updateOrder = async (req, res) => {

  let orderDetails = await OrderModel.findById(req.params.orderId);

  let customerDetails = await CustomerModel.findById(orderDetails.customerId)

  let providerDetails = await MemberModel.findById(orderDetails.serviceProviderId)

  let mechanicDetails = await MemberModel.findById(orderDetails.mechanicId)




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
     to: customerDetails.email,
     subject: 'Order status',// Subject line
     text: ' your order has been placed Successfully!!.\n',
    //  html : 'Service Provider details:\nService Provider name: $'
    html : `
    <h2>Your order's current status: <span style="color:#e92e4a;">${req.body.status}</span></h2>
    <br/>
    <p>Here are the details of your order and customer</p>
    <br/>
    <p>Customer Email: <span style="color:#e92e4a;">${customerDetails.email}</span></p>
    <br/>
    <p>Customer Name: <span style="color:#e92e4a;">${customerDetails.firstname}</span></p>
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
       to: providerDetails.email,
       subject: 'Order status from your mechanic',// Subject line
       text: ' your order has been placed Successfully!!.\n',
      //  html : 'Service Provider details:\nService Provider name: $'
      html : `
      <h2>Your mechanic has <span style="color:#e92e4a;">${req.body.status}</span> the order against order ID: <span style="color:#e92e4a;">${orderDetails._id}</span></h2>
      <br/>
      <p>Here are the details of the order and mechanic</p>
      <br/>
      <p>Mechanic Email: <span style="color:#e92e4a;">${mechanicDetails.email}</span></p>
      <br/>
      <p>Mechanic Name: <span style="color:#e92e4a;">${mechanicDetails.firstname}</span></p>
      <br/>
      <p>Mechanic phone: <span style="color:#e92e4a;">${mechanicDetails.mobile}</span></p>
      <br/>
      <p>We’re glad you’re here!</p>
      <p style="color:#e92e4a;">The CarSaz team</p>`,
       
   // html : 'To reset your password, click this <a href="' + '"><span>link</span></a>.<br>This is a <b>test</b> email.'
      };





  OrderModel.updateOne(
    { _id: req.params.orderId },
    { $set: { status: req.body.status } }
  )
    .exec()
    .then((response) => {
      OrderModel.findOne({ _id: req.params.orderId })
        .exec()
        .then((obj) => {
          //console.log(obj);
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

          const mechId = obj.mechanicId;
          console.log("Mechanic Id: " + mechId);
          if (req.body.status === "ACCEPTED") {
            MemberModel.updateOne(
              { _id: obj.mechanicId },
              {
                $set: { status: "NOT AVAILABLE" },
              }
            )
              .then((response) => {
                console.log("Member Status: NOT AVAILABLE");
              })
              .catch((err) => {
                console.log("Member Status Error: " + err);
              });
          } else {
            MemberModel.updateOne(
              { _id: obj.mechanicId },
              {
                $set: { status: "AVAILABLE" },
              }
            )
              .then((response) => {
                console.log("Member Status: AVAILABLE");
              })
              .catch((err) => {
                console.log("Member Status Error: " + err);
              });
          }
        })
        .catch((err) => {
          console.log("Find Order Error: " + err);
        });
      console.log("Order Updated Successfully");
      res.status(200).json({
        message: "Request Updated Successfully",
      });
    })
    .catch((err) => {
      console.log("Order Update error: " + err);
      res.status(500).json({ "Order Update error ": err });
    });
};

//Find My Orders
exports.findMyOrders = (req, res) => {
  OrderModel.find({ mechanicId: req.params.mechId })
    .exec()
    .then((response) => {
      if (response.length == 0) {
        res.status(200).json({
          message: "No Orders are available",
        });
      } else {
        res.status(200).json({ orders: response });
      }
    })
    .catch((err) => {
      console.log("Find All Orders Error: " + err);
      res.status(500).json({
        error: err,
      });
    });
};
