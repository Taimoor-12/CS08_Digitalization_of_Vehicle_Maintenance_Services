import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/services/auth_service.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PasswordResetPage extends StatefulWidget {
  static const String routeName = '/password-reset';
  const PasswordResetPage({Key? key}) : super(key: key);

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  final formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  bool _isInAsyncCall = false;

  late TextEditingController resetLinkController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    resetLinkController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    resetLinkController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void setAsyncBool() {
    setState(() {
      _isInAsyncCall = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: kBackgroundColor,
        backgroundColor: kBackgroundColor,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(
        inAsyncCall: _isInAsyncCall,
        opacity: 0.5,
        child: Form(
          key: formKey,
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: kDefaultPadding * 4,
                    left: kDefaultPadding / 5,
                    right: kDefaultPadding / 5,
                  ),
                  margin: EdgeInsets.only(
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                  ),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding * 2,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                    bottom: kDefaultPadding,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultPadding / 5),
                  child: TextFormField(
                    controller: resetLinkController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Reset Link",
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.blue)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    left: kDefaultPadding,
                    right: kDefaultPadding,
                    bottom: kDefaultPadding / 2,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: kDefaultPadding / 5),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return 'Enter something';
                      } else if (value != null && value.length < 8) {
                        return 'Password must be 8 chars or more';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Password",
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.blue)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.red)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.only(
                      bottom: kDefaultPadding,
                      left: kDefaultPadding,
                      right: kDefaultPadding),
                  width: size.width,
                  height: 60,
                  margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState != null) {
                        if (formKey.currentState?.validate() == true) {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            _isInAsyncCall = true;
                          });
                          authService.sendNewPassword(
                              context: context,
                              func: setAsyncBool,
                              resetLink: resetLinkController.text,
                              password: passwordController.text);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          topLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                      ),
                      elevation: 4.5,
                    ),
                    child: Text(
                      "Send password reset email",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
