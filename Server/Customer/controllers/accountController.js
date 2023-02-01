const Customer = require("../model/customerModel");
const { Num } = require("../model/numberModel");
const bcrypt = require("bcrypt");
const cloudinary = require("cloudinary").v2;
cloudinary.config({ 
  cloud_name: 'do5n008aj', 
  api_key: '652113393421791', 
  api_secret: 'XKH8E9ytU54tTXPsuZPdu94HZJQ',
  secure: true
});


exports.updateCustomer = (req, res) => {
  const id = req.params.custId;
  Customer.updateOne({ _id: id }, { $set: req.body })
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

exports.addProfilePicture = (req, res) => {
  try{
    console.log('Here');
        const file=req.files.image;
        cloudinary.uploader.upload(file.tempFilePath, async (err,result)=>{
          // const { id } = req.body;
          console.log(req.userId);
      
          let user = await Customer.findById(req.userId);
      
          user.image = result.url;
      
          user.save().then((res) => {
            console.log("image is saved");
            }).catch((err) => {
              console.log(err, "error has occur");
              });
              res.json(user);
            });
      }


      catch (e) {
        console.log('Error')
        res.status(500).json({error: e.message})
       }
  

};

exports.removePic = async (req, res) => {
  try {
    console.log(req.userId)
        let user = await Customer.findByIdAndUpdate(req.userId, {image: ""})
        
       //  user.image = {
       //    data: fs.readFileSync("uploads/" + req.file.originalname),
       //    contentType: "image/png",
       //    };
       //    console.log('here')

       //    user.save().then((res) => {
       //      console.log("image is saved");
       //      }).catch((err) => {
       //        console.log(err, "error has occur");
       //        });
              res.json(user);

   }

   catch (e) {
    console.log('Error')
    res.status(500).json({error: e.message})
   }
};


exports.addProfilePicturePhone = (req, res) => {
  try{
    
        const file=req.files.image;
        cloudinary.uploader.upload(file.tempFilePath, async (err,result)=>{
          // const { id } = req.body;
          // console.log(req._id)
          let user = await Num.findById(req._id);
      
          user.image = result.url;
      
          user.save().then((res) => {
            console.log("image is saved");
            }).catch((err) => {
              console.log(err, "error has occur");
              });
              res.json(user);
            });
      }


      catch (e) {
        console.log('Error')
        res.status(500).json({error: e.message})
       }
  

};


exports.removePicPhone = async (req, res) => {
  try {
    
        let user = await Num.findByIdAndUpdate(req._id, {image: ""})
        
       //  user.image = {
       //    data: fs.readFileSync("uploads/" + req.file.originalname),
       //    contentType: "image/png",
       //    };
       //    console.log('here')

       //    user.save().then((res) => {
       //      console.log("image is saved");
       //      }).catch((err) => {
       //        console.log(err, "error has occur");
       //        });
              res.json(user);

   }

   catch (e) {
    console.log('Error')
    res.status(500).json({error: e.message})
   }
};


exports.updateProfile = (req, res) => {
  const id = req.params.custId;
  Customer.updateOne({ _id: id }, { $set: req.body })
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

//for updating password and hashing it

exports.updatePassword = async (req, res) => {
  try {
      
    const { password } = req.body;
  
    let user = await Customer.findById(req.userId)
  
    user.password = password
    
  
    await user.generateHashedPassword()
  
    user = await user.save();
  
    res.json(user)
    }
  
    catch (e) {
      res.status(500).json({error: e.message});
    }
}

//for updating phone password and hashing it
exports.updatePasswordPhone = async (req, res) => {
  try {
      
    const { password } = req.body;
  
    let user = await Num.findById(req._id)
  
    user.password = password
    
  
    await user.generateHashedPassword()
  
    user = await user.save();
  
    res.json(user)
    }
  
    catch (e) {
      res.status(500).json({error: e.message});
    }
}

//for phone user (flutter)
exports.updateProfilePhone = (req, res) => {
  const id = req.params.custId;
  Num.updateOne({ _id: id }, { $set: req.body })
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

// exports.getAllCustomers = (req, res) => {
//   Customer.find()
//     .select("name email _id")
//     .exec()
//     .then((results) => {
//       const response = {
//         count: results.length,
//         products: results.map((result) => {
//           return {
//             name: result.name,
//             email: result.email,
//             _id: result._id,
//             request: {
//               type: "GET",
//               url:
//                 "http://localhost:8080/customer/account/findCustById/" +
//                 result._id,
//             },
//           };
//         }),
//       };
//       if (results.length > 0) {
//         res.status(200).json(response);
//       } else {
//         res.status(200).json("Empty List");
//       }
//     })
//     .catch((err) => {
//       console.log("Get All Customers Error" + err);
//       res.status(500).json({
//         error: err,
//       });
//     });
// };

exports.findAll = (req, res) => {
  Customer.find()
 
    .exec()
    .then((response) => {
      if (response.length == 0) {
        res.status(200).json({
          message: "Add a Mechanic",
        });
      } else {
        res.status(200).json({
          response,
        });
      }
    })
    .catch((err) => {
      console.log(err);
      res.status(500).json({
        error: err,
      });
    });
};

exports.findCustById = (req, res) => {
  Customer.findById({ _id: req.params.custId })
    .select("name email _id")
    .exec()
    .then((result) => {
      if (result) {
        return res.status(200).json({
          name: result.name,
          email: result.email,
          _id: result._id,
        });
      } else {
        return res.status(404).json({ message: "Invalid Id" });
      }
    })
    .catch((err) => {
      console.log("FInd Customer By Id: " + err);
      res.status(500).json({
        error: err,
      });
    });
};

exports.deleteCustomer = (req, res) => {
  Customer.deleteOne({ _id: req.params.custId })
    .exec()
    .then((result) => {
      res.status(200).json({
        message: "Account deleted Successfully",
      });
    })
    .catch((err) => {
      console.log("Delete Customer: " + err);
      res.status(500).json({
        error: err,
      });
    });
};
