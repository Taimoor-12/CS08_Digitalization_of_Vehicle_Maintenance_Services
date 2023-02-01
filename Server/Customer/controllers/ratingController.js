const { Num } = require("../model/numberModel");
const User = require("../model/customerModel");
const serviceModel = require("../model/serviceModel");


exports.rateProvider = async (req, res) => {
    try {
      const { id, rating, review, role } = req.body;
  
      let product = await serviceModel.findOne({ serviceProviderId: id })
      console.log(product);
  
      for (let i = 0; i < product.rating.length; i++) {
        if (product.rating[i].userId == req.userId) {
          product.rating.splice(i, 1);
          break;
        }
      }
      // console.log(req.user._id)
  
      
  
      const ratingSchema = {
        userId: req.userId,
        role,
        rating,
        review
      };
  
      product.rating.push(ratingSchema);
      product = await product.save();
      
      let average = 0
      for (let i = 0; i < product.rating.length; i++) {  // ya is lya ha taka koi 1 user 2 bari na rate kar saka.agr kara ga bhi to second rating sa first wali replace ho jai gi.
        
        average=average+product.rating[i].rating;
       
      
       
      }
      // console.log(average);
      average = average/product.rating.length;
      console.log(average);
    
      product.aver=average.toFixed(2);
      product = await product.save();
  
      
    
      
  
      
      res.json(product);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
};


exports.rateProviderPhone = async (req, res) => {
    try {
      const { id, rating, review, role } = req.body;
  
      let product = await serviceModel.findOne({ serviceProviderId: id })
  
      for (let i = 0; i < product.rating.length; i++) {
        if (product.rating[i].userId == req._id) {
          product.rating.splice(i, 1);
          break;
        }
      }
      // console.log(req.user._id)
  
      
  
      const ratingSchema = {
        userId: req._id,
        role,
        rating,
        review
      };
  
      product.rating.push(ratingSchema);
      product = await product.save();
      
      let average = 0
      for (let i = 0; i < product.rating.length; i++) {  // ya is lya ha taka koi 1 user 2 bari na rate kar saka.agr kara ga bhi to second rating sa first wali replace ho jai gi.
        
        average=average+product.rating[i].rating;
       
      
       
      }
      // console.log(average);
      average = average/product.rating.length;
      console.log(average);
    
      product.aver=average.toFixed(2);
      product = await product.save();
  
      
    
      
  
      
      res.json(product);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
};



exports.findRatedUser = async (req, res) => {

    const { id, role } = req.body;

    try {

         if(role == 'email') {
          let user = await User.findById(id);
          res.json(user);
         }
         else {
          let user = await Num.findById(id);
          res.json(user);
         }
    }
 
    catch (e) {
     console.log('Error')
     res.status(500).json({error: e.message})
    }
 
};


exports.featuredProduct = async (req, res) => {

    

    try {

        let product = await serviceModel.find({}).sort({aver: -1}).limit(3);
        res.json(product)
    }
 
    catch (e) {
     console.log('Error')
     res.status(500).json({error: e.message})
    }
 
};