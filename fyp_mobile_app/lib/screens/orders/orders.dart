// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fyp_mobile_app/constants.dart';
// import 'package:fyp_mobile_app/models/order_model.dart';
// import 'package:fyp_mobile_app/providers/user_provider.dart';
// import 'package:fyp_mobile_app/screens/account/components/single_product.dart';
// import 'package:fyp_mobile_app/services/order_service.dart';
// import 'package:provider/provider.dart';
//
// import 'components/orders_tile.dart';
//
// class Orders extends StatefulWidget {
//   static const String routeName = '/order-history';
//   const Orders({Key? key}) : super(key: key);
//
//   @override
//   State<Orders> createState() => _OrdersState();
// }
//
// class _OrdersState extends State<Orders> {
//   // // temporary list
//   // List<Order>? orders;
//   // OrderService orderService = OrderService();
//   //
//   // List list = ['Pending', 'Completed', 'Pending', 'Completed'];
//   //
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   fetchOrders();
//   // }
//   //
//   // void fetchOrders() async {
//   //   orders = await orderService.fetchMyOrders(context: context);
//   //   setState(() {});
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     List<Order>? orders;
//     OrderService orderService = OrderService();
//     final user = Provider.of<UserProvider>(context, listen: false).user;
//
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(size.height * 0.1),
//         child: AppBar(
//           foregroundColor: kTextColor,
//           title: Text(
//             'Order history',
//             style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
//           ),
//           backgroundColor: kPrimaryColor,
//           elevation: 0,
//           leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back,
//               // size: 12,
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 10,
//           ),
//           // Expanded(
//           //   child: ListView.builder(
//           //     itemCount: orders!.length,
//           //     itemBuilder: (context, index) {
//           //       return OrderTile(
//           //         size: size,
//           //         status: list[index],
//           //         price: orders![index].totalPrice,
//           //         date: orders![index].orderedAt,
//           //         id: orders![index].id,
//           //       );
//           //     },
//           //   ),
//           // )
//           Expanded(
//             child: FutureBuilder(
//               future: user.role == 'email'
//                   ? orderService.fetchMyOrders(context: context)
//                   : orderService.fetchMyOrdersPhone(context: context),
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
//                   if (snapshot.data.length == 0) {
//                     return Center(
//                       child: Text(
//                         'No orders',
//                         style: TextStyle(
//                             fontSize: 22, color: kTextColor.withOpacity(0.4)),
//                       ),
//                     );
//                   }
//
//                   return ListView.builder(
//                     itemCount: snapshot.data.length,
//                     itemBuilder: (context, index) {
//                       return OrderTile(
//                         size: size,
//                         status: snapshot.data[index].status,
//                         price: snapshot.data[index].totalPrice,
//                         date: snapshot.data[index].orderedAt,
//                         orderNo: snapshot.data[index].orderNo,
//                         provider: snapshot.data[index].products,
//                         address: snapshot.data[index].address,
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           ),
//           // OrderTile(size: size),
//           // OrderTile(size: size),
//           // OrderTile(size: size),
//           // OrderTile(size: size),
//         ],
//       ),
//     );
//
//     // return Column(
//     //   children: [
//     //     Row(
//     //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //       children: [
//     //         Container(
//     //           padding: EdgeInsets.only(left: (kDefaultPadding / 2) + 5),
//     //           child: Text(
//     //             'Your Orders',
//     //             style: TextStyle(
//     //               fontSize: 18,
//     //               color: kTextColor,
//     //               fontWeight: FontWeight.w600,
//     //             ),
//     //           ),
//     //         ),
//     //         // Container(
//     //         //   padding: EdgeInsets.only(
//     //         //     right: (kDefaultPadding / 2) + 5,
//     //         //   ),
//     //         //   child: Text(
//     //         //     'See All',
//     //         //     style: TextStyle(
//     //         //       color: kPrimaryColor,
//     //         //     ),
//     //         //   ),
//     //         // ),
//     //         // display orders
//     //       ],
//     //     ),
//     //     Container(
//     //       height: 300,
//     //       padding: const EdgeInsets.only(
//     //           left: kDefaultPadding / 10, right: 0, top: kDefaultPadding),
//     //       child: ListView.builder(
//     //         itemCount: list.length,
//     //         itemBuilder: (context, index) {
//     //           return SingleProduct(image: list[index]);
//     //         },
//     //       ),
//     //     ),
//     //   ],
//     // );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/models/order_model.dart';
import 'package:fyp_mobile_app/providers/user_provider.dart';
import 'package:fyp_mobile_app/screens/account/components/single_product.dart';
import 'package:fyp_mobile_app/services/order_service.dart';
import 'package:provider/provider.dart';

import 'components/orders_tile.dart';

class Orders extends StatefulWidget {
  static const String routeName = '/order-history';
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  // // temporary list
  // List<Order>? orders;
  // OrderService orderService = OrderService();
  //
  // List list = ['Pending', 'Completed', 'Pending', 'Completed'];
  //
  // @override
  // void initState() {
  //   super.initState();
  //   fetchOrders();
  // }
  //
  // void fetchOrders() async {
  //   orders = await orderService.fetchMyOrders(context: context);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Order>? orders;
    OrderService orderService = OrderService();
    final user = Provider.of<UserProvider>(context, listen: false).user;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.1),
        child: AppBar(
          foregroundColor: kTextColor,
          title: Text(
            'Order history',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          backgroundColor: kPrimaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              // size: 12,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: orders!.length,
          //     itemBuilder: (context, index) {
          //       return OrderTile(
          //         size: size,
          //         status: list[index],
          //         price: orders![index].totalPrice,
          //         date: orders![index].orderedAt,
          //         id: orders![index].id,
          //       );
          //     },
          //   ),
          // )
          Expanded(
            child: FutureBuilder(
              future: user.role == 'email'
                  ? orderService.fetchMyOrders(context: context)
                  : orderService.fetchMyOrdersPhone(context: context),
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
                  if (snapshot.data.length == 0) {
                    return Center(
                      child: Text(
                        'No orders',
                        style: TextStyle(
                            fontSize: 22, color: kTextColor.withOpacity(0.4)),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return OrderTile(
                        size: size,
                        id: snapshot.data[index].id,
                        status: snapshot.data[index].status,
                        requestedOn: snapshot.data[index].requestedOn,
                        totalPrice: snapshot.data[index].totalPrice,
                        customerId: snapshot.data[index].customerId,
                        firstName: snapshot.data[index].firstName,
                        carName: snapshot.data[index].carName,
                        carNumber: snapshot.data[index].carNumber,
                        customerAddress: snapshot.data[index].customerAddress,
                        serviceName: snapshot.data[index].serviceName,
                        serviceProviderId:
                            snapshot.data[index].serviceProviderId,
                        mechanicName: snapshot.data[index].mechanicName,
                        mechanicPhone: snapshot.data[index].mechanicPhone,
                        mechanicEmail: snapshot.data[index].mechanicEmail,
                      );
                    },
                  );
                }
              },
            ),
          ),
          // OrderTile(size: size),
          // OrderTile(size: size),
          // OrderTile(size: size),
          // OrderTile(size: size),
        ],
      ),
    );

    // return Column(
    //   children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Container(
    //           padding: EdgeInsets.only(left: (kDefaultPadding / 2) + 5),
    //           child: Text(
    //             'Your Orders',
    //             style: TextStyle(
    //               fontSize: 18,
    //               color: kTextColor,
    //               fontWeight: FontWeight.w600,
    //             ),
    //           ),
    //         ),
    //         // Container(
    //         //   padding: EdgeInsets.only(
    //         //     right: (kDefaultPadding / 2) + 5,
    //         //   ),
    //         //   child: Text(
    //         //     'See All',
    //         //     style: TextStyle(
    //         //       color: kPrimaryColor,
    //         //     ),
    //         //   ),
    //         // ),
    //         // display orders
    //       ],
    //     ),
    //     Container(
    //       height: 300,
    //       padding: const EdgeInsets.only(
    //           left: kDefaultPadding / 10, right: 0, top: kDefaultPadding),
    //       child: ListView.builder(
    //         itemCount: list.length,
    //         itemBuilder: (context, index) {
    //           return SingleProduct(image: list[index]);
    //         },
    //       ),
    //     ),
    //   ],
    // );
  }
}
