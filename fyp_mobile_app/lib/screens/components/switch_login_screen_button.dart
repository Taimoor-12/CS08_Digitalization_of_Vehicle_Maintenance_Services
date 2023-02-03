import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/screens/registration/registration_screen.dart';

class SwitchLoginScreenButton extends StatelessWidget {
  const SwitchLoginScreenButton({
    Key? key,
    required this.text,
    required this.textButton,
    required this.press,
  }) : super(key: key);

  final String text;
  final String textButton;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$text",
          ),
          TextButton(
            onPressed: press,
            child: Text(
              "$textButton",
              style: TextStyle(
                color: kTextColor,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
