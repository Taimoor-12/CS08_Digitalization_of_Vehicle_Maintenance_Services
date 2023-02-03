import 'package:flutter/material.dart';

import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/screens/login/login_screen.dart';

class CheckEmailScreen extends StatefulWidget {
  static const String routeName = "/check-email-screen";
  const CheckEmailScreen({Key? key}) : super(key: key);

  @override
  State<CheckEmailScreen> createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends State<CheckEmailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        foregroundColor: kBackgroundColor,
        backgroundColor: kBackgroundColor,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              right: kDefaultPadding,
              left: kDefaultPadding,
              top: kDefaultPadding * 2,
            ),
            height: size.height * 0.4,
            width: size.width * 0.8,
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.7),
              borderRadius: BorderRadius.circular(36),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 100,
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Text(
                    'An email with a reset link was sent to you. Kindly check your inbox to reset your password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding * 4),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.routeName, (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor.withOpacity(0.7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                  elevation: 4.5,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.keyboard_backspace_rounded,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Back to Login",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
