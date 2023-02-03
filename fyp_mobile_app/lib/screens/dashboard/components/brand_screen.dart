// import 'package:flutter/material.dart';
// import 'package:fyp_mobile_app/constants.dart';
// import 'package:fyp_mobile_app/screens/dashboard/components/category_screen.dart';
//
// class BrandScreen extends StatefulWidget {
//   static const String routeName = '/brand-screen';
//   final String category;
//   final String image;
//   final String name;
//   const BrandScreen(
//       {Key? key,
//       required this.category,
//       required this.image,
//       required this.name})
//       : super(key: key);
//
//   @override
//   State<BrandScreen> createState() => _BrandScreenState();
// }
//
// class _BrandScreenState extends State<BrandScreen> {
//   void navigateToCategoryPage(BuildContext context, String category,
//       String image, String brandName, String name) {
//     Navigator.pushNamed(context, CategoryScreen.routeName,
//         arguments: CategoryScreen(
//             category: category,
//             image: image,
//             brandName: brandName,
//             categoryName: name));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         foregroundColor: kTextColor,
//         backgroundColor: kPrimaryColor,
//         title: Text(
//           'Vehicle brand',
//           style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: GridView.builder(
//         padding: EdgeInsets.only(
//             left: kDefaultPadding / 1.6, right: kDefaultPadding / 1.6),
//         itemCount: brandImages.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2, childAspectRatio: 1.4, mainAxisExtent: 150),
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               // Navigator.pushNamed(
//               //     context, ServiceProviderDetailScreen.routeName);
//               navigateToCategoryPage(context, widget.category, widget.image,
//                   brandImages[index]['title']!, widget.name);
//             },
//             child: Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(50),
//                     child: Image.asset(
//                       brandImages[index]['image']!,
//                       fit: BoxFit.contain,
//                       height: 150,
//                       width: 150,
//                     ),
//                   ),
//                 ),
//                 // Text(
//                 //   brandImages[index]['title']!,
//                 //   textAlign: TextAlign.center,
//                 //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
//                 // ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
