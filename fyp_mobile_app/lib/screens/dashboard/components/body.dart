// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fyp_mobile_app/models/service_provider_model.dart';
// import 'package:fyp_mobile_app/providers/service_provider.dart';
// import 'package:fyp_mobile_app/screens/dashboard/components/brand_screen.dart';
// import 'package:fyp_mobile_app/screens/dashboard/components/category_populate.dart';
// import 'package:fyp_mobile_app/screens/dashboard/components/category_screen.dart';
// import 'package:fyp_mobile_app/screens/dashboard/components/single_featured.dart';
// import 'package:fyp_mobile_app/services/service_provider_service.dart';
// import 'package:provider/provider.dart';
//
// import '../../../constants.dart';
// import '../../../providers/emailPasswordProvider.dart';
//
// class Body extends StatefulWidget {
//   const Body({Key? key}) : super(key: key);
//
//   @override
//   State<Body> createState() => _BodyState();
// }
//
// class _BodyState extends State<Body> {
//   ServiceProviderService service = ServiceProviderService();
//   // void navigateToBrandPage(
//   // void navigateToCategoryPage(
//   //     BuildContext context, String category, String image) {
//   //   Navigator.pushNamed(context, CategoryScreen.routeName,
//   //       arguments: CategoryScreen(category: category, image: image));
//   // }
//
//   // Future<List<ServiceProvider>> serviceProviders = [];
//   //
//   // @override
//   // void initState() {
//   //   serviceProviders = service.getFeatured();
//   //   super.initState();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     List list = [
//       'https://images.unsplash.com/photo-1586335963805-7b603f62a048?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyJTIwd29ya3Nob3B8ZW58MHx8MHx8&auto=format&fit=crop&w=700&q=60',
//       'https://images.unsplash.com/photo-1586335963805-7b603f62a048?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyJTIwd29ya3Nob3B8ZW58MHx8MHx8&auto=format&fit=crop&w=700&q=60',
//       'https://images.unsplash.com/photo-1586335963805-7b603f62a048?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyJTIwd29ya3Nob3B8ZW58MHx8MHx8&auto=format&fit=crop&w=700&q=60',
//       'https://images.unsplash.com/photo-1586335963805-7b603f62a048?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyJTIwd29ya3Nob3B8ZW58MHx8MHx8&auto=format&fit=crop&w=700&q=60',
//     ];
//     final name = Provider.of<Email>(context, listen: false).fullName;
//     Size size = MediaQuery.of(context).size;
//     ScrollController _scrollController = ScrollController();
//     final featuredList =
//         Provider.of<ServiceProviderProvider>(context, listen: false);
//
//     _scrollToBottom() {
//       _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//     }
//
//     // return Column(
//     //   children: [
//     //     Container(
//     //       margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
//     //       // it will cover 20% of our total height
//     //       height: size.height * 0.4,
//     //       child: Stack(
//     //         children: [
//     //           Container(
//     //             padding: EdgeInsets.only(
//     //               left: kDefaultPadding,
//     //               right: kDefaultPadding,
//     //               bottom: kDefaultPadding,
//     //             ),
//     //             height: size.height * 0.4,
//     //             width: size.width,
//     //             decoration: BoxDecoration(
//     //               color: kPrimaryColor,
//     //               borderRadius: BorderRadius.only(
//     //                 bottomLeft: Radius.circular(36),
//     //                 bottomRight: Radius.circular(36),
//     //               ),
//     //             ),
//     //             child: Padding(
//     //               padding: EdgeInsets.only(top: kDefaultPadding * 2),
//     //               child: Text(
//     //                 "Hi $name!",
//     //                 style: Theme.of(context).textTheme.headline4?.copyWith(
//     //                       color: Colors.white,
//     //                       fontWeight: FontWeight.bold,
//     //                     ),
//     //               ),
//     //             ),
//     //           ),
//     //         ],
//     //       ),
//     //     ),
//     //   ],
//     // );
//     return Stack(
//       children: [
//         // Container(),
//         Container(
//           padding: EdgeInsets.only(
//               top: size.height * 0.33,
//               left: kDefaultPadding,
//               right: kDefaultPadding),
//           height: size.height * 0.92,
//           width: size.width,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(36),
//               bottomRight: Radius.circular(36),
//             ),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(bottom: kDefaultPadding),
//                 child: Text(
//                   'Category',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: kDefaultPadding),
//                 child: SizedBox(
//                   height: 80,
//                   child: ListView.builder(
//                     itemCount: categoryImages.length,
//                     itemExtent: 85,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           // navigateToCategoryPage(
//                           //     context,
//                           //     categoryImages[index]['title']!,
//                           //     categoryImages[index]['image']!);
//                         },
//                         child: Column(
//                           children: [
//                             Container(
//                               padding: EdgeInsets.symmetric(horizontal: 10),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(50),
//                                 child: Image.asset(
//                                   categoryImages[index]['image']!,
//                                   fit: BoxFit.cover,
//                                   height: 50,
//                                   width: 50,
//                                 ),
//                               ),
//                             ),
//                             Text(
//                               categoryImages[index]['title']!,
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   fontSize: 12, fontWeight: FontWeight.w500),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: kDefaultPadding),
//                 child: Text(
//                   'Featured',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//                 ),
//               ),
//               Expanded(
//                 child: FutureBuilder(
//                   // future: service.getFeatured(context: context),
//                   builder: (context, AsyncSnapshot snapshot) {
//                     if (snapshot.hasData == false) {
//                       return const Scaffold(
//                         body: Center(
//                           child: SpinKitRotatingCircle(
//                             color: kPrimaryColor,
//                             size: 50,
//                           ),
//                         ),
//                       );
//                     } else {
//                       if (snapshot.data.length == 0) {
//                         return Center(
//                           child: Text(
//                             'No services',
//                             style: TextStyle(
//                                 fontSize: 22,
//                                 color: kTextColor.withOpacity(0.4)),
//                           ),
//                         );
//                       }
//
//                       return GridView.builder(
//                           itemCount: snapshot.data.length,
//                           shrinkWrap: true,
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 1,
//                                   childAspectRatio: 1.4,
//                                   mainAxisExtent: 350),
//                           itemBuilder: (context, index) {
//                             return GestureDetector(
//                               onTap: () {
//                                 // Navigator.pushNamed(
//                                 //     context, ServiceProviderDetailScreen.routeName);
//                               },
//                               child: CategoryPopulate(
//                                 size: size,
//                                 id: snapshot.data[index].id,
//                                 name: snapshot.data[index].name,
//                                 address: snapshot.data[index].address,
//                                 price: snapshot.data[index].price,
//                                 brand: snapshot.data[index].brandName,
//                                 category: snapshot.data[index].category,
//                                 image: snapshot.data[index].bufferImage,
//                                 average: snapshot.data[index].average,
//                                 // rating: snapshot.data[index].rating,
//                                 isSelected: false,
//                                 i: index,
//                                 provider: snapshot.data[index],
//                               ),
//                             );
//                           });
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           height: size.height * 0.27,
//           width: size.width,
//           padding: EdgeInsets.only(
//             top: kDefaultPadding,
//             left: kDefaultPadding,
//             right: kDefaultPadding,
//           ),
//           decoration: BoxDecoration(
//             color: kPrimaryColor,
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(36),
//               bottomRight: Radius.circular(36),
//             ),
//           ),
//           child: SafeArea(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // IconButton(
//                 //   onPressed: () {},
//                 //   icon: Icon(
//                 //     Icons.menu_rounded,
//                 //     color: kTextColor,
//                 //     size: 30,
//                 //   ),
//                 // ),
//                 SizedBox(
//                   height: 25,
//                 ),
//                 Text(
//                   'Hi, ',
//                   textAlign: TextAlign.left,
//                   style: Theme.of(context).textTheme.headline5!.copyWith(
//                         overflow: TextOverflow.ellipsis,
//                         fontWeight: FontWeight.bold,
//                       ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   'What service do\n you need?',
//                   textAlign: TextAlign.left,
//                   style: Theme.of(context).textTheme.headline5!.copyWith(
//                         overflow: TextOverflow.ellipsis,
//                         fontWeight: FontWeight.bold,
//                       ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Positioned(
//           top: 100,
//           right: 16,
//           child: ClipRRect(
//             child: Image.asset(
//               'assets/images/services.png',
//               scale: 3,
//             ),
//             borderRadius: BorderRadius.circular(16),
//           ),
//         ),
//       ],
//     );
//   }
// }
