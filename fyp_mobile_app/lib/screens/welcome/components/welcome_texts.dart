import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';

class WelcomeTexts extends StatelessWidget {
  const WelcomeTexts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "At your desired\nplace and time\n\n",
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: kTextColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextSpan(
              text:
                  "With various vehicle maintenance services and corresponding service providers offering them, get your desired one right at your doorstep, beating hour long queues. ",
              style: Theme.of(context).textTheme.caption!.copyWith(
                    color: kTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
