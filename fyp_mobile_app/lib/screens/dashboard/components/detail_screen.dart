// import 'package:flutter/material.dart';
// import 'package:fyp_mobile_app/constants.dart';
// import 'package:fyp_mobile_app/screens/dashboard/components/service_tile.dart';
//
// class ServiceProviderDetailScreen extends StatefulWidget {
//   static const String routeName = '/service-provider-detail';
//   const ServiceProviderDetailScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ServiceProviderDetailScreen> createState() =>
//       _ServiceProviderDetailScreenState();
// }
//
// class _ServiceProviderDetailScreenState
//     extends State<ServiceProviderDetailScreen> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             margin: EdgeInsets.only(
//                 left: kDefaultPadding / 2,
//                 right: kDefaultPadding / 2,
//                 top: size.height * 0.32),
//             //padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
//             decoration: BoxDecoration(
//               color: kBackgroundColor,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'XYZ Workshop name',
//                   style: TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   style: TextButton.styleFrom(
//                     minimumSize: Size.zero, // Set this
//                     padding: EdgeInsets.zero, // and this
//                   ),
//                   child: Text(
//                     'Reviews and more',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: size.width,
//                   height: 10,
//                   color: kPrimaryColor.withOpacity(0.05),
//                 ),
//                 // ListView.builder(
//                 //   itemCount: 5,
//                 //   itemBuilder: (context, index) {
//                 //     return OrderTile(size: size, status: list[index]);
//                 //   },
//                 // ),
//
//                 Text(
//                   'Services',
//                   style: TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: 5,
//                     itemExtent: 120,
//                     itemBuilder: (context, index) {
//                       return ServiceTile(size: size);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             height: size.height * 0.3,
//             width: size.width,
//             decoration: BoxDecoration(
//               color: kBackgroundColor,
//               borderRadius: BorderRadius.vertical(
//                   bottom: Radius.elliptical(
//                       MediaQuery.of(context).size.width, 20.0)),
//               image: DecorationImage(
//                 image: NetworkImage(
//                   'https://images.unsplash.com/photo-1586335963805-7b603f62a048?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2FyJTIwd29ya3Nob3B8ZW58MHx8MHx8&auto=format&fit=crop&w=700&q=60',
//                 ),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Positioned(
//             top: 40,
//             left: 15,
//             child: CircleAvatar(
//               backgroundColor: kBackgroundColor,
//               child: IconButton(
//                 icon: Icon(Icons.arrow_back),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/addressHandling.dart';
import 'package:fyp_mobile_app/screens/dashboard/components/service_tile.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ServiceProviderDetailScreen extends StatefulWidget {
  static const String routeName = '/service-provider-detail';
  static const IconData verified =
      IconData(0xe699, fontFamily: 'MaterialIcons');
  ServiceProviderDetailScreen({
    Key? key,
    required this.name,
    required this.serviceType,
    required this.description,
    required this.timeRequired,
    required this.providerName,
    required this.price,
    required this.categoryName,
    required this.where,
    required this.email,
    required this.address,
    required this.number,
    required this.id,
    required this.image,
  }) : super(key: key);

  final String name;
  final String address;
  final String serviceType;
  final String description;
  final String timeRequired;
  final String providerName;
  final String image;
  // final String category;
  // final String brand;
  final int price;
  final String categoryName;
  final String where;
  final String email;
  final String number;
  final String id;

  @override
  State<ServiceProviderDetailScreen> createState() =>
      _ServiceProviderDetailScreenState();
}

class _ServiceProviderDetailScreenState
    extends State<ServiceProviderDetailScreen> {
  void navigateToAddressPage(BuildContext context, int price, String id) {
    Navigator.pushNamed(context, AddressPage.routeName,
        arguments: AddressPage(
          price: price,
          id: id,
          name: widget.name,
        ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: kPrimaryColor,
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!

          navigateToAddressPage(context, widget.price, widget.id);
        },
        backgroundColor: kPrimaryColor,
        label: const Text('Book now'),
        icon: const Icon(Icons.shopping_cart),
      ),

      body: Stack(
        children: [
          Container(
            width: size.width,
            decoration: BoxDecoration(color: kPrimaryColor),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.15),
            padding: EdgeInsets.only(
                left: kDefaultPadding,
                right: kDefaultPadding,
                top: kDefaultPadding * 4),
            width: size.width,
            decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(36),
                topRight: Radius.circular(36),
              ),
            ),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // FittedBox(
                    //   fit: BoxFit.scaleDown,
                    //   child: Text(
                    //     'Ameer hamza workshopdosiehdfseihfiuesfhfiesuhefsiuhfesih',
                    //     style: Theme.of(context).textTheme.headline4!.copyWith(
                    //           color: kTextColor,
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 20,
                    //         ),
                    //   ),
                    // ),
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: AutoSizeText(
                          widget.providerName,
                          maxLines: 2,
                          // style: TextStyle(
                          //   color: kTextColor,
                          //   fontWeight: FontWeight.bold,
                          //   fontSize: 30,
                          // ),
                          maxFontSize: 26,
                          minFontSize: 20,
                          style: TextStyle(
                            color: kTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),

                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Icon(
                          Icons.verified,
                          size: 25,
                        ),
                      ),
                    ),

                    // Icon(
                    //   Icons.verified,
                    //   size: 35,
                    // ),

                    // IconButton(
                    //   icon: Icon(Icons.verified),
                    //   color: kPrimaryColor,
                    //   highlightColor: kPrimaryColor,
                    //   onPressed: () {},
                    // ),
                  ],
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Expanded(
                //       flex: 2,
                //       child: RichText(
                //         text: TextSpan(
                //           children: [
                //             TextSpan(
                //               text: widget.providerName,
                //               style: Theme.of(context)
                //                   .textTheme
                //                   .headline4!
                //                   .copyWith(
                //                     color: kTextColor,
                //                     fontWeight: FontWeight.bold,
                //                   ),
                //             ),
                //
                //             // TextSpan(
                //             //   text: "$text\n",
                //             //   style: Theme.of(context).textTheme.caption!.copyWith(
                //             //     color: kTextColor,
                //             //     fontWeight: FontWeight.w400,
                //             //     fontSize: 26,
                //             //   ),
                //             // ),
                //           ],
                //         ),
                //       ),
                //     ),
                //     Expanded(
                //       flex: 2,
                //       child: Icon(
                //         Icons.verified,
                //         size: 35,
                //       ),
                //     ),
                //   ],
                // ),

                // ListTile(
                //   // dense: true,
                //   contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                //   title: Text(
                //     widget.providerName,
                //     style: Theme.of(context).textTheme.headline5!.copyWith(
                //           color: kTextColor,
                //           fontWeight: FontWeight.bold,
                //         ),
                //   ),
                //   trailing: Icon(
                //     Icons.verified,
                //     size: 35,
                //   ),
                // ),

                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        // '1-C R-1, Block R Phase 2 Johar Town, Lahore',
                        widget.address,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: kTextColor.withOpacity(0.6)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Category:  ',
                      // widget.address,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: kTextColor.withOpacity(0.6)),
                    ),
                    Expanded(
                      child: Text(
                        widget.categoryName,
                        // widget.address,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: kTextColor),
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Name:  ',
                      // widget.address,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: kTextColor.withOpacity(0.6)),
                    ),
                    Expanded(
                      child: Text(
                        widget.name,
                        // widget.address,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: kTextColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Where: ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: kTextColor.withOpacity(0.8),
                      ),
                    ),
                    Text(
                      widget.where == '1' ? 'Pickup and drop' : 'At doorstep',
                      // widget.address,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: kTextColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        widget.description,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: kTextColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Contact Information',
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(
                      widget.number,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.email),
                    title: Text(
                      widget.email,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kTextColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.015,
            right: size.width * 0.30,
            child: CircleAvatar(
              radius: 75,
              backgroundImage: NetworkImage(
                // widget.image,
                'https://media.istockphoto.com/id/1315800156/photo/automobile-mechanic-repairman-hands-repairing-a-car-engine-automotive-workshop-with-a-wrench.jpg?b=1&s=170667a&w=0&k=20&c=1mTACjOQsCywELazdevG3b9137Lfzh4ejXMFGMBBUi0=',
              ),
            ),
          ),
        ],
      ),
      // Text('YOO'),
    );
  }
}
