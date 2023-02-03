import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:provider/provider.dart';

import '../../../providers/emailPasswordProvider.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton(
      {Key? key, required this.size, required this.press})
      : super(key: key);

  final Size size;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    bool validate(RegExp r, String content, String errMessage) {
      String name = content;
      final nameReg = r;
      final bool isValid = nameReg.hasMatch(name);

      if (isValid == true) {
        return true;
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errMessage)));
        return false;
      }
    }

    bool validatePassword() {
      String password = Provider.of<Email>(context, listen: false).password;

      if (password.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password should be 6 characters or more')));
        return false;
      } else {
        return true;
      }
    }

    return Container(
      padding: EdgeInsets.only(bottom: kDefaultPadding),
      width: size.width,
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: ElevatedButton(
        onPressed:
            () {
                press();
              },
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              topLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
          ),
          elevation: 4.5,
        ),
        child: Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
