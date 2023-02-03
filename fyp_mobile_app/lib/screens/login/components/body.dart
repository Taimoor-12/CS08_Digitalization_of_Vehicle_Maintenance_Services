import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/providers/buttonActive.dart';
import 'package:fyp_mobile_app/screens/components/dividing_line.dart';
import 'package:fyp_mobile_app/screens/components/google_sign.dart';
import 'package:fyp_mobile_app/screens/components/sign_in_button.dart';
import 'package:fyp_mobile_app/screens/components/emailPhone_text_field.dart';
import 'package:fyp_mobile_app/screens/dashboard/dashboard.dart';
import 'package:fyp_mobile_app/screens/login/components/forget_password_button.dart';
import 'package:fyp_mobile_app/screens/components/login_heading_with_text.dart';
import 'package:fyp_mobile_app/screens/login/components/password_text_field.dart';
import 'package:fyp_mobile_app/screens/components/switch_login_screen_button.dart';
import 'package:fyp_mobile_app/screens/registration/registration_screen.dart';
import 'package:provider/provider.dart';
import 'package:fyp_mobile_app/fetchScreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/emailPasswordProvider.dart';
import '../../../providers/swapButtonProvider.dart';
import '../../../services/auth_service.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthService authService = AuthService();

  bool _isInAsyncCall = false;

  Future save() async {
    var url = Uri.http('192.168.100.9:3000', '/api/users/login');
    var res = await http.post(
      url,
      headers: <String, String>{
        'Context-Type': 'application/json;charSet=UTF-8'
      },
      body: <String, String>{
        'email': Provider.of<Email>(context, listen: false).email,
        'password': Provider.of<Email>(context, listen: false).password,
      },
    );
    if (res.statusCode == 200) {
      Provider.of<Email>(context, listen: false).setFullName(res.body);
    } else {
      print(res.statusCode);
    }
  }

  final formKey = GlobalKey<FormState>();

  void setAsyncBool() {
    setState(() {
      _isInAsyncCall = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    void signInUser() {
      authService.SignInUser(
        context: context,
        email: Provider.of<Email>(context, listen: false).email,
        password: Provider.of<Email>(context, listen: false).password,
        func: setAsyncBool,
      );
    }

    return ModalProgressHUD(
      inAsyncCall: _isInAsyncCall,
      opacity: 0.5,
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              LoginHeadingWithText(
                size: size,
                title: "Login",
                text: "And start booking services",
                padBottom: kDefaultPadding,
                padTop: kDefaultPadding * 3,
              ),
              EmailOrPhoneTextField(
                size: size,
              ),
              PasswordTextField(
                hintText: "Password",
                page: "Login",
              ),
              ForgetPasswordButton(),
              SignInButton(
                size: size,
                text: "Sign In",
                press: () {
                  print(formKey.currentState);
                  if (formKey.currentState != null) {
                    if (formKey.currentState?.validate() == true) {
                      // save();
                      if (Provider.of<SwapButtonProvider>(context,
                                  listen: false)
                              .eField ==
                          false) {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          _isInAsyncCall = true;
                        });
                        authService.SignInUserPhone(
                            context: context,
                            func: setAsyncBool,
                            phone: Provider.of<Email>(context, listen: false)
                                .phone,
                            password: Provider.of<Email>(context, listen: false)
                                .password);
                      } else {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          _isInAsyncCall = true;
                        });
                        signInUser();
                      }
                    }
                  }
                },
              ),
              DividingLine(),
              SwitchLoginScreenButton(
                text: "Don't have an account?",
                textButton: "Register Now",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return RegistrationScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
