const express = require("express");
const router = express.Router();
const AuthController = require("../controllers/authController");
//const mechanicAuthController = require("../controllers/mechanicAuthController");
router.post("/login", AuthController.login);

router.post("/register", AuthController.register);

router.post("/verifyOTP", AuthController.verifyOTP);

router.get("/serviceProviderInformation/", AuthController.findProvider);

router.post("/registerMechanic", AuthController.registerMechanic);
router.put("/forgotPassword", AuthController.forgotPassword);
router.put("/resetPassword", AuthController.resetPassword);

//router.post("/getServiceProvider", AuthController.getServiceProvider)

module.exports = router;
