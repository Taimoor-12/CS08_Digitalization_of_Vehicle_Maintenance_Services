import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/screens/login/components/forget_password_screen.dart';

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: EdgeInsets.only(bottom: kDefaultPadding),
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, ForgetPassword.routeName);
        },
        child: Text(
          "Forgot Password?",
          style: TextStyle(
            color: kTextColor,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
