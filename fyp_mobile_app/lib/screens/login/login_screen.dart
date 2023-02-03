import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/screens/login/components/body.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login-screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Body(),
    );
  }
}
