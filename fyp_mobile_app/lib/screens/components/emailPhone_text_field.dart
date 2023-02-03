import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/providers/buttonActive.dart';
import 'package:fyp_mobile_app/providers/swapButtonProvider.dart';
import 'package:provider/provider.dart';
import 'package:fyp_mobile_app/providers/emailPasswordProvider.dart';

// bool eField = true;
// bool swapButton = true;

TextInputType keyboardType = TextInputType.emailAddress;

String email = "";

class EmailOrPhoneTextField extends StatefulWidget {
  const EmailOrPhoneTextField({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<EmailOrPhoneTextField> createState() => _EmailOrPhoneTextFieldState();
}

class _EmailOrPhoneTextFieldState extends State<EmailOrPhoneTextField> {
  late TextEditingController messageTextController;
  // String? email;
  // String? phoneNumber;

  @override
  void initState() {
    super.initState();
    messageTextController = TextEditingController();
  }

  @override
  void dispose() {
    messageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool eField = Provider.of<SwapButtonProvider>(context).eField;
    bool swapButton = Provider.of<SwapButtonProvider>(context).swapButton;
    return Column(
      children: [
        eField
            ? Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                ),
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 5),
                child: TextFormField(
                  controller: messageTextController,
                  keyboardType: keyboardType,
                  validator: (String? value) {
                    if (value != null && value.isEmpty) {
                      return 'Enter something';
                    } else if (value != null &&
                        EmailValidator.validate(
                                Provider.of<Email>(context, listen: false)
                                    .email) ==
                            false) {
                      return 'Enter valid email';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    //Email().setEmail(value);
                    Provider.of<Email>(context, listen: false).setEmail(value);
                  },
                  decoration: InputDecoration(
                    hintText: "Email",
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.blue)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.blue)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.red)),
                  ),
                ),
              )
            : Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                ),
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 5),
                child: TextFormField(
                  controller: messageTextController,
                  onChanged: (value) {
                    Provider.of<Email>(context, listen: false).setPhone(value);
                  },
                  validator: (String? value) {
                    if (value != null && value.isEmpty) {
                      return 'Enter something';
                    } else if (value != null && value.length < 13) {
                      return 'Enter valid phone number';
                    } else if (value != null &&
                        RegExp(r'^(?:[+]92)[0-9]{10}$').hasMatch(value) ==
                            false) {
                      return 'Enter your phone number';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "+923202345678",
                    hintStyle: TextStyle(
                        fontSize: 16, color: kTextColor.withOpacity(0.2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.blue)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.blue)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.red)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.red)),
                  ),
                ),
              ),
        swapButton
            ? SwapButton(
                text: "Use phone number instead",
                press: () {
                  setState(() {
                    keyboardType = TextInputType.number;
                    messageTextController.clear();
                    FocusScope.of(context).unfocus();
                  });
                  Provider.of<SwapButtonProvider>(context, listen: false)
                      .seteField(false);
                  Provider.of<SwapButtonProvider>(context, listen: false)
                      .setSwapButton(false);
                  Provider.of<Email>(context, listen: false)
                      .setEmailOrPhoneStatus(false);
                },
              )
            : SwapButton(
                text: "Use email instead",
                press: () {
                  setState(() {
                    keyboardType = TextInputType.emailAddress;
                    messageTextController.clear();
                    FocusScope.of(context).unfocus();
                  });
                  Provider.of<SwapButtonProvider>(context, listen: false)
                      .seteField(true);
                  Provider.of<SwapButtonProvider>(context, listen: false)
                      .setSwapButton(true);
                  Provider.of<Email>(context, listen: false)
                      .setEmailOrPhoneStatus(true);
                },
              ),
      ],
    );
  }
}

class SwapButton extends StatelessWidget {
  const SwapButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String text;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      // padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: TextButton(
        onPressed: press,
        child: Text(
          "$text",
          style: TextStyle(
            color: kTextColor,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
