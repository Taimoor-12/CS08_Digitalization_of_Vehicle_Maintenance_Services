import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/screens/welcome/components/login_registration_buttons.dart';
import 'package:fyp_mobile_app/screens/welcome/components/welcome_image.dart';
import 'package:fyp_mobile_app/screens/welcome/components/welcome_texts.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        WelcomeImage(size: size),
        WelcomeTexts(),
        Spacer(),
        LoginRegistrationButtons(size: size),
      ],
    );
  }
}
