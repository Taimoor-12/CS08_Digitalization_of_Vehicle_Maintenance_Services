// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fyp_mobile_app/constants.dart';
// import 'package:fyp_mobile_app/providers/emailPasswordProvider.dart';
// import 'package:fyp_mobile_app/providers/user_provider.dart';
// import 'package:fyp_mobile_app/services/order_service.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
//
// class AddressPageManual extends StatefulWidget {
//   static const String routeName = '/address-manual';
//   const AddressPageManual({Key? key}) : super(key: key);
//
//   @override
//   State<AddressPageManual> createState() => _AddressPageManualState();
// }
//
// class _AddressPageManualState extends State<AddressPageManual> {
//   late TextEditingController phoneController;
//   late TextEditingController houseNoController;
//   late TextEditingController blockController;
//   late TextEditingController societyController;
//   late TextEditingController cityController;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   Map<String, dynamic>? paymentIntent;
//   OrderService orderService = OrderService();
//
//   bool _isInAsyncCall = false;
//
//   @override
//   void initState() {
//     phoneController = TextEditingController();
//     houseNoController = TextEditingController();
//     blockController = TextEditingController();
//     societyController = TextEditingController();
//     cityController = TextEditingController();
//
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     if (userProvider.user.role == 'number') {
//       phoneController.text = userProvider.user.number;
//     }
//     cityController.text = "Lahore";
//     super.initState();
//   }
//
//   Future<void> makePayment(
//       String amount, String address, int totalSum, String phone) async {
//     try {
//       paymentIntent = await createPaymentIntent(amount, 'USD');
//       //Payment Sheet
//       await Stripe.instance
//           .initPaymentSheet(
//               paymentSheetParameters: SetupPaymentSheetParameters(
//                   paymentIntentClientSecret: paymentIntent!['client_secret'],
//                   // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
//                   // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
//                   style: ThemeMode.dark,
//                   merchantDisplayName: 'Taimoor'))
//           .then((value) {
//         setState(() {
//           _isInAsyncCall = false;
//         });
//       });
//
//       ///now finally display payment sheeet
//       displayPaymentSheet(address, totalSum, phone);
//     } catch (e, s) {
//       print('exception:$e$s');
//     }
//   }
//
//   displayPaymentSheet(String address, int totalSum, String phone) async {
//     try {
//       await Stripe.instance.presentPaymentSheet().then((value) {
//         showDialog(
//             context: context,
//             builder: (_) => AlertDialog(
//                   content: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Row(
//                         children: const [
//                           Icon(
//                             Icons.check_circle,
//                             color: Colors.green,
//                           ),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           Text("Payment Successful"),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ));
//         // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));
//
//         paymentIntent = null;
//         print('done');
//         print(totalSum);
//         // orderService.placeOrder(
//         //     context: context,
//         //     address: address,
//         //     totalSum: totalSum.toDouble(),
//         //     phone: phone);
//       }).onError((error, stackTrace) {
//         print('Error is:--->$error $stackTrace');
//       });
//     } on StripeException catch (e) {
//       print('Error is:---> $e');
//       showDialog(
//           context: context,
//           builder: (_) => const AlertDialog(
//                 content: Text("Cancelled "),
//               ));
//     } catch (e) {
//       print('$e');
//     }
//   }
//
//   //  Future<Map<String, dynamic>>
//   createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(amount),
//         'currency': currency,
//         'payment_method_types[]': 'card'
//       };
//
//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization': 'Bearer $SECRET_KEY',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       // ignore: avoid_print
//       print('Payment Intent Body->>> ${response.body.toString()}');
//       return jsonDecode(response.body);
//     } catch (err) {
//       // ignore: avoid_print
//       print('err charging user: ${err.toString()}');
//     }
//   }
//
//   calculateAmount(String amount) {
//     final calculatedAmout = (int.parse(amount)) * 100;
//     return calculatedAmout.toString();
//   }
//
//   void printMe() {
//     print('im herere');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final dollarProvider = Provider.of<Email>(context);
//     String address = "";
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: Text(
//           'Enter address information',
//           style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
//         ),
//         elevation: 0,
//         backgroundColor: kTextColor,
//         foregroundColor: Colors.white,
//       ),
//       body: ModalProgressHUD(
//         inAsyncCall: _isInAsyncCall,
//         opacity: 0.5,
//         child: Container(
//           margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
//           padding: EdgeInsets.only(top: kDefaultPadding),
//           child: Form(
//             key: formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextFormField(
//                   controller: phoneController,
//                   keyboardType: TextInputType.phone,
//                   validator: (String? value) {
//                     if (value != null && value.isEmpty) {
//                       return 'Enter something';
//                     } else if (value != null && value.length < 13) {
//                       return 'Enter valid phone number';
//                     } else if (value != null &&
//                         RegExp(r'^(?:[+]92)[0-9]{10}$').hasMatch(value) ==
//                             false) {
//                       return 'Enter your phone number';
//                     } else {
//                       return null;
//                     }
//                   },
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: 'Phone: +923202345678',
//                     hintStyle: TextStyle(
//                       fontSize: 16,
//                       color: kTextColor.withOpacity(0.2),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.grey)),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.blue)),
//                     errorBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.red)),
//                     focusedErrorBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.red)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: houseNoController,
//                   keyboardType: TextInputType.phone,
//                   validator: (String? value) {
//                     if (value != null && value.isEmpty) {
//                       return 'Enter something';
//                     } else if (value != null &&
//                         RegExp(r'^[0-9]+$').hasMatch(value) == false) {
//                       return 'Enter your house number';
//                     } else {
//                       return null;
//                     }
//                   },
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: 'House#',
//                     hintStyle: TextStyle(
//                       fontSize: 16,
//                       color: kTextColor.withOpacity(0.2),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.grey)),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.blue)),
//                     errorBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.red)),
//                     focusedErrorBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.red)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: blockController,
//                   keyboardType: TextInputType.text,
//                   validator: (String? value) {
//                     if (value != null && value.isEmpty) {
//                       return 'Enter something';
//                     } else if (value != null &&
//                         RegExp(r'^[a-zA-Z]+$').hasMatch(value) == false) {
//                       return 'Enter your block';
//                     } else {
//                       return null;
//                     }
//                   },
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: 'Block',
//                     hintStyle: TextStyle(
//                       fontSize: 16,
//                       color: kTextColor.withOpacity(0.2),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.grey)),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.blue)),
//                     errorBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.red)),
//                     focusedErrorBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.red)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: societyController,
//                   keyboardType: TextInputType.text,
//                   validator: (String? value) {
//                     if (value != null && value.isEmpty) {
//                       return 'Enter something';
//                     } else if (value != null &&
//                         RegExp(r'^[a-zA-Z ]+$').hasMatch(value) == false) {
//                       return 'Enter your society name';
//                     } else {
//                       return null;
//                     }
//                   },
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: 'Society',
//                     hintStyle: TextStyle(
//                       fontSize: 16,
//                       color: kTextColor.withOpacity(0.2),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.grey)),
//                     focusedBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.blue)),
//                     errorBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.red)),
//                     focusedErrorBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.red)),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: cityController,
//                   keyboardType: TextInputType.text,
//                   enabled: false,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: 'City',
//                     hintStyle: TextStyle(
//                       fontSize: 16,
//                       color: kTextColor.withOpacity(0.2),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(bottom: kDefaultPadding),
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       if (formKey.currentState != null) {
//                         if (formKey.currentState?.validate() == true) {
//                           print('validated');
//                           setState(() {
//                             _isInAsyncCall = true;
//                           });
//                           String money = dollarProvider.dollarMoney.toString();
//                           address = houseNoController.text +
//                               ", " +
//                               blockController.text +
//                               ", " +
//                               societyController.text +
//                               ", " +
//                               cityController.text;
//                           await makePayment(money, address,
//                               dollarProvider.rupeeMoney, phoneController.text);
//                         }
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       primary: kTextColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.only(
//                           topRight: Radius.circular(10),
//                           topLeft: Radius.circular(10),
//                           bottomRight: Radius.circular(10),
//                           bottomLeft: Radius.circular(10),
//                         ),
//                       ),
//                       elevation: 4.5,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.payment,
//                           size: 30,
//                         ),
//                         SizedBox(
//                           width: 15,
//                         ),
//                         Text(
//                           "Proceed to checkout",
//                           style: TextStyle(
//                             fontSize: 18,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
