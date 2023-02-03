import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/providers/emailPasswordProvider.dart';
import 'package:fyp_mobile_app/providers/user_provider.dart';
import 'package:fyp_mobile_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditPassword extends StatefulWidget {
  static const String routeName = '/edit-password';

  const EditPassword({Key? key}) : super(key: key);

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  final formKey = GlobalKey<FormState>();
  late String oldPass;

  bool _isInAsyncCall = false;

  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmNewPasswordController;
  AuthService authService = AuthService();

  @override
  void initState() {
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmNewPasswordController = TextEditingController();
    getPassword();
    super.initState();
  }

  void getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? password = await prefs.getString('password');
    if (password != null) {
      Provider.of<Email>(context, listen: false).setPassword(password);
    }
  }

  void setAsyncBool() {
    setState(() {
      _isInAsyncCall = false;
    });
  }

  bool _oldPasswordEye = true;
  bool _newPasswordEye = true;
  bool _confirmPasswordEye = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String oldPass = Provider.of<Email>(context).password;
    final user = Provider.of<UserProvider>(context, listen: false).user;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Password',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
        backgroundColor: kPrimaryColor,
        foregroundColor: kTextColor,
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isInAsyncCall,
        opacity: 0.5,
        child: Container(
          padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              top: kDefaultPadding),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Make sure your password is 8 characters or longer',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: oldPasswordController,
                    obscureText: _oldPasswordEye,
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return 'Enter something';
                      } else if (value != null && value.length < 8) {
                        return 'Password must be 8 chars or more';
                      } else if (value != null && value != oldPass) {
                        return 'Your old password is not correct';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _oldPasswordEye = !_oldPasswordEye;
                          });
                        },
                        icon: Icon(_oldPasswordEye == true
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      border: OutlineInputBorder(),
                      hintText: 'Old password',
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: newPasswordController,
                    obscureText: _newPasswordEye,
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return 'Enter something';
                      } else if (value != null && value.length < 8) {
                        return 'Password must be 8 chars or more';
                      } else if (value != null &&
                          value != confirmNewPasswordController.text) {
                        return 'New password does not match';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _newPasswordEye = !_newPasswordEye;
                          });
                        },
                        icon: Icon(_newPasswordEye == true
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      border: OutlineInputBorder(),
                      hintText: 'New password',
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: confirmNewPasswordController,
                    obscureText: _confirmPasswordEye,
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return 'Enter something';
                      } else if (value != null && value.length < 8) {
                        return 'Password must be 8 chars or more';
                      } else if (value != null &&
                          value != newPasswordController.text) {
                        return 'New password does not match';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _confirmPasswordEye = !_confirmPasswordEye;
                          });
                        },
                        icon: Icon(_confirmPasswordEye == true
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      border: OutlineInputBorder(),
                      hintText: 'Confirm new password',
                    ),
                  ),
                  // Spacer(),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: kDefaultPadding),
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState != null) {
                          if (formKey.currentState?.validate() == true) {
                            // if (oldPasswordController.text == oldPass) {
                            //   print('yeah');
                            // } else {
                            //   print('Not yeah');
                            // }

                            if (user.role == 'email') {
                              setState(() {
                                _isInAsyncCall = true;
                              });
                              authService.updatePassword(
                                  context: context,
                                  func: setAsyncBool,
                                  id: user.id,
                                  newPassword:
                                      confirmNewPasswordController.text);
                            } else {
                              setState(() {
                                _isInAsyncCall = true;
                              });
                              authService.updatePasswordPhone(
                                  context: context,
                                  func: setAsyncBool,
                                  id: user.id,
                                  newPassword:
                                      confirmNewPasswordController.text);
                            }
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        elevation: 4.5,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.save_as_sharp,
                            size: 30,
                          ),
                          SizedBox(
                            width: size.width * 0.28,
                          ),
                          Text(
                            "Save",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
