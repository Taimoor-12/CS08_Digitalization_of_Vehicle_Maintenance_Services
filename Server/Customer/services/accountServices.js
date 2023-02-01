const express = require("express");
const router = express.Router();
const checkAuth = require("../middlewares/check-auth");
const AccountController = require("../controllers/accountController");




router.get(
  "/findAll",
  // checkAuth.verifyToken,
  AccountController.findAll
);

router.put(
  "/updateCustomer/:custId",
 
  AccountController.updateCustomer
);

router.get("/findCustById/:custId", AccountController.findCustById);

router.put(
  "/updateProfile/:custId",
  [checkAuth.verifyToken, checkAuth.isCustomer],
  AccountController.updateProfile
);

//to update phone number user info (for flutter)
router.put(
  "/updateProfilePhone/:custId",
  [checkAuth.verifyTokenPhone, checkAuth.isCustomerPhone],
  AccountController.updateProfilePhone
);
// to update password (for flutter)
router.put("/updatePassword/:custId", 
[checkAuth.verifyToken, checkAuth.isCustomer], 
AccountController.updatePassword);

// to update phone password (for flutter)
router.put("/updatePasswordPhone/:custId", 
[checkAuth.verifyTokenPhone, checkAuth.isCustomerPhone], 
AccountController.updatePasswordPhone);


router.delete(
  "/deleteCustomer/:custId",
  // [checkAuth.verifyToken, checkAuth.isCustomer],
  AccountController.deleteCustomer
);

router.post("/add-profile-picture", [checkAuth.verifyToken, checkAuth.isCustomer], AccountController.addProfilePicture);
router.post("/add-profile-picture-phone", [checkAuth.verifyTokenPhone, checkAuth.isCustomerPhone], AccountController.addProfilePicturePhone);

router.put("/remove-pic", [checkAuth.verifyToken, checkAuth.isCustomer], AccountController.removePic);
router.put("/remove-pic-phone", [checkAuth.verifyTokenPhone, checkAuth.isCustomerPhone], AccountController.removePicPhone);

module.exports = router;
