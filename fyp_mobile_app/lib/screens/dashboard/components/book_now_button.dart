// import 'package:flutter/material.dart';
// import 'package:fyp_mobile_app/constants.dart';
// import 'package:fyp_mobile_app/models/service_provider_model.dart';
// import 'package:fyp_mobile_app/providers/service_provider.dart';
// import 'package:fyp_mobile_app/providers/swapCartButtonProvider.dart';
// import 'package:fyp_mobile_app/providers/user_provider.dart';
// import 'package:fyp_mobile_app/screens/dashboard/components/addressHandling.dart';
// import 'package:provider/provider.dart';
// import 'package:fyp_mobile_app/services/service_provider_service.dart';
//
// class BookNowButton extends StatefulWidget {
//   const BookNowButton({
//     Key? key,
//     required this.price,
//     required this.id,
//   }) : super(key: key);
//
//   final int price;
//   // final ServiceProvider provider;
//   // final dynamic provider;
//   final String id;
//
//   @override
//   State<BookNowButton> createState() => _BookNowButtonState();
// }
//
// class _BookNowButtonState extends State<BookNowButton> {
//   void navigateToAddressPage(BuildContext context, int price, String id) {
//     Navigator.pushNamed(context, AddressPage.routeName,
//         arguments: AddressPage(
//           price: price,
//           id: id,
//         ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // print(widget.isSelected);
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         ElevatedButton(
//           onPressed: () {
//             navigateToAddressPage(context, widget.price, widget.id);
//           },
//           style: ElevatedButton.styleFrom(
//             primary: Theme.of(context).primaryColor,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(15),
//                 topLeft: Radius.circular(15),
//                 bottomRight: Radius.circular(15),
//                 bottomLeft: Radius.circular(15),
//               ),
//             ),
//             elevation: 4.5,
//           ),
//           child: Row(
//             children: [
//               Icon(
//                 Icons.shopping_cart,
//                 size: 30,
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Text(
//                 "Book now",
//                 style: TextStyle(
//                   fontSize: 18,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
