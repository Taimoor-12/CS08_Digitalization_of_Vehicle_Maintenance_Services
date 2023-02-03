import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';

class DividingLine extends StatelessWidget {
  const DividingLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: kDefaultPadding / 2),
      child: Divider(
        color: Colors.black,
        thickness: 1,
        indent: 70,
        endIndent: 70,
      ),
    );
  }
}
