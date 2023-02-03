import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:provider/provider.dart';

import '../../../providers/buttonActive.dart';
import '../../../providers/emailPasswordProvider.dart';
import '../../../providers/textController.dart';

class InputField extends StatefulWidget {
  InputField({
    Key? key,
    required this.hintTextField,
    this.keyboardType,
    required this.choice,
    required this.validate,
  }) : super(key: key);

  final String hintTextField;
  final keyboardType;
  final int choice;
  final validate;
  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(
            left: kDefaultPadding,
            right: kDefaultPadding,
            bottom: kDefaultPadding / 2,
          ),
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 5),
          child: TextFormField(
            validator: widget.validate,
            onChanged: (value) {
              if (widget.choice == 1) {
                Provider.of<Email>(context, listen: false).setFirstName(value);
              } else if (widget.choice == 2) {
                Provider.of<Email>(context, listen: false).setLastName(value);
              } else if (widget.choice == 5) {
                Provider.of<Email>(context, listen: false).setAddress(value);
              }
            },
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              hintText: "${widget.hintTextField}",
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
        ),
      ],
    );
  }
}
