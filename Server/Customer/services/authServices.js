const express = require("express");
const router = express.Router();
const checkAuth = require("../middlewares/check-auth");
const UsersController = require("../controllers/authController");
const NumbersController = require("../controllers/phoneController");



//For handling Get Requests
router.get("/allAccess", (req, res) => {
  res.status(200).send("Public Content.");
});

router.put("/forgotPassword", UsersController.forgotPassword);
router.put("/resetPassword", UsersController.resetPassword);

router.get(
  "/customerAccess",
  [checkAuth.verifyToken, checkAuth.verifyTokenPhone, checkAuth.isCustomer, checkAuth.isCustomerPhone],
  (req, res) => {
    res.status(200).send("Customer Content.");
  }
);

router.post("/register", UsersController.register);

router.post("/verifyOTP", UsersController.verifyOTP);

router.post("/login", UsersController.login);

router.post("/tokenIsValid", UsersController.tokenValidOrNot);
router.get('/persistentLoginFlutter', checkAuth.verifyToken, UsersController.persistentLogin);

router.post("/register-phone", NumbersController.registerPhone);
router.post("/verify-otp", NumbersController.verifyOtp);
router.post("/login-phone", NumbersController.loginPhone); 

router.post("/tokenIsValidPhone", NumbersController.tokenValidOrNot);
router.get('/persistentLoginFlutterPhone', checkAuth.verifyTokenPhone, NumbersController.persistentLogin);



module.exports = router;
