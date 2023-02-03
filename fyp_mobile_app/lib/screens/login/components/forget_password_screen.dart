import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/providers/emailPasswordProvider.dart';
import 'package:fyp_mobile_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ForgetPassword extends StatefulWidget {
  static const String routeName = '/forget-password';

  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late TextEditingController messageTextController;

  bool _isInAsyncCall = false;

  @override
  void initState() {
    super.initState();
    messageTextController = TextEditingController();
  }

  @override
  void dispose() {
    messageTextController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();

  void setAsyncBool() {
    setState(() {
      _isInAsyncCall = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: kBackgroundColor,
        backgroundColor: kBackgroundColor,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
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
                    'Enter Email',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: kDefaultPadding * 3,
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
                    controller: messageTextController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? value) {
                      if (value != null && value.isEmpty) {
                        return 'Enter something';
                      } else if (value != null &&
                          EmailValidator.validate(
                                  Provider.of<Email>(context, listen: false)
                                      .email) ==
                              false) {
                        return 'Enter valid email';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      //Email().setEmail(value);
                      Provider.of<Email>(context, listen: false)
                          .setEmail(value);
                    },
                    decoration: InputDecoration(
                      hintText: "Email",
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
                          // print(messageTextController.text);
                          FocusScope.of(context).unfocus();
                          setState(() {
                            _isInAsyncCall = true;
                          });
                          authService.sendResetEmail(
                              context: context,
                              func: setAsyncBool,
                              email: messageTextController.text);
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
