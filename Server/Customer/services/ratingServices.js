const express = require("express");
const router = express.Router();
const checkAuth = require("../middlewares/check-auth");
const RatingController = require("../controllers/ratingController");

router.post("/rate-product", [checkAuth.verifyToken, checkAuth.isCustomer], RatingController.rateProvider);

router.post("/rate-productPhone", [checkAuth.verifyTokenPhone], RatingController.rateProviderPhone);

router.put("/find-rated-user", RatingController.findRatedUser);

router.get("/featured-product", RatingController.featuredProduct);

module.exports = router;