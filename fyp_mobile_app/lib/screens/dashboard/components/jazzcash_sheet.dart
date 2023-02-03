import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/providers/emailPasswordProvider.dart';
import 'package:fyp_mobile_app/providers/user_provider.dart';
import 'package:fyp_mobile_app/services/jazzcash_service.dart';
import 'package:provider/provider.dart';

class JazzCashSheet extends StatefulWidget {
  const JazzCashSheet({Key? key, required this.amount}) : super(key: key);

  final String amount;

  @override
  State<JazzCashSheet> createState() => _JazzCashSheetState();
}

class _JazzCashSheetState extends State<JazzCashSheet> {
  late TextEditingController phoneController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final JazzCashService jazzCashService = JazzCashService();
  @override
  void initState() {
    phoneController = TextEditingController();
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    // if (userProvider.user.role == 'number') {
    //   phoneController.text = userProvider.user.number;
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                // borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  'assets/icons/jazzcash.png',
                  fit: BoxFit.cover,
                  height: 100,
                  width: 200,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    Provider.of<Email>(context, listen: false).setPhone(value);
                  },
                  // validator: (String? value) {
                  //   if (value != null && value.isEmpty) {
                  //     return 'Enter something';
                  //   } else if (value != null &&
                  //       RegExp(r'^[a-zA-Z]+$').hasMatch(value) ==
                  //           false) {
                  //     return 'Enter your car name';
                  //   } else {
                  //     return null;
                  //   }
                  // },

                  validator: (String? value) {
                    if (value != null && value.isEmpty) {
                      return 'Enter something';
                    } else if (value != null && value.length < 11) {
                      return 'Enter valid phone number';
                    } else if (value != null &&
                        RegExp(r'^[0-9]+$').hasMatch(value) == false) {
                      return 'Enter your phone number';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '03212345678',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: kTextColor.withOpacity(0.2),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.redAccent, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber, width: 2)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2)),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.only(bottom: kDefaultPadding),
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState != null) {
                      if (formKey.currentState?.validate() == true) {
                        // jazzCashService.payment(
                        //     amount: widget.amount, phone: phoneController.text);
                        jazzCashService.payment(
                            amount: widget.amount, phone: phoneController.text);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    elevation: 4.5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.payment,
                        size: 30,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Pay",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
