// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fyp_mobile_app/constants.dart';
// import 'package:fyp_mobile_app/providers/swapCartButtonProvider.dart';
// import 'package:fyp_mobile_app/providers/user_provider.dart';
// import 'package:fyp_mobile_app/screens/dashboard/components/category_populate.dart';
// import 'package:fyp_mobile_app/screens/dashboard/components/detail_screen.dart';
// import 'package:fyp_mobile_app/services/service_provider_service.dart';
// import 'package:provider/provider.dart';
//
// import '../../../models/service_provider_model.dart';
//
// class CategoryScreen extends StatefulWidget {
//   static const String routeName = '/category';
//
//   final String category;
//   final String image;
//   final String brandName;
//   const CategoryScreen(
//       {Key? key,
//       required this.category,
//       required this.image,
//       required this.brandName})
//       : super(key: key);
//
//   @override
//   State<CategoryScreen> createState() => _CategoryScreenState();
// }
//
// class _CategoryScreenState extends State<CategoryScreen> {
//   ServiceProviderService service = ServiceProviderService();
//   // late Future<dynamic> serviceProvider;
//   //
//   // @override
//   // void initState() {
//   //   // TODO: implement initState
//   //   serviceProvider = service.getUserData();
//   //   super.initState();
//   // }
//   // @override
//   // void initState() {
//   //   service.getUserData(
//   //       category: widget.category, context: context);
//   //   super.initState();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         foregroundColor: kTextColor,
//         backgroundColor: kPrimaryColor,
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: size.height * 0.2,
//             width: size.width,
//             padding: EdgeInsets.only(
//               left: kDefaultPadding,
//               right: kDefaultPadding,
//             ),
//             margin: EdgeInsets.only(bottom: kDefaultPadding),
//             decoration: BoxDecoration(
//               color: kPrimaryColor,
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(36),
//                 bottomRight: Radius.circular(36),
//               ),
//             ),
//             child: SafeArea(
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(50),
//                         child: Image.asset(
//                           widget.image,
//                           fit: BoxFit.cover,
//                           width: 80,
//                           height: 80,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         widget.category,
//                         style: Theme.of(context).textTheme.headline5!.copyWith(
//                               overflow: TextOverflow.ellipsis,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 32,
//                             ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: FutureBuilder(
//               future: service.getUserData(
//                   category: widget.category,
//                   context: context,
//                   brandName: widget.brandName),
//               builder: (context, AsyncSnapshot snapshot) {
//                 if (snapshot.hasData == false) {
//                   return const Scaffold(
//                     body: Center(
//                       child: SpinKitRotatingCircle(
//                         color: kPrimaryColor,
//                         size: 50,
//                       ),
//                     ),
//                   );
//                 } else {
//                   // final userProvider =
//                   //     Provider.of<UserProvider>(context, listen: false);
//                   // List<bool> isSelected =
//                   //     List.generate(snapshot.data.length, (index) => false);
//                   // try {
//                   //   for (int i = 0; i < snapshot.data.length; i++) {
//                   //     for (int j = 0; j < userProvider.user.cart.length; j++) {
//                   //       if (snapshot.data[i].id ==
//                   //           userProvider.user.cart[j]['product']['_id']) {
//                   //         isSelected[i] =
//                   //             userProvider.user.cart[j]['addToCart'];
//                   //         print(isSelected);
//                   //         break;
//                   //       }
//                   //     }
//                   //   }
//                   // } catch (e) {
//                   //   // TODO
//                   // }
//                   if (snapshot.data.length == 0) {
//                     return Center(
//                       child: Text(
//                         'No services',
//                         style: TextStyle(
//                             fontSize: 22, color: kTextColor.withOpacity(0.4)),
//                       ),
//                     );
//                   }
//
//                   return GridView.builder(
//                       padding: EdgeInsets.only(
//                           left: kDefaultPadding / 1.6,
//                           right: kDefaultPadding / 1.6),
//                       itemCount: snapshot.data.length,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 1,
//                               childAspectRatio: 1.4,
//                               mainAxisExtent: 380),
//                       itemBuilder: (context, index) {
//                         // List<bool> list = List.generate(snapshot.data!.length,
//                         //     (index) => snapshot.data[index].isSelected);
//                         //
//                         // Provider.of<SwapCartButtonProvider>(context,
//                         //         listen: false)
//                         //     .swapCartList(list);
//                         // List<bool> list1 = Provider.of<SwapCartButtonProvider>(
//                         //         context,
//                         //         listen: false)
//                         //     .isSelected;
//
//                         // final userProvider =
//                         //     Provider.of<UserProvider>(context, listen: false);
//                         // bool isSelected = false;
//                         // try {
//                         //   for (int i = 0; i < snapshot.data.length; i++) {
//                         //     for (int j = 0;
//                         //         j < userProvider.user.cart.length;
//                         //         j++) {
//                         //       print('YOO');
//                         //       if (snapshot.data[i].id ==
//                         //           userProvider.user.cart[j]['product']['_id']) {
//                         //         isSelected =
//                         //             userProvider.user.cart[j]['addToCart'];
//                         //       }
//                         //     }
//                         //   }
//                         //
//                         //   print(isSelected);
//                         // } catch (e) {
//                         //   // TODO
//                         // }
//                         return GestureDetector(
//                           onTap: () {
//                             // Navigator.pushNamed(
//                             //     context, ServiceProviderDetailScreen.routeName);
//                           },
//                           child: CategoryPopulate(
//                             size: size,
//                             id: snapshot.data[index].id,
//                             name: snapshot.data[index].name,
//                             address: snapshot.data[index].address,
//                             price: snapshot.data[index].price,
//                             brand: snapshot.data[index].brandName,
//                             category: snapshot.data[index].category,
//                             image: snapshot.data[index].bufferImage,
//                             average: snapshot.data[index].average,
//                             // rating: snapshot.data[index].rating,
//                             isSelected: false,
//                             i: index,
//                             provider: snapshot.data[index],
//                           ),
//                         );
//                       });
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/providers/swapCartButtonProvider.dart';
import 'package:fyp_mobile_app/providers/user_provider.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/category_populate.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/detail_screen.dart';
import 'package:fyp_mobile_app/services/service_provider_service.dart';
import 'package:provider/provider.dart';

import '../../../models/service_provider_model.dart';

class CategoryScreen extends StatefulWidget {
  static const String routeName = '/category';

  final String category;
  final String image;
  // final String brandName;
  final String categoryName;
  const CategoryScreen(
      {Key? key,
      required this.category,
      required this.image,
      // required this.brandName,
      required this.categoryName})
      : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  ServiceProviderService service = ServiceProviderService();
  // late Future<dynamic> serviceProvider;
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   serviceProvider = service.getUserData();
  //   super.initState();
  // }
  // @override
  // void initState() {
  //   service.getUserData(
  //       category: widget.category, context: context);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: kTextColor,
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          Container(
            height: size.height * 0.2,
            width: size.width,
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
            ),
            margin: EdgeInsets.only(bottom: kDefaultPadding),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          widget.image,
                          fit: BoxFit.cover,
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        widget.categoryName,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: service.getServiceData(
                type: widget.category,
                context: context,
              ),
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
                  // final userProvider =
                  //     Provider.of<UserProvider>(context, listen: false);
                  // List<bool> isSelected =
                  //     List.generate(snapshot.data.length, (index) => false);
                  // try {
                  //   for (int i = 0; i < snapshot.data.length; i++) {
                  //     for (int j = 0; j < userProvider.user.cart.length; j++) {
                  //       if (snapshot.data[i].id ==
                  //           userProvider.user.cart[j]['product']['_id']) {
                  //         isSelected[i] =
                  //             userProvider.user.cart[j]['addToCart'];
                  //         print(isSelected);
                  //         break;
                  //       }
                  //     }
                  //   }
                  // } catch (e) {
                  //   // TODO
                  // }
                  if (snapshot.data.length == 0) {
                    return Center(
                      child: Text(
                        'No services',
                        style: TextStyle(
                            fontSize: 22, color: kTextColor.withOpacity(0.4)),
                      ),
                    );
                  }

                  return GridView.builder(
                      padding: EdgeInsets.only(
                          left: kDefaultPadding / 1.6,
                          right: kDefaultPadding / 1.6),
                      itemCount: snapshot.data.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        // childAspectRatio: 1.4,
                        // mainAxisExtent: 380,
                      ),
                      itemBuilder: (context, index) {
                        // List<bool> list = List.generate(snapshot.data!.length,
                        //     (index) => snapshot.data[index].isSelected);
                        //
                        // Provider.of<SwapCartButtonProvider>(context,
                        //         listen: false)
                        //     .swapCartList(list);
                        // List<bool> list1 = Provider.of<SwapCartButtonProvider>(
                        //         context,
                        //         listen: false)
                        //     .isSelected;

                        // final userProvider =
                        //     Provider.of<UserProvider>(context, listen: false);
                        // bool isSelected = false;
                        // try {
                        //   for (int i = 0; i < snapshot.data.length; i++) {
                        //     for (int j = 0;
                        //         j < userProvider.user.cart.length;
                        //         j++) {
                        //       print('YOO');
                        //       if (snapshot.data[i].id ==
                        //           userProvider.user.cart[j]['product']['_id']) {
                        //         isSelected =
                        //             userProvider.user.cart[j]['addToCart'];
                        //       }
                        //     }
                        //   }
                        //
                        //   print(isSelected);
                        // } catch (e) {
                        //   // TODO
                        // }
                        return GestureDetector(
                          onTap: () {
                            // Navigator.pushNamed(
                            //     context, ServiceProviderDetailScreen.routeName);
                          },
                          child: CategoryPopulate(
                            size: size,
                            id: snapshot.data[index].id,
                            name: snapshot.data[index].name,
                            serviceType: snapshot.data[index].serviceType,
                            price: snapshot.data[index].price,
                            timeRequired: snapshot.data[index].timeRequired,
                            description: snapshot.data[index].description,
                            providerName: snapshot.data[index].providerName,
                            where: snapshot.data[index].where,
                            categoryName: widget.categoryName,
                            address: snapshot.data[index].address,
                            email: snapshot.data[index].email,
                            number: snapshot.data[index].number,
                            // category: snapshot.data[index].category,
                            // image: snapshot.data[index].bufferImage,
                            average: snapshot.data[index].average,
                            image: snapshot.data[index].image,
                            rating: snapshot.data[index].rating,
                            isSelected: false,
                            i: index,
                            provider: snapshot.data[index],
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
