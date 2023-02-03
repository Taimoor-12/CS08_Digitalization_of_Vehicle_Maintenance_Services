import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/screens/registration/components/body.dart';

class RegistrationScreen extends StatelessWidget {
  static const String routeName = '/registration-screen';
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
