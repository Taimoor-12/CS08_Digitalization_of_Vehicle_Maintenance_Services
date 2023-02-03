// import 'dart:convert';
// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fyp_mobile_app/constants.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:fyp_mobile_app/models/service_provider_model.dart';
// import 'package:fyp_mobile_app/models/user_model.dart';
// import 'package:fyp_mobile_app/providers/user_provider.dart';
// import 'package:fyp_mobile_app/services/rating_service.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:flutter_profile_picture/flutter_profile_picture.dart';
//
// class RatingScreen extends StatefulWidget {
//   static const String routeName = "/rating";
//   const RatingScreen(
//       {Key? key,
//       required this.image,
//       required this.name,
//       required this.category,
//       required this.brand,
//       required this.provider,
//       required this.id})
//       : super(key: key);
//
//   final List<int> image;
//   final String name;
//   final String category;
//   final String brand;
//   final String id;
//   final ServiceProvider provider;
//
//   @override
//   State<RatingScreen> createState() => _RatingScreenState();
// }
//
// class _RatingScreenState extends State<RatingScreen> {
//   double avgRating = 0;
//   double myRating = 0;
//   RatingService ratingService = RatingService();
//   late TextEditingController reviewController;
//
//   Future getReviewedUsers() async {
//     try {
//       final user = Provider.of<UserProvider>(context, listen: false).user;
//       if (widget.provider.rating != null) {
//         // print('Length');
//         // print(widget.provider.rating![1].userId);
//         List<ReviewedUser> users = [];
//         for (int i = 0; i < widget.provider.rating!.length; i++) {
//           var response = await http.put(
//             Uri.parse('$uri/api/users/find-rated-user'),
//             headers: <String, String>{
//               'Content-Type': 'application/json; charset=UTF-8',
//             },
//             body: jsonEncode({
//               'id': widget.provider.rating![i].userId,
//               'role': widget.provider.rating![i].role
//             }),
//           );
//
//           var jsonData = jsonDecode(response.body);
//           print(jsonData['name']);
//           // List<ReviewedUser> users = [];
//           // List<String> imageString = [];
//           // String image = "";
//
//           // for (var u in jsonData) {
//
//           if (jsonData['image'] != null) {
//             List<dynamic> bufferDynamic = jsonData['image']['data']['data'];
//             List<int> bufferInt = bufferDynamic.map((e) => e as int).toList();
//
//             dynamic userName = jsonData['name'];
//             String name = userName ?? '';
//
//             ReviewedUser user = ReviewedUser(name, bufferInt);
//             users.add(user);
//           } else {
//             dynamic userName = jsonData['name'];
//             String name = userName ?? '';
//
//             ReviewedUser user = ReviewedUser(name, []);
//             users.add(user);
//           }
//
//           // }
//           // return users;
//         }
//         return users;
//       }
//     } catch (e) {
//       print('Problem');
//       // TODO
//     }
//
//     // var response =
//     // await http.put(Uri.parse('http://192.168.100.9:4000/api/users/find-rated-user'),
//     //     headers: <String, String>{
//     //       'Content-Type': 'application/json; charset=UTF-8',
//     //     },
//     //     body: jsonEncode({'id': id}),);
//     //
//     // var jsonData = jsonDecode(response.body);
//     // List<ReviewedUser> users = [];
//     // // List<String> imageString = [];
//     // // String image = "";
//     //
//     //
//     //
//     // for (var u in jsonData) {
//     //   List<dynamic> bufferDynamic = u['image']['data']['data'];
//     //   List<int> bufferInt = bufferDynamic.map((e) => e as int).toList();
//     //   // String image = base64Encode(bufferInt);
//     //   // Uint8List imageInt = base64.decode(image.split('\n').join().toString());
//     //   // for (var i in bufferInt) {
//     //   //   String temp = i.toRadixString(2) + image;
//     //   //   image = temp;
//     //   // }
//     //   // print(image);
//     //   // imageString.add(image);
//     //   // base64.normalize(image);
//     //   ReviewedUser user = ReviewedUser(u["name"], bufferInt);
//     //   users.add(user);
//     // }
//     // return users;
//   }
//
//   // void retrieveUsers() {
//   //
//   //   List<ReviewedUser> users = [];
//   //
//   //   if(widget.provider.rating != null) {
//   //     for(int i = 0; i<widget.provider.rating!.length; i++){
//   //       users = getReviewedUsers(id: widget.provider.rating![i].userId);
//   //     }
//   //   }
//   //
//   //
//   // }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     reviewController = TextEditingController();
//     if (widget.provider.rating != null) {
//       double totalRating = 0;
//       for (int i = 0; i < widget.provider.rating!.length; i++) {
//         totalRating += widget.provider.rating![i].rating;
//         if (widget.provider.rating![i].userId ==
//             Provider.of<UserProvider>(context, listen: false).user.id) {
//           myRating = widget.provider.rating![i].rating;
//         }
//       }
//
//       if (totalRating != 0) {
//         avgRating = totalRating / widget.provider.rating!.length;
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final user = Provider.of<UserProvider>(context, listen: false).user;
//     print(user.role);
//     // if (widget.provider.rating != null) {
//     //   double totalRating = 0;
//     //   for (int i = 0; i < widget.provider.rating!.length; i++) {
//     //     totalRating += widget.provider.rating![i].rating;
//     //     if (widget.provider.rating![i].userId ==
//     //         Provider.of<UserProvider>(context, listen: false).user.id) {
//     //       myRating = widget.provider.rating![i].rating;
//     //     }
//     //   }
//     //
//     //   if (totalRating != 0) {
//     //     avgRating = totalRating / widget.provider.rating!.length;
//     //   }
//     // }
//     return DefaultTabController(
//       initialIndex: 0,
//       length: 2,
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Stack(
//           children: [
//             Container(
//               child: TabBarView(
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(
//                       left: kDefaultPadding,
//                       right: kDefaultPadding,
//                       top: size.height * 0.37,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               widget.name,
//                               style: TextStyle(
//                                 fontSize: 26,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Row(
//                           children: [
//                             Text(
//                               '${widget.category} - ${widget.brand}',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 color: kTextColor.withOpacity(0.4),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: size.height * 0.02,
//                         ),
//                         Row(
//                           children: [
//                             Text(
//                               'Review',
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           ],
//                         ),
//                         TextField(
//                           controller: reviewController,
//                           minLines: 1,
//                           maxLines: 4,
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(200),
//                           ],
//                           keyboardType: TextInputType.multiline,
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Row(
//                           children: [
//                             Text(
//                               'Rating',
//                               style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         RatingBar.builder(
//                           initialRating: myRating,
//                           minRating: 1,
//                           direction: Axis.horizontal,
//                           allowHalfRating: true,
//                           itemCount: 5,
//                           itemBuilder: (context, _) => const Icon(
//                             Icons.star,
//                             color: Colors.amber,
//                           ),
//                           onRatingUpdate: (rating) {
//                             setState(() {
//                               myRating = rating;
//                             });
//                             // ratingService.rateProduct(
//                             //     context: context,
//                             //     productID: widget.id,
//                             //     rating: rating);
//                           },
//                         ),
//                         SizedBox(
//                           height: 30,
//                         ),
//                         SingleChildScrollView(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               ElevatedButton(
//                                 onPressed: myRating == 0
//                                     ? null
//                                     : () {
//                                         if (user.role == 'email') {
//                                           ratingService.rateProduct(
//                                               context: context,
//                                               productID: widget.id,
//                                               review: reviewController.text,
//                                               role: user.role,
//                                               rating: myRating);
//                                         } else {
//                                           ratingService.rateProductPhone(
//                                               context: context,
//                                               productID: widget.id,
//                                               review: reviewController.text,
//                                               role: user.role,
//                                               rating: myRating);
//                                         }
//                                       },
//                                 style: ElevatedButton.styleFrom(
//                                   primary: Theme.of(context).primaryColor,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.only(
//                                       topRight: Radius.circular(15),
//                                       topLeft: Radius.circular(15),
//                                       bottomRight: Radius.circular(15),
//                                       bottomLeft: Radius.circular(15),
//                                     ),
//                                   ),
//                                   elevation: 4.5,
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Icon(
//                                       Icons.rate_review_rounded,
//                                       size: 30,
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text(
//                                       "Give rating",
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(
//                       left: kDefaultPadding,
//                       right: kDefaultPadding,
//                       top: size.height * 0.37,
//                     ),
//                     child: FutureBuilder(
//                       future: getReviewedUsers(),
//                       builder: (context, AsyncSnapshot snapshot) {
//                         if (snapshot.hasData == false) {
//                           return const Scaffold(
//                             body: Center(
//                               child: SpinKitRotatingCircle(
//                                 color: kPrimaryColor,
//                                 size: 50,
//                               ),
//                             ),
//                           );
//                         } else {
//                           List<TextEditingController> controllers = [];
//                           TextEditingController emptyController =
//                               TextEditingController();
//                           emptyController.text = "*User did not review*";
//
//                           for (int i = 0;
//                               i < widget.provider.rating!.length;
//                               i++) {
//                             TextEditingController controller =
//                                 TextEditingController();
//                             controller.text =
//                                 widget.provider.rating![i].review!;
//                             controllers.add(controller);
//                           }
//
//                           if (snapshot.data.length == 0) {
//                             return Center(
//                               child: Text(
//                                 'No reviews',
//                                 style: TextStyle(
//                                     fontSize: 22,
//                                     color: kTextColor.withOpacity(0.4)),
//                               ),
//                             );
//                           }
//
//                           return ListView.builder(
//                               itemCount: snapshot.data.length,
//                               // itemExtent: 150,
//                               itemBuilder: (context, index) {
//                                 return Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         snapshot.data[index].bufferImage
//                                                 .isNotEmpty
//                                             ? CircleAvatar(
//                                                 radius: 15,
//                                                 backgroundImage: MemoryImage(
//                                                   Uint8List.fromList(snapshot
//                                                       .data[index].bufferImage),
//                                                 ),
//                                               )
//                                             : ProfilePicture(
//                                                 name: snapshot.data[index].name,
//                                                 radius: 15,
//                                                 fontsize: size.width / 30,
//                                               ),
//                                         SizedBox(
//                                           width: 10,
//                                         ),
//                                         Text(
//                                           snapshot.data[index].name,
//                                           style: TextStyle(
//                                               fontSize: size.width / 22,
//                                               fontWeight: FontWeight.w700),
//                                         ),
//                                         Spacer(),
//                                         Image.asset(
//                                           'assets/images/yellowStar.png',
//                                           height: 18,
//                                           width: 18,
//                                         ),
//                                         SizedBox(
//                                           width: 2,
//                                         ),
//                                         Text(
//                                           widget.provider.rating![index].rating
//                                               .toString(),
//                                           style: TextStyle(
//                                             fontSize: 18,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     TextField(
//                                       controller:
//                                           controllers[index].text.isEmpty
//                                               ? emptyController
//                                               : controllers[index],
//                                       enabled: false,
//                                       minLines: 1,
//                                       textAlign: controllers[index].text.isEmpty
//                                           ? TextAlign.center
//                                           : TextAlign.start,
//                                       style: controllers[index].text.isEmpty
//                                           ? TextStyle(
//                                               color:
//                                                   kTextColor.withOpacity(0.4))
//                                           : TextStyle(),
//                                       maxLines: 4,
//                                       keyboardType: TextInputType.multiline,
//                                       decoration: InputDecoration(
//                                         border: InputBorder.none,
//                                       ),
//                                     ),
//                                     Divider(
//                                       thickness: 1,
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                   ],
//                                 );
//                               });
//                         }
//                       },
//                     ),
//                     // child: ListView.builder(
//                     //     itemCount: 45,
//                     //     itemExtent: 180,
//                     //     itemBuilder: (context, index) {
//                     //       return Column(
//                     //         crossAxisAlignment: CrossAxisAlignment.start,
//                     //         children: [
//                     //           Row(
//                     //             children: [
//                     //               CircleAvatar(
//                     //                 radius: 15,
//                     //                 backgroundImage: MemoryImage(
//                     //                   Uint8List.fromList(user.bufferImage!),
//                     //                 ),
//                     //               ),
//                     //               SizedBox(
//                     //                 width: 10,
//                     //               ),
//                     //               Text(
//                     //                 'My name',
//                     //                 style: TextStyle(
//                     //                     fontSize: size.width / 22,
//                     //                     fontWeight: FontWeight.w700),
//                     //               ),
//                     //               Spacer(),
//                     //               Image.asset(
//                     //                 'assets/images/yellowStar.png',
//                     //                 height: 18,
//                     //                 width: 18,
//                     //               ),
//                     //               SizedBox(
//                     //                 width: 2,
//                     //               ),
//                     //               Text(
//                     //                 '1.0',
//                     //                 style: TextStyle(
//                     //                   fontSize: 18,
//                     //                 ),
//                     //               ),
//                     //             ],
//                     //           ),
//                     //           TextField(
//                     //             controller: reviewController,
//                     //             enabled: false,
//                     //             minLines: 1,
//                     //             maxLines: 4,
//                     //             keyboardType: TextInputType.multiline,
//                     //             decoration: InputDecoration(
//                     //               border: InputBorder.none,
//                     //             ),
//                     //           ),
//                     //           Divider(
//                     //             thickness: 1,
//                     //           ),
//                     //         ],
//                     //       );
//                     //     }),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Container(
//             //   margin: EdgeInsets.only(
//             //     left: kDefaultPadding,
//             //     right: kDefaultPadding,
//             //     top: size.height * 0.37,
//             //   ),
//             //   child: Column(
//             //     crossAxisAlignment: CrossAxisAlignment.start,
//             //     children: [
//             //       Row(
//             //         children: [
//             //           Text(
//             //             widget.name,
//             //             style: TextStyle(
//             //               fontSize: 26,
//             //               fontWeight: FontWeight.w700,
//             //             ),
//             //           ),
//             //         ],
//             //       ),
//             //       SizedBox(
//             //         height: 5,
//             //       ),
//             //       Row(
//             //         children: [
//             //           Text(
//             //             '${widget.category} - ${widget.brand}',
//             //             style: TextStyle(
//             //               fontSize: 18,
//             //               color: kTextColor.withOpacity(0.4),
//             //             ),
//             //           ),
//             //         ],
//             //       ),
//             //       SizedBox(
//             //         height: size.height * 0.02,
//             //       ),
//             //       Row(
//             //         children: [
//             //           Text(
//             //             'Review',
//             //             style: TextStyle(
//             //               fontSize: 22,
//             //               fontWeight: FontWeight.w700,
//             //             ),
//             //           ),
//             //         ],
//             //       ),
//             //       TextField(
//             //         controller: reviewController,
//             //         maxLines: null,
//             //         keyboardType: TextInputType.multiline,
//             //       ),
//             //       SizedBox(
//             //         height: 20,
//             //       ),
//             //       Row(
//             //         children: [
//             //           Text(
//             //             'Rating',
//             //             style: TextStyle(
//             //               fontSize: 22,
//             //               fontWeight: FontWeight.w700,
//             //             ),
//             //           ),
//             //         ],
//             //       ),
//             //       SizedBox(
//             //         height: 20,
//             //       ),
//             //       RatingBar.builder(
//             //         initialRating: myRating,
//             //         minRating: 1,
//             //         direction: Axis.horizontal,
//             //         allowHalfRating: true,
//             //         itemCount: 5,
//             //         itemBuilder: (context, _) => const Icon(
//             //           Icons.star,
//             //           color: Colors.amber,
//             //         ),
//             //         onRatingUpdate: (rating) {
//             //           setState(() {
//             //             myRating = rating;
//             //           });
//             //           // ratingService.rateProduct(
//             //           //     context: context,
//             //           //     productID: widget.id,
//             //           //     rating: rating);
//             //         },
//             //       ),
//             //       SizedBox(
//             //         height: size.height * 0.1,
//             //       ),
//             //       Row(
//             //         mainAxisAlignment: MainAxisAlignment.center,
//             //         children: [
//             //           ElevatedButton(
//             //             onPressed: myRating == 0
//             //                 ? null
//             //                 : () {
//             //                     ratingService.rateProduct(
//             //                         context: context,
//             //                         productID: widget.id,
//             //                         review: reviewController.text,
//             //                         rating: myRating);
//             //                   },
//             //             style: ElevatedButton.styleFrom(
//             //               primary: Theme.of(context).primaryColor,
//             //               shape: RoundedRectangleBorder(
//             //                 borderRadius: BorderRadius.only(
//             //                   topRight: Radius.circular(15),
//             //                   topLeft: Radius.circular(15),
//             //                   bottomRight: Radius.circular(15),
//             //                   bottomLeft: Radius.circular(15),
//             //                 ),
//             //               ),
//             //               elevation: 4.5,
//             //             ),
//             //             child: Row(
//             //               children: [
//             //                 Icon(
//             //                   Icons.rate_review_rounded,
//             //                   size: 30,
//             //                 ),
//             //                 SizedBox(
//             //                   width: 10,
//             //                 ),
//             //                 Text(
//             //                   "Give rating",
//             //                   style: TextStyle(
//             //                     fontSize: 18,
//             //                   ),
//             //                 ),
//             //               ],
//             //             ),
//             //           ),
//             //         ],
//             //       )
//             //     ],
//             //   ),
//             // ),
//             Container(
//               margin: EdgeInsets.only(
//                 left: kDefaultPadding,
//                 right: kDefaultPadding,
//                 top: size.height * 0.26,
//               ),
//               child: TabBar(
//                 tabs: [
//                   Tab(
//                     text: 'Give a review',
//                   ),
//                   Tab(
//                     text: 'Check reviews',
//                   ),
//                 ],
//               ),
//             ),
//             ImageRating(
//               size: size,
//               image: widget.image,
//             ),
//             Positioned(
//               top: size.width / 13,
//               left: size.width / 20,
//               child: CircleAvatar(
//                 backgroundColor: kBackgroundColor,
//                 child: IconButton(
//                   icon: Icon(Icons.arrow_back),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class ImageRating extends StatelessWidget {
//   const ImageRating({
//     Key? key,
//     required this.size,
//     required this.image,
//   }) : super(key: key);
//
//   final Size size;
//   final List<int> image;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: size.height * 0.25,
//       width: size.width,
//       decoration: BoxDecoration(
//         color: kBackgroundColor,
//         borderRadius: BorderRadius.vertical(
//             bottom: Radius.elliptical(MediaQuery.of(context).size.width, 20.0)),
//         image: DecorationImage(
//           image: MemoryImage(
//             Uint8List.fromList(image),
//           ),
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
// }
//
// class ReviewedUser {
//   final String name;
//   List<int>? bufferImage;
//
//   ReviewedUser(this.name, this.bufferImage);
// }

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fyp_mobile_app/models/service_provider_model.dart';
import 'package:fyp_mobile_app/models/user_model.dart';
import 'package:fyp_mobile_app/providers/user_provider.dart';
import 'package:fyp_mobile_app/services/rating_service.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';

class RatingScreen extends StatefulWidget {
  static const String routeName = "/rating";
  const RatingScreen({
    Key? key,
    // required this.image,
    required this.name,
    required this.categoryName,
    required this.providerName,
    required this.provider,
    required this.id,
    required this.image,
  }) : super(key: key);

  // final List<int> image;
  final String name;
  final String categoryName;
  final String providerName;
  final String id;
  final String image;
  final ServiceProvider provider;

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  double avgRating = 0;
  double myRating = 0;
  RatingService ratingService = RatingService();
  late TextEditingController reviewController;

  Future getReviewedUsers() async {
    try {
      final user = Provider.of<UserProvider>(context, listen: false).user;
      if (widget.provider.rating != null) {
        // print('Length');
        // print(widget.provider.rating![1].userId);
        List<ReviewedUser> users = [];
        for (int i = 0; i < widget.provider.rating!.length; i++) {
          http.Response response = await http.put(
            Uri.parse('$uri2/customer/rating/find-rated-user'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'id': widget.provider.rating![i].userId,
              'role': widget.provider.rating![i].role
            }),
          );
          var jsonData = jsonDecode(response.body);
          print('here');
          // List<ReviewedUser> users = [];
          // List<String> imageString = [];
          // String image = "";

          // for (var u in jsonData) {

          // if (jsonData['image'] != null) {
          //   List<dynamic> bufferDynamic = jsonData['image']['data']['data'];
          //   List<int> bufferInt = bufferDynamic.map((e) => e as int).toList();
          //
          //   dynamic userName =
          //       jsonData['firstname'] + " " + jsonData['lastname'];
          //   String name = userName ?? '';
          //
          //   ReviewedUser user = ReviewedUser(name, bufferInt);
          //   users.add(user);
          // } else {
          //   dynamic userName =
          //       jsonData['firstname'] + " " + jsonData['lastname'];
          //   String name = userName ?? '';
          //
          //   ReviewedUser user = ReviewedUser(name, []);
          //   users.add(user);
          // }

          // }
          // return users;

          dynamic userName = jsonData['firstname'] + " " + jsonData['lastname'];
          dynamic userImage = jsonData['image'];
          String name = userName ?? '';
          String image = userImage ?? '';

          ReviewedUser user = ReviewedUser(name, image);
          users.add(user);
        }
        return users;
      }
    } catch (e) {
      print('Problem');
      // TODO
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reviewController = TextEditingController();
    if (widget.provider.rating != null) {
      double totalRating = 0;
      for (int i = 0; i < widget.provider.rating!.length; i++) {
        totalRating += widget.provider.rating![i].rating;
        if (widget.provider.rating![i].userId ==
            Provider.of<UserProvider>(context, listen: false).user.id) {
          myRating = widget.provider.rating![i].rating;
        }
      }

      if (totalRating != 0) {
        avgRating = totalRating / widget.provider.rating!.length;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<UserProvider>(context, listen: false).user;
    print(user.role);
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(
                        left: kDefaultPadding,
                        right: kDefaultPadding,
                        top: size.height * 0.37,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.providerName,
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${widget.name} - ${widget.categoryName}',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: kTextColor.withOpacity(0.4),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Row(
                            children: [
                              Text(
                                'Review',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          TextField(
                            controller: reviewController,
                            minLines: 1,
                            maxLines: 4,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(200),
                            ],
                            keyboardType: TextInputType.multiline,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                'Rating',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RatingBar.builder(
                            initialRating: myRating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                myRating = rating;
                              });
                              // ratingService.rateProduct(
                              //     context: context,
                              //     productID: widget.id,
                              //     rating: rating);
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SingleChildScrollView(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: myRating == 0
                                      ? null
                                      : () {
                                          if (user.role == 'email') {
                                            ratingService.rateProduct(
                                                context: context,
                                                productID: widget.id,
                                                review: reviewController.text,
                                                role: user.role,
                                                rating: myRating);
                                          } else {
                                            ratingService.rateProductPhone(
                                                context: context,
                                                productID: widget.id,
                                                review: reviewController.text,
                                                role: user.role,
                                                rating: myRating);
                                          }
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
                                        Icons.rate_review_rounded,
                                        size: 30,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Give rating",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                      top: size.height * 0.37,
                    ),
                    child: FutureBuilder(
                      future: getReviewedUsers(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData == false) {
                          return const Scaffold(
                            body: Center(
                              child: SpinKitRotatingCircle(
                                color: kPrimaryColor,
                                size: 50,
                              ),
                            ),
                          );
                        } else {
                          List<TextEditingController> controllers = [];
                          TextEditingController emptyController =
                              TextEditingController();
                          emptyController.text = "*User did not review*";

                          for (int i = 0;
                              i < widget.provider.rating!.length;
                              i++) {
                            TextEditingController controller =
                                TextEditingController();
                            controller.text =
                                widget.provider.rating![i].review!;
                            controllers.add(controller);
                          }

                          if (snapshot.data.length == 0) {
                            return Center(
                              child: Text(
                                'No reviews',
                                style: TextStyle(
                                    fontSize: 22,
                                    color: kTextColor.withOpacity(0.4)),
                              ),
                            );
                          }

                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              // itemExtent: 150,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        snapshot.data[index].image.isNotEmpty
                                            ? CircleAvatar(
                                                radius: 15,
                                                // backgroundImage: MemoryImage(
                                                //   Uint8List.fromList(snapshot
                                                //       .data[index].bufferImage),
                                                // ),
                                                backgroundImage: NetworkImage(
                                                  snapshot.data[index].image,
                                                ),
                                              )
                                            : ProfilePicture(
                                                name: snapshot.data[index].name,
                                                radius: 15,
                                                fontsize: size.width / 30,
                                              ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          snapshot.data[index].name,
                                          style: TextStyle(
                                              fontSize: size.width / 22,
                                              fontWeight: FontWeight.w700),
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
                                          widget.provider.rating![index].rating
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    TextField(
                                      controller:
                                          controllers[index].text.isEmpty
                                              ? emptyController
                                              : controllers[index],
                                      enabled: false,
                                      minLines: 1,
                                      textAlign: controllers[index].text.isEmpty
                                          ? TextAlign.center
                                          : TextAlign.start,
                                      style: controllers[index].text.isEmpty
                                          ? TextStyle(
                                              color:
                                                  kTextColor.withOpacity(0.4))
                                          : TextStyle(),
                                      maxLines: 4,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                );
                              });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                // left: kDefaultPadding,
                // right: kDefaultPadding,
                top: size.height * 0.25,
              ),
              decoration: BoxDecoration(
                color: kPrimaryColor,
              ),
              child: TabBar(
                indicatorWeight: 5.0,
                indicatorColor: kBackgroundColor,
                tabs: [
                  Tab(
                    text: 'Give a review',
                  ),
                  Tab(
                    text: 'Check reviews',
                  ),
                ],
              ),
            ),
            ImageRating(
              size: size,
              image: widget.image,
            ),
            Positioned(
              top: size.width / 13,
              left: size.width / 20,
              child: CircleAvatar(
                backgroundColor: kBackgroundColor,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageRating extends StatelessWidget {
  const ImageRating({
    Key? key,
    required this.size,
    required this.image,
    // required this.image,
  }) : super(key: key);

  final Size size;
  final String image;
  // final List<int> image;

  @override
  Widget build(BuildContext context) {
    // print(image);
    return Container(
      height: size.height * 0.25,
      width: size.width,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        // borderRadius: BorderRadius.vertical(
        //     bottom: Radius.elliptical(MediaQuery.of(context).size.width, 20.0)),
        image: DecorationImage(
          // image: MemoryImage(
          //   Uint8List.fromList(image),
          // ),
          image: NetworkImage(
            // image,
            'https://media.istockphoto.com/id/1315800156/photo/automobile-mechanic-repairman-hands-repairing-a-car-engine-automotive-workshop-with-a-wrench.jpg?b=1&s=170667a&w=0&k=20&c=1mTACjOQsCywELazdevG3b9137Lfzh4ejXMFGMBBUi0=',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ReviewedUser {
  final String name;
  // List<int>? bufferImage;
  String? image;

  ReviewedUser(this.name, this.image);
}
