import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/error_handling.dart';
import 'package:fyp_mobile_app/models/order_model.dart';
import 'package:fyp_mobile_app/models/service_provider_model.dart';
import 'package:fyp_mobile_app/models/user_model.dart';
import 'package:fyp_mobile_app/providers/user_provider.dart';
import 'package:fyp_mobile_app/screens/components/bottom_bar.dart';
import 'package:fyp_mobile_app/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class OrderService {
  // void placeOrder({
  //   required BuildContext context,
  //   required String address,
  //   required double totalSum,
  //   required String phone,
  //   required String productID,
  // }) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //   try {
  //     http.Response res = await http.post(Uri.parse('$uri/api/users/order'),
  //         headers: {
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           'x-auth-token': userProvider.user.token,
  //         },
  //         body: jsonEncode({
  //           'productID': productID,
  //           'address': address,
  //           'totalPrice': totalSum,
  //           'phone': phone,
  //         }));
  //
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onFailure: () {},
  //       onSuccess: () {
  //         showSnackBar(context, 'Your order has been placed!');
  //         // User user = userProvider.user.copyWith(
  //         //   cart: [],
  //         // );
  //         // userProvider.setUserFromModel(user);
  //         Timer(Duration(seconds: 2), () {
  //           Navigator.pushNamedAndRemoveUntil(
  //               context, BottomBar.routeName, (route) => false);
  //         });
  //       },
  //     );
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  // }

  void placeOrder(
      {required BuildContext context,
      required String address,
      required double totalSum,
      // required String phone,
      required String productID,
      required String carName,
      required String carNumber,
      required String serviceName}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$uri4/order/addOrder'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-access-token': userProvider.user.token,
          },
          body: jsonEncode({
            'serviceProviderId': productID,
            'customerId': userProvider.user.id,
            'firstName': userProvider.user.firstName,
            'custAddress': address,
            'serviceName': serviceName,
            'servicePrice': totalSum,
            'carName': carName,
            'carNumber': carNumber,
            'email': userProvider.user.email,
            // 'phone': phone,
          }));

      httpErrorHandle(
        response: res,
        context: context,
        onFailure: () {},
        onSuccess: () {
          showSnackBar(context, 'Your order has been placed!');
          // User user = userProvider.user.copyWith(
          //   cart: [],
          // );
          // userProvider.setUserFromModel(user);
          Timer(Duration(seconds: 2), () {
            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
          });
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // void placeOrderPhone({
  //   required BuildContext context,
  //   required String address,
  //   required double totalSum,
  //   required String phone,
  //   required String productID,
  // }) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //   try {
  //     http.Response res =
  //         await http.post(Uri.parse('$uri/api/users/orderPhone'),
  //             headers: {
  //               'Content-Type': 'application/json; charset=UTF-8',
  //               'x-auth-token': userProvider.user.token,
  //             },
  //             body: jsonEncode({
  //               'productID': productID,
  //               'address': address,
  //               'totalPrice': totalSum,
  //               'phone': phone,
  //             }));
  //
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onFailure: () {},
  //       onSuccess: () {
  //         showSnackBar(context, 'Your order has been placed!');
  //         // User user = userProvider.user.copyWith(
  //         //   cart: [],
  //         // );
  //         // userProvider.setUserFromModel(user);
  //         Timer(Duration(seconds: 2), () {
  //           Navigator.pushNamedAndRemoveUntil(
  //               context, BottomBar.routeName, (route) => false);
  //         });
  //       },
  //     );
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  // }

  void placeOrderPhone({
    required BuildContext context,
    required String address,
    required double totalSum,
    // required String phone,
    required String productID,
    required String carName,
    required String carNumber,
    required String serviceName,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res =
          await http.post(Uri.parse('$uri4/order/addOrderPhone'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-access-token': userProvider.user.token,
              },
              body: jsonEncode({
                'serviceProviderId': productID,
                'customerId': userProvider.user.id,
                'firstName': userProvider.user.firstName,
                'custAddress': address,
                'serviceName': serviceName,
                'servicePrice': totalSum,
                'carName': carName,
                'carNumber': carNumber,
              }));

      httpErrorHandle(
        response: res,
        context: context,
        onFailure: () {},
        onSuccess: () {
          showSnackBar(context, 'Your order has been placed!');
          // User user = userProvider.user.copyWith(
          //   cart: [],
          // );
          // userProvider.setUserFromModel(user);
          Timer(Duration(seconds: 2), () {
            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
          });
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Future<List<Order>> fetchMyOrders({
  //   required BuildContext context,
  // }) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //   List<Order> orderList = [];
  //   try {
  //     http.Response res =
  //         await http.get(Uri.parse('$uri/api/users/fetchOrders'), headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'x-auth-token': userProvider.user.token,
  //     });
  //
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onFailure: () {},
  //       onSuccess: () {
  //         for (int i = 0; i < jsonDecode(res.body).length; i++) {
  //           orderList.add(
  //             Order.fromJson(
  //               jsonEncode(
  //                 jsonDecode(res.body)[i],
  //               ),
  //             ),
  //           );
  //         }
  //       },
  //     );
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  //   return orderList;
  // }

  Future<List<Order>> fetchMyOrders({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res = await http.get(
          Uri.parse('$uri2/customer/order/findOrders/${userProvider.user.id}'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-access-token': userProvider.user.token,
          });
      if (jsonDecode(res.body)['message'] == 'No Orders') {
        return [];
      }
      //print(jsonDecode(res.body)['orders'][1]['mechanicId']);
      // print(jsonDecode(res.body)['orders'].length);
      for (int i = 0; i < jsonDecode(res.body)['orders'].length; i++) {
        // orderList.add(
        //   Order.fromJson(
        //     jsonEncode(
        //       jsonDecode(res.body)['orders'][i],
        //     ),
        //   ),
        // );
        Order order = Order.fromJson(
          jsonEncode(
            jsonDecode(res.body)['orders'][i],
          ),
        );

        if (jsonDecode(res.body)['orders'][i]['mechanicId'] != null) {
          http.Response res1 = await http.get(
              Uri.parse(
                  '$uri5/mechanic/account/mechanicDetail/${jsonDecode(res.body)['orders'][i]['mechanicId']}'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              });
          order = order.copyWith(
            mechanicEmail: jsonDecode(res1.body)['email'],
            mechanicPhone: jsonDecode(res1.body)['mobile'],
            mechanicName: jsonDecode(res1.body)['firstname'] +
                " " +
                jsonDecode(res1.body)['lastname'],
          );
          orderList.add(order);
        } else {
          orderList.add(order);
        }
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    // print(orderList);
    return orderList;
  }

  // Future<List<Order>> fetchMyOrdersPhone({
  //   required BuildContext context,
  // }) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //   List<Order> orderList = [];
  //   try {
  //     http.Response res = await http
  //         .get(Uri.parse('$uri/api/users/fetchOrdersPhone'), headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'x-auth-token': userProvider.user.token,
  //     });
  //
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onFailure: () {},
  //       onSuccess: () {
  //         for (int i = 0; i < jsonDecode(res.body).length; i++) {
  //           orderList.add(
  //             Order.fromJson(
  //               jsonEncode(
  //                 jsonDecode(res.body)[i],
  //               ),
  //             ),
  //           );
  //         }
  //       },
  //     );
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  //   return orderList;
  // }

  Future<List<Order>> fetchMyOrdersPhone({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res = await http.get(
          Uri.parse(
              '$uri2/customer/order/findOrdersPhone/${userProvider.user.id}'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-access-token': userProvider.user.token,
          });

      if (jsonDecode(res.body)['message'] == 'No Orders') {
        return [];
      }
      //print(jsonDecode(res.body)['orders'][1]['mechanicId']);
      for (int i = 0; i < jsonDecode(res.body)['orders'].length; i++) {
        // orderList.add(
        //   Order.fromJson(
        //     jsonEncode(
        //       jsonDecode(res.body)['orders'][i],
        //     ),
        //   ),
        // );
        Order order = Order.fromJson(
          jsonEncode(
            jsonDecode(res.body)['orders'][i],
          ),
        );

        if (jsonDecode(res.body)['orders'][i]['mechanicId'] != null) {
          http.Response res1 = await http.get(
              Uri.parse(
                  '$uri5/mechanic/account/mechanicDetail/${jsonDecode(res.body)['orders'][i]['mechanicId']}'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              });
          order = order.copyWith(
            mechanicEmail: jsonDecode(res1.body)['email'],
            mechanicPhone: jsonDecode(res1.body)['mobile'],
            mechanicName: jsonDecode(res1.body)['firstname'] +
                " " +
                jsonDecode(res1.body)['lastname'],
          );
          orderList.add(order);
        } else {
          orderList.add(order);
        }
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    // print(orderList);
    return orderList;
  }
}
