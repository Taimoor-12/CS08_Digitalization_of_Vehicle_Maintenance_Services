import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fyp_mobile_app/providers/emailPasswordProvider.dart';
import '../../providers/buttonActive.dart';
import '../registration/form screen.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
    required this.size,
    required this.text,
    required this.press,
  }) : super(key: key);

  final Size size;
  final String text;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: kDefaultPadding),
      width: size.width,
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: ElevatedButton(
        onPressed: () {
          press();
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
          "$text",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
