import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/models/user_model.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../providers/user_provider.dart';

class ProfilePageTop extends StatelessWidget {
  const ProfilePageTop({
    Key? key,
    required this.size,
    required this.user,
  }) : super(key: key);

  final Size size;
  final user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      padding: EdgeInsets.only(
        top: kDefaultPadding,
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      decoration: BoxDecoration(
        color: kPrimaryColor,
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile',
              style: TextStyle(
                  fontSize: size.width / 18,
                  color: kTextColor,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 25,
            ),
            // Text(
            //   'Hi, ',
            //   style: Theme.of(context).textTheme.headline6!.copyWith(
            //         overflow: TextOverflow.ellipsis,
            //       ),
            // ),
            Text(
              '${user.firstName} ${user.lastName}',
              style: TextStyle(
                  fontSize: size.width / 18,
                  fontWeight: FontWeight.w600,
                  color: kTextColor),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              user.role == 'email' ? '${user.email}' : '${user.number}',
              style: TextStyle(fontSize: size.width / 28, color: kTextColor),
            ),
          ],
        ),
      ),
    );
  }
}
