import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class GoogleSignButton extends StatelessWidget {
  const GoogleSignButton({
    Key? key,
    required this.size,
    required this.text,
  }) : super(key: key);

  final Size size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width / 2,
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: EdgeInsets.only(bottom: kDefaultPadding),
      child: SignInButton(
        Buttons.GoogleDark,
        text: "$text",
        onPressed: () {},
      ),
    );
  }
}
