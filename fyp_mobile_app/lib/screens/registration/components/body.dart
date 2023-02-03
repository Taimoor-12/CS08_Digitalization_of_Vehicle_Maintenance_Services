import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/providers/buttonActive.dart';
import 'package:fyp_mobile_app/providers/swapButtonProvider.dart';
import 'package:fyp_mobile_app/screens/components/login_heading_with_text.dart';
import 'package:fyp_mobile_app/screens/components/emailPhone_text_field.dart';
import 'package:fyp_mobile_app/screens/components/sign_in_button.dart';
import 'package:fyp_mobile_app/screens/components/dividing_line.dart';
import 'package:fyp_mobile_app/screens/components/google_sign.dart';
import 'package:fyp_mobile_app/screens/components/switch_login_screen_button.dart';
import 'package:fyp_mobile_app/screens/login/login_screen.dart';
import 'package:fyp_mobile_app/screens/registration/components/verify_otp.dart';
import 'package:fyp_mobile_app/screens/registration/form%20screen.dart';
import 'package:fyp_mobile_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../providers/emailPasswordProvider.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  AuthService authService = AuthService();

  bool _isInAsyncCall = false;

  void setAsyncBool() {
    setState(() {
      _isInAsyncCall = false;
    });
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: _isInAsyncCall,
      opacity: 0.5,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              LoginHeadingWithText(
                size: size,
                title: "Register yourself",
                text: "And start booking services",
                padBottom: kDefaultPadding * 2,
                padTop: kDefaultPadding * 3,
              ),
              EmailOrPhoneTextField(size: size),
              SignInButton(
                size: size,
                press: () {
                  print(formKey.currentState);
                  if (formKey.currentState != null) {
                    final validated = formKey.currentState?.validate();
                    if (validated == true) {
                      print(Provider.of<Email>(context, listen: false).phone);
                      if (Provider.of<SwapButtonProvider>(context,
                                  listen: false)
                              .eField ==
                          false) {
                        FocusScope.of(context).unfocus();
                        // setState(() {
                        //   _isInAsyncCall = true;
                        // });
                        // authService.SignUpUserPhone(
                        //     context: context,
                        //     func: setAsyncBool,
                        //     phone: Provider.of<Email>(context, listen: false)
                        //         .phone);

                        Navigator.pushNamed(context, VerifyOTP.routeName);
                      } else {
                        FocusScope.of(context).unfocus();
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => FormScreen()));
                      }
                    }
                  }
                },
                text: "Proceed",
                // active: Provider.of<ButtonActive>(context).activeButtonEmailOrPhone,
              ),
              DividingLine(),
              // GoogleSignButton(size: size, text: "Sign Up with Google"),
              SwitchLoginScreenButton(
                text: "Already have an account?",
                textButton: "Log In",
                press: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
