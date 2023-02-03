// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fyp_mobile_app/constants.dart';
// import 'package:fyp_mobile_app/models/rating_model.dart';
// import 'package:fyp_mobile_app/models/service_provider_model.dart';
// import 'package:fyp_mobile_app/providers/swapCartButtonProvider.dart';
// import 'package:fyp_mobile_app/providers/user_provider.dart';
// import 'package:fyp_mobile_app/screens/dashboard/components/book_now_button.dart';
// import 'package:fyp_mobile_app/screens/dashboard/components/cart_button.dart';
// import 'package:fyp_mobile_app/screens/dashboard/components/detail_screen.dart';
// import 'package:fyp_mobile_app/screens/dashboard/components/ratingScreen.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
//
// class CategoryPopulate extends StatefulWidget {
//   CategoryPopulate({
//     Key? key,
//     required this.size,
//     required this.name,
//     required this.address,
//     required this.category,
//     required this.brand,
//     required this.price,
//     required this.image,
//     required this.id,
//     required this.isSelected,
//     required this.i,
//     required this.provider,
//     required this.average,
//     // required this.rating,
//   }) : super(key: key);
//
//   final Size size;
//   final String name;
//   final String address;
//   final String category;
//   final String brand;
//   final int price;
//   final List<int> image;
//   final ServiceProvider provider;
//   // final dynamic provider;
//   final double average;
//   final String id;
//   bool isSelected;
//   // List<Rating>? rating;
//   final int i;
//
//   @override
//   State<CategoryPopulate> createState() => _CategoryPopulateState();
// }
//
// class _CategoryPopulateState extends State<CategoryPopulate>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   bool get wantKeepAlive => true;
//   void navigateToRatingPage(
//       BuildContext context,
//       String category,
//       List<int> image,
//       String brand,
//       String name,
//       String id,
//       ServiceProvider provider) {
//     Navigator.pushNamed(context, RatingScreen.routeName,
//         arguments: RatingScreen(
//           category: category,
//           image: image,
//           brand: brand,
//           name: name,
//           id: id,
//           provider: provider,
//         ));
//   }
//
// //   bool? isSelected;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //     WidgetsBinding.instance.addPostFrameCallback((_) async {
// // // your code goes here
// //       final userProvider = Provider.of<UserProvider>(context, listen: false);
// //       try {
// //         for (int i = 0; i < userProvider.user.cart.length; i++) {
// //           if (widget.id == userProvider.user.cart[i]['product']['_id']) {
// //             isSelected = userProvider.user.cart[i]['addToCart'];
// //             // print(isSelected);
// //           }
// //         }
// //       } catch (e) {
// //         // TODO
// //       }
// //     });
// //   }
//
//   // bool isSelected = true;
//   // late bool isSelected;
//
//   // @override
//   // void didChangeDependencies() {
//   //   isSelected = Provider.of<SwapCartButtonProvider>(context).cartButton;
//   //   print(isSelected);
//   //   super.didChangeDependencies();
//   // }
//
//   // void postFrame(void Function() callback) =>
//   //     WidgetsBinding.instance.addPostFrameCallback(
//   //       (_) {
//   //         // Execute callback if page is mounted
//   //         if (mounted) callback();
//   //       },
//   //     );
//   //
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   postFrame(getState);
//   // }
//   //
//   // void getState() {
//   //   isSelected =
//   //       Provider.of<SwapCartButtonProvider>(context, listen: false).cartButton;
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     // bool isSelected =
//     //     Provider.of<SwapCartButtonProvider>(context, listen: false).cartButton;
//     // print(widget.isSelected);
//     // print(widget.average);
//     return Container(
//       margin: EdgeInsets.only(bottom: kDefaultPadding),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ImageWidget(
//             image: widget.image,
//             size: widget.size,
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Row(
//             children: [
//               Text(
//                 widget.name,
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               Spacer(),
//               Image.asset(
//                 'assets/images/yellowStar.png',
//                 height: 18,
//                 width: 18,
//               ),
//               SizedBox(
//                 width: 2,
//               ),
//               Text(
//                 widget.average.toString(),
//                 style: TextStyle(
//                   fontSize: 18,
//                 ),
//               ),
//               SizedBox(
//                 width: 5,
//               ),
//               Text(
//                 '(${widget.provider.rating!.length.toString()})',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: kTextColor.withOpacity(0.4),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   widget.address,
//                   style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400,
//                       overflow: TextOverflow.ellipsis),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               RichText(
//                 text: TextSpan(
//                   children: [
//                     TextSpan(
//                       text: "Service: ",
//                       style: Theme.of(context).textTheme.headline3!.copyWith(
//                             color: kTextColor,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 18,
//                           ),
//                     ),
//                     TextSpan(
//                       text: widget.category,
//                       style: Theme.of(context).textTheme.caption!.copyWith(
//                             color: kTextColor,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w400,
//                           ),
//                     ),
//                   ],
//                 ),
//               ),
//               RichText(
//                 text: TextSpan(
//                   children: [
//                     TextSpan(
//                       text: "Brand: ",
//                       style: Theme.of(context).textTheme.headline3!.copyWith(
//                             color: kTextColor,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                           ),
//                     ),
//                     TextSpan(
//                       text: widget.brand,
//                       style: Theme.of(context).textTheme.caption!.copyWith(
//                             color: kTextColor,
//                             fontWeight: FontWeight.w400,
//                             fontSize: 16,
//                           ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               TextButton(
//                 onPressed: () {
//                   navigateToRatingPage(
//                     context,
//                     widget.category,
//                     widget.image,
//                     widget.brand,
//                     widget.name,
//                     widget.id,
//                     widget.provider,
//                   );
//                 },
//                 style: TextButton.styleFrom(
//                     minimumSize: Size.zero, // Set this
//                     padding: EdgeInsets.zero,
//                     tapTargetSize: MaterialTapTargetSize.shrinkWrap // and this
//                     ),
//                 child: Text(
//                   'Review the provider',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//               Text(
//                 'PKR ${widget.price}',
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 5,
//           ),
//
//           // Consumer<SwapCartButtonProvider>(builder: (context, cart, child) {
//           //   return CartButton(
//           //     id: widget.id,
//           //     isSelected: cart.cartButton,
//           //   );
//           // }),
//           BookNowButton(
//             price: widget.price,
//             id: widget.id,
//           ),
//           // CartButton(
//           //   id: widget.id,
//           //   isSelected: widget.isSelected,
//           //   index: widget.i,
//           // ),
//           // Consumer<SwapCartButtonProvider>(builder: (context, cart, child) {
//           //   return Row(
//           //     mainAxisAlignment: MainAxisAlignment.end,
//           //     children: [
//           //       Visibility(
//           //         visible: cart.cartButton,
//           //         child: ElevatedButton(
//           //           onPressed: cart.toggleCartButton,
//           //           style: ElevatedButton.styleFrom(
//           //             primary: Theme.of(context).primaryColor,
//           //             shape: RoundedRectangleBorder(
//           //               borderRadius: BorderRadius.only(
//           //                 topRight: Radius.circular(15),
//           //                 topLeft: Radius.circular(15),
//           //                 bottomRight: Radius.circular(15),
//           //                 bottomLeft: Radius.circular(15),
//           //               ),
//           //             ),
//           //             elevation: 4.5,
//           //           ),
//           //           child: Row(
//           //             children: [
//           //               Icon(
//           //                 Icons.add_shopping_cart,
//           //                 size: 30,
//           //               ),
//           //               SizedBox(
//           //                 width: 10,
//           //               ),
//           //               Text(
//           //                 "Add to cart",
//           //                 style: TextStyle(
//           //                   fontSize: 18,
//           //                 ),
//           //               ),
//           //             ],
//           //           ),
//           //         ),
//           //       ),
//           //       Visibility(
//           //         visible: cart.addedButton,
//           //         child: Row(
//           //           children: [
//           //             IconButton(
//           //                 onPressed: cart.toggleCartButton,
//           //                 icon: Icon(Icons.delete)),
//           //             ElevatedButton(
//           //               onPressed: null,
//           //               style: ElevatedButton.styleFrom(
//           //                 primary: Theme.of(context).primaryColor,
//           //                 shape: RoundedRectangleBorder(
//           //                   borderRadius: BorderRadius.only(
//           //                     topRight: Radius.circular(15),
//           //                     topLeft: Radius.circular(15),
//           //                     bottomRight: Radius.circular(15),
//           //                     bottomLeft: Radius.circular(15),
//           //                   ),
//           //                 ),
//           //                 elevation: 4.5,
//           //               ),
//           //               child: Row(
//           //                 children: [
//           //                   Icon(
//           //                     Icons.check,
//           //                     size: 30,
//           //                   ),
//           //                   SizedBox(
//           //                     width: 10,
//           //                   ),
//           //                   Text(
//           //                     "Added to cart",
//           //                     style: TextStyle(
//           //                       fontSize: 18,
//           //                     ),
//           //                   ),
//           //                 ],
//           //               ),
//           //             )
//           //           ],
//           //         ),
//           //       ),
//           //     ],
//           //   );
//           // }),
//           Divider(
//             thickness: 1,
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ImageWidget extends StatefulWidget {
//   const ImageWidget({
//     Key? key,
//     required this.image,
//     required this.size,
//   }) : super(key: key);
//
//   final List<int> image;
//   final Size size;
//
//   @override
//   State<ImageWidget> createState() => _ImageWidgetState();
// }
//
// class _ImageWidgetState extends State<ImageWidget> {
//   Future<Uint8List> testComporessList(Uint8List list) async {
//     var result = await FlutterImageCompress.compressWithList(
//       list,
//       minHeight: 1920,
//       minWidth: 1080,
//       quality: 96,
//       rotate: 135,
//     );
//     print(list.length);
//     print(result.length);
//     return result;
//   }
//
//   Uint8List listToUint8() {
//     Uint8List image = Uint8List.fromList(widget.image);
//     return image;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: Image.memory(
//           Uint8List.fromList(widget.image),
//           fit: BoxFit.cover,
//           width: widget.size.width,
//           height: 150,
//         ),
//       ),
//       // child: FutureBuilder<Uint8List>(
//       //     future: testComporessList(listToUint8()),
//       //     builder: (context, AsyncSnapshot snapshot) {
//       //       if (snapshot.hasData == false) {
//       //         return const Scaffold(
//       //           body: Center(
//       //             child: SpinKitRotatingCircle(
//       //               color: kPrimaryColor,
//       //               size: 10,
//       //             ),
//       //           ),
//       //         );
//       //       } else {
//       //         return ClipRRect(
//       //           borderRadius: BorderRadius.circular(10),
//       //           child: Image.memory(
//       //             Uint8List(snapshot.data),
//       //             fit: BoxFit.cover,
//       //             width: widget.size.width,
//       //             height: 150,
//       //           ),
//       //         );
//       //       }
//       //     }),
//     );
//   }
// }

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/models/rating_model.dart';
import 'package:fyp_mobile_app/models/service_provider_model.dart';
import 'package:fyp_mobile_app/providers/swapCartButtonProvider.dart';
import 'package:fyp_mobile_app/providers/user_provider.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/book_now_button.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/cart_button.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/detail_screen.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/ratingScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class CategoryPopulate extends StatefulWidget {
  CategoryPopulate({
    Key? key,
    required this.size,
    required this.name,
    required this.address,
    // required this.category,
    // required this.brand,
    required this.price,
    // required this.image,
    required this.id,
    required this.isSelected,
    required this.i,
    required this.provider,
    required this.serviceType,
    required this.description,
    required this.timeRequired,
    required this.categoryName,
    required this.providerName,
    required this.where,
    required this.number,
    required this.email,
    required this.average,
    required this.rating,
    required this.image,
  }) : super(key: key);

  final Size size;
  final String name;
  final String address;
  final String serviceType;
  final String description;
  final String timeRequired;
  final String providerName;
  // final String category;
  // final String brand;
  final int price;
  final String categoryName;
  final String where;
  final String number;
  final String email;
  final String image;
  final ServiceProvider provider;
  // final dynamic provider;
  final double average;
  final String id;
  bool isSelected;
  List<Rating>? rating;
  final int i;

  @override
  State<CategoryPopulate> createState() => _CategoryPopulateState();
}

class _CategoryPopulateState extends State<CategoryPopulate>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late TextEditingController descriptionController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    descriptionController = TextEditingController();
    descriptionController.text = widget.description;
  }

  void navigateToDetailPage(
    BuildContext context,
    String name,
    String serviceType,
    String timeRequired,
    String description,
    String providerName,
    int price,
    String where,
    String categoryName,
    String email,
    String number,
    String id,
    String image,
    String address,
  ) {
    Navigator.pushNamed(
      context,
      ServiceProviderDetailScreen.routeName,
      arguments: ServiceProviderDetailScreen(
        name: name,
        serviceType: serviceType,
        description: description,
        timeRequired: timeRequired,
        providerName: providerName,
        image: image,
        price: price,
        categoryName: categoryName,
        where: where,
        email: email,
        number: number,
        id: id,
        address: address,
      ),
    );
  }

  // void navigateToRatingPage(
  //     BuildContext context,
  //     String category,
  //     List<int> image,
  //     String brand,
  //     String name,
  //     String id,
  //     ServiceProvider provider) {
  //   Navigator.pushNamed(context, RatingScreen.routeName,
  //       arguments: RatingScreen(
  //         category: category,
  //         image: image,
  //         brand: brand,
  //         name: name,
  //         id: id,
  //         provider: provider,
  //       ));
  // }

  void navigateToRatingPage(
      {required BuildContext context,
      required String name,
      // List<int> image,
      required String categoryName,
      required String providerName,
      required String id,
      required ServiceProvider provider,
      required String image}) {
    Navigator.pushNamed(context, RatingScreen.routeName,
        arguments: RatingScreen(
          categoryName: categoryName,
          // image: image,
          providerName: providerName,
          name: name,
          id: id,

          provider: provider,
          image: image,
        ));
  }

  @override
  Widget build(BuildContext context) {
    // bool isSelected =
    //     Provider.of<SwapCartButtonProvider>(context, listen: false).cartButton;
    // print(widget.isSelected);
    // print(widget.average);

    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageWidget(
            image: widget.image,
            size: widget.size,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                widget.providerName,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Spacer(),
              Image.asset(
                'assets/images/yellowStar.png',
                height: 18,
                width: 18,
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                widget.average.toString(),
                // '4.2',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                // '(2)',
                '(${widget.provider.rating!.length.toString()})',
                style: TextStyle(
                  fontSize: 18,
                  color: kTextColor.withOpacity(0.4),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                'Address: ',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
              ),
              Expanded(
                child: Text(
                  // '1-C R-1, Block R Phase 2 Johar Town, Lahore',
                  widget.address,
                  // widget.address,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),

          // Row(
          //   children: [
          //     Text(
          //       'Description: \n',
          //       style: Theme.of(context).textTheme.headline3!.copyWith(
          //             color: kTextColor,
          //             fontWeight: FontWeight.bold,
          //             fontSize: 18,
          //           ),
          //     ),
          //     Expanded(
          //       child: Text(
          //         widget.description,
          //         // widget.address,
          //         style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.w400,
          //           overflow: TextOverflow.clip,
          //         ),
          //       ),
          //     ),
          //
          //   ],
          // ),
          // TextField(
          //   controller: descriptionController,
          //   enabled: false,
          //   minLines: 1,
          //   // textAlign: controllers[index].text.isEmpty
          //   //     ? TextAlign.center
          //   //     : TextAlign.start,
          //   // maxLines: 4,
          //   keyboardType: TextInputType.multiline,
          //   decoration: InputDecoration(
          //     border: InputBorder.none,
          //   ),
          // ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Category: ",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: kTextColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                      ),
                      TextSpan(
                        // text: widget.category,
                        text: widget.categoryName,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: kTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Name: ",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: kTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                      ),
                      TextSpan(
                        text: widget.name,
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: kTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  navigateToRatingPage(
                    context: context,
                    categoryName: widget.categoryName,
                    name: widget.name,
                    providerName: widget.providerName,
                    id: widget.id,
                    image: widget.image,
                    provider: widget.provider,
                  );
                },
                style: TextButton.styleFrom(
                    minimumSize: Size.zero, // Set this
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap // and this
                    ),
                child: Text(
                  'Review the provider',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Text(
                'PKR ${widget.price}',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),

          // Consumer<SwapCartButtonProvider>(builder: (context, cart, child) {
          //   return CartButton(
          //     id: widget.id,
          //     isSelected: cart.cartButton,
          //   );
          // }),

          // BookNowButton(
          //   price: widget.price,
          //   id: widget.id,
          // ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, OrderDetails.routeName,
                  //     arguments: OrderDetails(
                  //       provider: widget.provider,
                  //       orderNo: widget.orderNo,
                  //       price: widget.price,
                  //       date: widget.date,
                  //       status: widget.status,
                  //       address: widget.address,
                  //     ));

                  navigateToDetailPage(
                    context,
                    widget.name,
                    widget.serviceType,
                    widget.timeRequired,
                    widget.description,
                    widget.providerName,
                    widget.price,
                    widget.where,
                    widget.categoryName,
                    widget.email,
                    widget.number,
                    widget.id,
                    widget.image,
                    widget.address,
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  elevation: 4.5,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.list,
                      size: 30,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "View details",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // CartButton(
          //   id: widget.id,
          //   isSelected: widget.isSelected,
          //   index: widget.i,
          // ),
          // Consumer<SwapCartButtonProvider>(builder: (context, cart, child) {
          //   return Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Visibility(
          //         visible: cart.cartButton,
          //         child: ElevatedButton(
          //           onPressed: cart.toggleCartButton,
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
          //                 Icons.add_shopping_cart,
          //                 size: 30,
          //               ),
          //               SizedBox(
          //                 width: 10,
          //               ),
          //               Text(
          //                 "Add to cart",
          //                 style: TextStyle(
          //                   fontSize: 18,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //       Visibility(
          //         visible: cart.addedButton,
          //         child: Row(
          //           children: [
          //             IconButton(
          //                 onPressed: cart.toggleCartButton,
          //                 icon: Icon(Icons.delete)),
          //             ElevatedButton(
          //               onPressed: null,
          //               style: ElevatedButton.styleFrom(
          //                 primary: Theme.of(context).primaryColor,
          //                 shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.only(
          //                     topRight: Radius.circular(15),
          //                     topLeft: Radius.circular(15),
          //                     bottomRight: Radius.circular(15),
          //                     bottomLeft: Radius.circular(15),
          //                   ),
          //                 ),
          //                 elevation: 4.5,
          //               ),
          //               child: Row(
          //                 children: [
          //                   Icon(
          //                     Icons.check,
          //                     size: 30,
          //                   ),
          //                   SizedBox(
          //                     width: 10,
          //                   ),
          //                   Text(
          //                     "Added to cart",
          //                     style: TextStyle(
          //                       fontSize: 18,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //     ],
          //   );
          // }),
          Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

class ImageWidget extends StatefulWidget {
  const ImageWidget({
    Key? key,
    // required this.image,
    required this.size,
    required this.image,
  }) : super(key: key);

  // final List<int> image;
  final Size size;
  final String image;

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  // Future<Uint8List> testComporessList(Uint8List list) async {
  //   var result = await FlutterImageCompress.compressWithList(
  //     list,
  //     minHeight: 1920,
  //     minWidth: 1080,
  //     quality: 96,
  //     rotate: 135,
  //   );
  //   print(list.length);
  //   print(result.length);
  //   return result;
  // }
  //
  // Uint8List listToUint8() {
  //   Uint8List image = Uint8List.fromList(widget.image);
  //   return image;
  // }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        // child: Image.memory(
        //   Uint8List.fromList(widget.image),
        //   fit: BoxFit.cover,
        //   width: widget.size.width,
        //   height: 150,
        // ),
        child: Image.network(
          // widget.image,
          'https://media.istockphoto.com/id/1315800156/photo/automobile-mechanic-repairman-hands-repairing-a-car-engine-automotive-workshop-with-a-wrench.jpg?b=1&s=170667a&w=0&k=20&c=1mTACjOQsCywELazdevG3b9137Lfzh4ejXMFGMBBUi0=',
          // 'https://images.unsplash.com/photo-1570071677470-c04398af73ca?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1010&q=80',
          fit: BoxFit.cover,
          width: widget.size.width,
          height: 150,
        ),
      ),
      // child: FutureBuilder<Uint8List>(
      //     future: testComporessList(listToUint8()),
      //     builder: (context, AsyncSnapshot snapshot) {
      //       if (snapshot.hasData == false) {
      //         return const Scaffold(
      //           body: Center(
      //             child: SpinKitRotatingCircle(
      //               color: kPrimaryColor,
      //               size: 10,
      //             ),
      //           ),
      //         );
      //       } else {
      //         return ClipRRect(
      //           borderRadius: BorderRadius.circular(10),
      //           child: Image.memory(
      //             Uint8List(snapshot.data),
      //             fit: BoxFit.cover,
      //             width: widget.size.width,
      //             height: 150,
      //           ),
      //         );
      //       }
      //     }),
    );
  }
}
