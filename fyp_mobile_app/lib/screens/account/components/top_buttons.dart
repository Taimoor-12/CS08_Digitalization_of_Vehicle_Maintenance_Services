import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/screens/account/components/account_button.dart';
import 'package:fyp_mobile_app/screens/orders/orders.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/single_featured.dart';
import 'package:fyp_mobile_app/services/auth_service.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  final AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Your Orders',
              onTap: () {},
            ),
            AccountButton(
              text: 'Settings',
              onTap: () {},
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(
              text: 'Log Out',
              onTap: () {
                authService.logOut(context);
              },
            ),
            AccountButton(
              text: 'Delete Account',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
