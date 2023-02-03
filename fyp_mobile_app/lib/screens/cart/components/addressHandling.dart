// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fyp_mobile_app/constants.dart';
// import 'package:fyp_mobile_app/providers/emailPasswordProvider.dart';
// import 'package:fyp_mobile_app/providers/user_provider.dart';
// import 'package:fyp_mobile_app/screens/cart/components/addressHandlingManual.dart';
// import 'package:fyp_mobile_app/screens/components/bottom_bar.dart';
// import 'package:fyp_mobile_app/screens/loading_screen.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:fyp_mobile_app/utils.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:provider/provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:app_settings/app_settings.dart';
// import 'package:permission_handler/permission_handler.dart' as loc;
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:fyp_mobile_app/services/order_service.dart';
//
// class AddressPage extends StatefulWidget {
//   static const String routeName = '/address';
//   const AddressPage({Key? key}) : super(key: key);
//
//   @override
//   State<AddressPage> createState() => _AddressPageState();
// }
//
// class _AddressPageState extends State<AddressPage> {
//   late TextEditingController addressController;
//   late TextEditingController phoneController;
//   late bool addressFill;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   Map<String, dynamic>? paymentIntent;
//   OrderService orderService = OrderService();
//
//   @override
//   void initState() {
//     addressController = TextEditingController();
//     phoneController = TextEditingController();
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     if (userProvider.user.role == 'number') {
//       phoneController.text = userProvider.user.number;
//     }
//
//     if (Provider.of<Email>(context, listen: false).homeAdress.isEmpty) {
//       addressFill = false;
//     } else {
//       addressFill = true;
//     }
//     addressController.text =
//         Provider.of<Email>(context, listen: false).homeAdress;
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     phoneController.dispose();
//     addressController.dispose();
//     super.dispose();
//   }
//
//   String? _currentAddress;
//   Position? _currentPosition;
//   bool _isInAsyncCall = false;
//
//   // @override
//   // void initState() {
//   //   getCurrentPosition();
//   //   authService.getUserData(context: context);
//   //   super.initState();
//   // }
//
//   Future<bool?> handleLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location services are disabled. Please enable the services')));
//       setState(() {
//         _isInAsyncCall = false;
//       });
//       AppSettings.openLocationSettings();
//       return false;
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         setState(() {
//           _isInAsyncCall = false;
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('You denied location permission')));
//         openAppSettings();
//         return false;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       setState(() {
//         _isInAsyncCall = false;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Please allow permission so we can get your current address')));
//       openAppSettings();
//       return false;
//     }
//     return true;
//   }
//
//   Future<void> getCurrentPosition() async {
//     final hasPermission = await handleLocationPermission();
//
//     try {
//       if (!hasPermission!) {
//       } else {
//         await Geolocator.getCurrentPosition(
//                 desiredAccuracy: LocationAccuracy.best)
//             .then((Position position) {
//           setState(() => _currentPosition = position);
//           getAddressFromLatLng(_currentPosition!);
//         }).catchError((e) {
//           debugPrint(e);
//         });
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<void> getAddressFromLatLng(Position position) async {
//     try {
//       await placemarkFromCoordinates(
//               _currentPosition!.latitude, _currentPosition!.longitude)
//           .then((List<Placemark> placemarks) {
//         Placemark place = placemarks[0];
//         setState(() {
//           _currentAddress =
//               '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}';
//         });
//         print(_currentAddress?.trim());
//         Provider.of<Email>(context, listen: false).setAddress(_currentAddress!);
//         setState(() {
//           _isInAsyncCall = false;
//           addressFill = true;
//         });
//         showSnackBar(context, 'Location added');
//       }).catchError((e) {
//         debugPrint(e);
//       });
//     } catch (e) {
//       // TODO
//     }
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
//       ///
//       ///
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
//           context: context,
//           builder: (_) => AlertDialog(
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   children: const [
//                     Icon(
//                       Icons.check_circle,
//                       color: Colors.green,
//                     ),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     Text("Payment Successful"),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//         // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));
//
//         paymentIntent = null;
//         orderService.placeOrder(
//             context: context,
//             address: address,
//             totalSum: totalSum.toDouble(),
//             phone: phone);
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
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     addressController.text = Provider.of<Email>(context).homeAdress;
//     final addressProvider = Provider.of<Email>(context).homeAdress;
//     final dollarProvider = Provider.of<Email>(context);
//
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: Text(
//           'Select location',
//           style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
//         ),
//         elevation: 0,
//         backgroundColor: kTextColor,
//         foregroundColor: Colors.white,
//       ),
//       body: ModalProgressHUD(
//         inAsyncCall: _isInAsyncCall,
//         opacity: 0.5,
//         progressIndicator: CircularProgressIndicator(),
//         child: Container(
//           padding: EdgeInsets.only(top: kDefaultPadding),
//           margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
//           child: Form(
//             key: formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Pick your current location',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   children: [
//                     addressProvider.isNotEmpty
//                         ? SizedBox(
//                             width: size.width / 1.3,
//                             child: TextFormField(
//                               controller: addressController,
//                               style: TextStyle(
//                                   fontSize: 19, fontWeight: FontWeight.w600),
//                               enabled: false,
//                               validator: (String? value) {
//                                 if (value != null && value.isEmpty) {
//                                   return 'Enter your address';
//                                 }
//                                 // else if (value != null &&
//                                 //     RegExp(r'^[#.0-9a-zA-Z\s,-]+$').hasMatch(value) ==
//                                 //         false) {
//                                 //   return 'Enter correct address';
//                                 // }
//                                 else {
//                                   return null;
//                                 }
//                               },
//                               decoration: InputDecoration(
//                                 border: InputBorder.none,
//                                 focusedBorder: InputBorder.none,
//                                 enabledBorder: InputBorder.none,
//                                 errorBorder: InputBorder.none,
//                                 disabledBorder: InputBorder.none,
//                                 hintText: 'Address',
//                               ),
//                             ),
//                           )
//                         : SizedBox(
//                             width: size.width / 1.3,
//                             child: Text('Please click location button'),
//                           ),
//                     Spacer(),
//                     IconButton(
//                       onPressed: () {
//                         setState(() {
//                           _isInAsyncCall = true;
//                         });
//                         print(_isInAsyncCall);
//                         getCurrentPosition();
//                         // setState(() {
//                         //   addressController.text =
//                         //       Provider.of<Email>(context, listen: false).homeAdress;
//                         // });
//                       },
//                       color: kPrimaryColor,
//                       icon: Icon(Icons.gps_fixed_outlined),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Text(
//                   'Enter your phone',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 SizedBox(
//                   child: TextFormField(
//                     controller: phoneController,
//                     keyboardType: TextInputType.phone,
//                     onChanged: (value) {
//                       Provider.of<Email>(context, listen: false)
//                           .setPhone(value);
//                     },
//                     validator: (String? value) {
//                       if (value != null && value.isEmpty) {
//                         return 'Enter something';
//                       } else if (value != null && value.length < 13) {
//                         return 'Enter valid phone number';
//                       } else if (value != null &&
//                           RegExp(r'^(?:[+]92)[0-9]{10}$').hasMatch(value) ==
//                               false) {
//                         return 'Enter your phone number';
//                       } else {
//                         return null;
//                       }
//                     },
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: '+923202345678',
//                       hintStyle: TextStyle(
//                         fontSize: 16,
//                         color: kTextColor.withOpacity(0.2),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.grey)),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.blue)),
//                       errorBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.red)),
//                       focusedErrorBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.red)),
//                     ),
//                   ),
//                 ),
//                 // Spacer(),
//
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pushNamed(
//                             context, AddressPageManual.routeName);
//                       },
//                       style: TextButton.styleFrom(
//                         minimumSize: Size.zero, // Set this
//                         padding: EdgeInsets.zero, // and this
//                       ),
//                       child: Text(
//                         'Give manual address',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(bottom: kDefaultPadding),
//                   child: ElevatedButton(
//                     onPressed: addressFill
//                         ? () async {
//                             if (formKey.currentState != null) {
//                               if (formKey.currentState?.validate() == true) {
//                                 print('validated');
//                                 setState(() {
//                                   _isInAsyncCall = true;
//                                 });
//                                 String money =
//                                     dollarProvider.dollarMoney.toString();
//                                 await makePayment(
//                                     money,
//                                     addressController.text,
//                                     dollarProvider.rupeeMoney,
//                                     phoneController.text);
//                               }
//                             }
//                           }
//                         : null,
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
//
//                 // SizedBox(
//                 //   width: size.width / 1.5,
//                 //   child: TextFormField(
//                 //     controller: addressController,
//                 //     enabled: false,
//                 //     validator: (String? value) {
//                 //       if (value != null && value.isEmpty) {
//                 //         return 'Enter your address';
//                 //       }
//                 //       // else if (value != null &&
//                 //       //     RegExp(r'^[#.0-9a-zA-Z\s,-]+$').hasMatch(value) ==
//                 //       //         false) {
//                 //       //   return 'Enter correct address';
//                 //       // }
//                 //       else {
//                 //         return null;
//                 //       }
//                 //     },
//                 //     decoration: InputDecoration(
//                 //       border: OutlineInputBorder(),
//                 //       suffixIcon: IconButton(
//                 //         onPressed: () {
//                 //           setState(() {
//                 //             _isInAsyncCall = true;
//                 //           });
//                 //           print(_isInAsyncCall);
//                 //           getCurrentPosition();
//                 //           // setState(() {
//                 //           //   addressController.text =
//                 //           //       Provider.of<Email>(context, listen: false).homeAdress;
//                 //           // });
//                 //         },
//                 //         color: kPrimaryColor,
//                 //         icon: Icon(Icons.gps_fixed_outlined),
//                 //       ),
//                 //       hintText: 'Address',
//                 //     ),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       // body: Column(
//       //   children: [
//       //     Container(
//       //         padding: EdgeInsets.only(
//       //           top: kDefaultPadding * 4,
//       //           left: kDefaultPadding,
//       //         ),
//       //         margin: EdgeInsets.only(bottom: kDefaultPadding),
//       //         width: size.width,
//       //         height: size.height * 0.2,
//       //         decoration: BoxDecoration(
//       //           color: kPrimaryColor,
//       //           borderRadius: BorderRadius.only(
//       //             bottomLeft: Radius.circular(36),
//       //             bottomRight: Radius.circular(36),
//       //           ),
//       //         ),
//       //         child: Column(
//       //           crossAxisAlignment: CrossAxisAlignment.start,
//       //           children: [
//       //             Text(
//       //               'Select location',
//       //               style: Theme.of(context).textTheme.headline5!.copyWith(
//       //                     fontWeight: FontWeight.bold,
//       //                   ),
//       //             ),
//       //           ],
//       //         )),
//       //   ],
//       // ),
//     );
//   }
// }
