const MemberModel = require("../model/memberModel");

exports.rateProvider = async (req, res) => {
    try {
      const { id, rating, review, role } = req.body;
  
      let product = await MemberModel.findById(id);
  
      for (let i = 0; i < product.rating.length; i++) {
        if (product.rating[i].userId == req.user._id) {
          product.rating.splice(i, 1);
          break;
        }
      }
      // console.log(req.user._id)
  
      
  
      const ratingSchema = {
        userId: req.user._id,
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