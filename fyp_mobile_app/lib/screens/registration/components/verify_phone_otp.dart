import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/providers/emailPasswordProvider.dart';
import 'package:fyp_mobile_app/providers/user_provider.dart';
import 'package:fyp_mobile_app/services/auth_service.dart';
import 'package:pinput/pinput.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class VerifyPhoneOTP extends StatefulWidget {
  static const String routeName = "/verify-phone-otp";
  const VerifyPhoneOTP({Key? key, required this.phone}) : super(key: key);

  final String phone;

  @override
  State<VerifyPhoneOTP> createState() => _VerifyPhoneOTPState();
}

class _VerifyPhoneOTPState extends State<VerifyPhoneOTP> {
  AuthService authService = AuthService();
  bool _isInAsyncCall = false;

  void setAsyncBool() {
    setState(() {
      _isInAsyncCall = false;
    });
  }

  String finalPin = "";

  @override
  Widget build(BuildContext context) {
    String phone = Provider.of<Email>(context).phone;
    Size size = MediaQuery.of(context).size;
    phone = phone.replaceRange(3, 8, "********");
    final defaultPinTheme = PinTheme(
      width: size.width * 0.13,
      height: size.height * 0.08,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
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
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verification Code',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'We have sent verification code to',
                style: TextStyle(
                  color: kTextColor.withOpacity(0.6),
                  fontSize: 16,
                ),
              ),
              Text(
                phone,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Pinput(
                    androidSmsAutofillMethod:
                        AndroidSmsAutofillMethod.smsUserConsentApi,
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onCompleted: (pin) {
                      print(pin);
                      setState(() {
                        finalPin = pin;
                      });
                    },
                    onChanged: (pin) {
                      setState(() {
                        finalPin = "";
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  "Didn't receive code yet?",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero, // Set this
                    padding: EdgeInsets.zero, // and this
                  ),
                  onPressed: () {
                    setState(() {
                      _isInAsyncCall = true;
                    });

                    authService.SignUpUserPhone(
                        context: context,
                        func: setAsyncBool,
                        phone:
                            Provider.of<Email>(context, listen: false).phone);

                    // authService.SignUpUser(
                    //   context: context,
                    //   func: setAsyncBool,
                    //   email: Provider.of<Email>(context, listen: false).email,
                    //   password:
                    //   Provider.of<Email>(context, listen: false).password,
                    //   firstName: Provider.of<Email>(context, listen: false)
                    //       .firstName,
                    //   lastName:
                    //   Provider.of<Email>(context, listen: false).lastName,
                    // );
                  },
                  child: Text(
                    'Resend',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: kTextColor,
                    ),
                  ),
                ),
              ),
              Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: finalPin.isEmpty
                      ? null
                      : () {
                          String pinFinal = finalPin;
                          setState(() {
                            _isInAsyncCall = true;
                            finalPin = "";
                          });
                          final user =
                              Provider.of<UserProvider>(context, listen: false)
                                  .user;
                          print(user.id);
                          print(finalPin);
                          // authService.verifyEmailOTP(
                          //     context: context,
                          //     userId: user.id,
                          //     code: pinFinal,
                          //     func: setAsyncBool);
                          authService.verifyPhone(
                              context: context,
                              func: setAsyncBool,
                              phone: widget.phone,
                              firstName:
                                  Provider.of<Email>(context, listen: false)
                                      .firstName,
                              lastName:
                                  Provider.of<Email>(context, listen: false)
                                      .lastName,
                              password:
                                  Provider.of<Email>(context, listen: false)
                                      .password,
                              otp: pinFinal);
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
                        Icons.verified,
                        size: 30,
                      ),
                      SizedBox(
                        width: size.width * 0.28,
                      ),
                      Text(
                        "Verify",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
