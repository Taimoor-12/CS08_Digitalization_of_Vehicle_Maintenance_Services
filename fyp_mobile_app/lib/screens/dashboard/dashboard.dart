import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/body.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/body1.dart';

class Dashboard extends StatefulWidget {
  static const String routeName = '/dashboard-screen';
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   automaticallyImplyLeading: false,
      //   foregroundColor: kTextColor,
      //   backgroundColor: kPrimaryColor,
      // ),
      // resizeToAvoidBottomInset: false,
      body: Body1(),
    );
  }
}
