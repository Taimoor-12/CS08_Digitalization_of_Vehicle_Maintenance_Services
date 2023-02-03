// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:fyp_mobile_app/providers/emailPasswordProvider.dart';
// import 'package:fyp_mobile_app/providers/user_provider.dart';
// import 'package:fyp_mobile_app/screens/cart/components/addressHandling.dart';
// import 'package:fyp_mobile_app/services/service_provider_service.dart';
// import 'package:provider/provider.dart';
//
// import '../../../constants.dart';
//
// class Body extends StatefulWidget {
//   const Body({Key? key}) : super(key: key);
//
//   @override
//   State<Body> createState() => _BodyState();
// }
//
// class _BodyState extends State<Body> {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final userCart = Provider.of<UserProvider>(context);
//     final dollarProvider = Provider.of<Email>(context, listen: false);
//     int sum = 0;
//     double dollar = 0.0;
//     int dollarRound = 0;
//     userCart.user.cart.map((e) => sum += e['product']['price'] as int).toList();
//     dollar = sum / 222.45;
//     dollarRound = dollar.round();
//     ServiceProviderService service = ServiceProviderService();
//     return Column(
//       children: [
//         Container(
//             padding: EdgeInsets.only(
//               top: kDefaultPadding * 4,
//               left: kDefaultPadding,
//             ),
//             margin: EdgeInsets.only(bottom: kDefaultPadding),
//             width: size.width,
//             height: size.height * 0.2,
//             decoration: BoxDecoration(
//               color: kPrimaryColor,
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(36),
//                 bottomRight: Radius.circular(36),
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Your Cart',
//                   style: Theme.of(context).textTheme.headline5!.copyWith(
//                         fontWeight: FontWeight.bold,
//                       ),
//                 ),
//               ],
//             )),
//         userCart.user.cart.isNotEmpty
//             ? Column(
//                 children: [
//                   Container(
//                       padding: EdgeInsets.only(
//                         right: kDefaultPadding,
//                         left: kDefaultPadding,
//                       ),
//                       height: size.height * 0.5,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           // color: Colors.grey.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: ListView.builder(
//                             itemCount: userCart.user.cart.length,
//                             itemBuilder: (context, index) {
//                               List<dynamic> bufferDynamic =
//                                   userCart.user.cart[index]['product']['image']
//                                       ['data']['data'];
//                               List<int> bufferInt =
//                                   bufferDynamic.map((e) => e as int).toList();
//                               return Container(
//                                 padding:
//                                     EdgeInsets.only(bottom: kDefaultPadding),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Container(
//                                           child: ClipRRect(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             child: Image.memory(
//                                               Uint8List.fromList(bufferInt),
//                                               fit: BoxFit.cover,
//                                               width: 120,
//                                               height: 120,
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 15,
//                                         ),
//                                         Expanded(
//                                           child: Column(
//                                             children: [
//                                               Text(
//                                                 ' ${userCart.user.cart[index]['product']['category']} - ${userCart.user.cart[index]['product']['name']}',
//                                                 style: TextStyle(
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.w600,
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 height: 10,
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Text(
//                                                     'Brand: ',
//                                                     style: TextStyle(
//                                                       color: kTextColor
//                                                           .withOpacity(0.5),
//                                                       fontSize: 12,
//                                                     ),
//                                                   ),
//                                                   Text(
//                                                     userCart.user.cart[index]
//                                                             ['product']
//                                                         ['brandName'],
//                                                     style: TextStyle(
//                                                       color: kTextColor
//                                                           .withOpacity(0.5),
//                                                       fontSize: 16,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 height: 10,
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   IconButton(
//                                                       padding: EdgeInsets.zero,
//                                                       constraints:
//                                                           BoxConstraints(),
//                                                       onPressed: () {
//                                                         // service.clickDeleteCart(id: widget.id);
//                                                         service.deleteFromCart(
//                                                           context: context,
//                                                           serviceID: userCart
//                                                                   .user
//                                                                   .cart[index][
//                                                               'product']['_id'],
//                                                         );
//                                                         // userCart.user.cart
//                                                         //     .clear();
//                                                         // Provider.of<SwapCartButtonProvider>(context,
//                                                         //         listen: false)
//                                                         //     .setCartButton(true);
//                                                       },
//                                                       icon: Icon(Icons.delete)),
//                                                   Spacer(),
//                                                   Text(
//                                                     'PKR ',
//                                                     style:
//                                                         TextStyle(fontSize: 16),
//                                                   ),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             right: 8.0),
//                                                     child: Text(
//                                                       userCart
//                                                           .user
//                                                           .cart[index]
//                                                               ['product']
//                                                               ['price']
//                                                           .toString(),
//                                                       style: TextStyle(
//                                                           fontSize: 18,
//                                                           fontWeight:
//                                                               FontWeight.w700),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               );
//                             }),
//                       )),
//                   Padding(
//                     padding: EdgeInsets.only(
//                         right: kDefaultPadding,
//                         left: kDefaultPadding,
//                         top: kDefaultPadding / 2),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Text(
//                           'Total: ',
//                           style: TextStyle(
//                             fontSize: 18,
//                             color: kTextColor.withOpacity(0.4),
//                           ),
//                         ),
//                         Text(
//                           '${sum}',
//                           style: TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 2,
//                         ),
//                         Text(
//                           'Rs',
//                           style: TextStyle(
//                             fontSize: 18,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(
//                       right: kDefaultPadding,
//                       left: kDefaultPadding,
//                     ),
//                     margin: EdgeInsets.only(top: kDefaultPadding / 2),
//                     width: size.width,
//                     height: 45,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         dollarProvider.setDollar(dollarRound);
//                         dollarProvider.setRupee(sum);
//                         Navigator.pushNamed(context, AddressPage.routeName);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         primary: kTextColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                             topRight: Radius.circular(15),
//                             topLeft: Radius.circular(15),
//                             bottomRight: Radius.circular(15),
//                             bottomLeft: Radius.circular(15),
//                           ),
//                         ),
//                         elevation: 4.5,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.shopping_cart,
//                             size: 30,
//                           ),
//                           SizedBox(
//                             width: 15,
//                           ),
//                           Text(
//                             "Proceed to buy",
//                             style: TextStyle(
//                               fontSize: 18,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//             : Center(
//                 child: Text(
//                   'Cart is empty',
//                   style: TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 22,
//                       color: kTextColor.withOpacity(0.4)),
//                 ),
//               ),
//       ],
//     );
//   }
// }
