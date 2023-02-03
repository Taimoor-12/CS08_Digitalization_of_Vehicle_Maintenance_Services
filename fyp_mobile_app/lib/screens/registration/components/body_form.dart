import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/providers/buttonActive.dart';
import 'package:fyp_mobile_app/providers/emailPasswordProvider.dart';
import 'package:fyp_mobile_app/providers/textController.dart';
import 'package:fyp_mobile_app/screens/components/login_heading_with_text.dart';
import 'package:fyp_mobile_app/screens/components/switch_login_screen_button.dart';
import 'package:fyp_mobile_app/screens/login/components/password_text_field.dart';
import 'package:fyp_mobile_app/screens/registration/components/inputField.dart';
import 'package:fyp_mobile_app/screens/registration/components/sign_up_button.dart';
import 'package:fyp_mobile_app/screens/registration/components/verify_email_otp.dart';
import 'package:fyp_mobile_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:fyp_mobile_app/screens/login/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../dashboard/dashboard.dart';

class BodyForm extends StatefulWidget {
  const BodyForm({Key? key}) : super(key: key);

  static final AuthService authService = AuthService();
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  State<BodyForm> createState() => _BodyFormState();
}

class _BodyFormState extends State<BodyForm> {
  bool _isInAsyncCall = false;

  void setAsyncBool() {
    setState(() {
      _isInAsyncCall = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void signUpUser() {
      BodyForm.authService.SignUpUser(
        context: context,
        func: setAsyncBool,
        email: Provider.of<Email>(context, listen: false).email,
        password: Provider.of<Email>(context, listen: false).password,
        firstName: Provider.of<Email>(context, listen: false).firstName,
        lastName: Provider.of<Email>(context, listen: false).lastName,
        page: "Register",
      );
    }

    Future save() async {
      String name = "";
      var url = Uri.http(uri, '/api/users/register');
      var res = await http.post(
        url,
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'name': Provider.of<Email>(context, listen: false).fullName,
          'email': Provider.of<Email>(context, listen: false).email,
          'password': Provider.of<Email>(context, listen: false).password,
          'address': Provider.of<Email>(context, listen: false).homeAdress,
        },
      );
      if (res.statusCode == 200) {
        Provider.of<Email>(context, listen: false).setFullName(res.body);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Dashboard();
            },
          ),
        );
      } else {
        print(res.statusCode);
      }
    }

    return ModalProgressHUD(
      inAsyncCall: _isInAsyncCall,
      child: SingleChildScrollView(
        child: Form(
          key: BodyForm.formKey,
          child: Column(
            children: [
              LoginHeadingWithText(
                size: size,
                title: "Enter Information",
                text: "About yourself",
                padBottom: 0,
                padTop: kDefaultPadding,
              ),
              SizedBox(
                height: 30,
              ),
              InputField(
                hintTextField: "First name",
                keyboardType: TextInputType.name,
                choice: 1,
                validate: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Enter something';
                  } else if (value != null &&
                      RegExp(r'^[a-zA-Z ]+$').hasMatch(value) == false) {
                    return 'Enter your first name';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              InputField(
                hintTextField: "Last name",
                keyboardType: TextInputType.name,
                choice: 2,
                validate: (String? value) {
                  if (value != null && value.isEmpty) {
                    return 'Enter something';
                  } else if (value != null &&
                      RegExp(r'^[a-zA-Z ]+$').hasMatch(value) == false) {
                    return 'Enter your last name';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              PasswordTextField(
                hintText: "Password",
                page: "Register",
              ),
              SizedBox(
                height: 10,
              ),
              PasswordTextField(
                hintText: "Confirm Password",
                page: "Register",
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // InputField(8
              //   hintTextField: "Address (Format: House#, Block, Society)",
              //   keyboardType: TextInputType.streetAddress,
              //   choice: 5,
              //   validate: (String? value) {
              //     if (value != null && value.isEmpty) {
              //       return 'Enter something';
              //     } else if (value != null &&
              //         RegExp(r'^[#.0-9a-zA-Z\s,-]+$').hasMatch(value) == false) {
              //       return 'Enter correct home address';
              //     } else {
              //       return null;
              //     }
              //   },
              // ),
              SizedBox(
                height: 10,
              ),
              SignUpButton(
                size: size,
                // active: Provider.of<ButtonActive>(context).activeAll(
                //   Provider.of<ButtonActive>(context).nameActive,
                //   Provider.of<ButtonActive>(context).vehicleActive,
                //   Provider.of<ButtonActive>(context).makeActive,
                //   Provider.of<ButtonActive>(context).modelActive,
                //   Provider.of<ButtonActive>(context).homeaddressActive,
                //   Provider.of<ButtonActive>(context).activeButtonPassword,
                // ),
                press: () {
                  print(BodyForm.formKey.currentState);
                  if (BodyForm.formKey.currentState != null) {
                    if (BodyForm.formKey.currentState?.validate() == true) {
                      // save();
                      setState(() {
                        _isInAsyncCall = true;
                      });
                      signUpUser();
                      // Navigator.pushNamed(
                      //     context, VerifyEmailOTPScreen.routeName);
                    }
                  }
                },
              ),
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
