import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/screens/login/login_screen.dart';
import 'package:fyp_mobile_app/screens/welcome/components/body.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
