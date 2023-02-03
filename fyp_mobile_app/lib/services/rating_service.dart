import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/error_handling.dart';
import 'package:fyp_mobile_app/models/service_provider_model.dart';
import 'package:fyp_mobile_app/providers/user_provider.dart';
import 'package:fyp_mobile_app/screens/components/bottom_bar.dart';
import 'package:fyp_mobile_app/utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class RatingService {
  // void rateProduct({
  //   required BuildContext context,
  //   required String productID,
  //   required double rating,
  //   required String role,
  //   String? review,
  // }) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //
  //   try {
  //     http.Response res = await http.post(
  //       Uri.parse('$uri/api/services/rate-product'),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'x-auth-token': userProvider.user.token,
  //       },
  //       body: jsonEncode({
  //         'id': productID,
  //         'rating': rating,
  //         'role': role,
  //         'review': review,
  //       }),
  //     );
  //
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onFailure: () {},
  //       onSuccess: () {
  //         Navigator.pushNamedAndRemoveUntil(
  //             context, BottomBar.routeName, (route) => false);
  //       },
  //     );
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  // }

  void rateProduct({
    required BuildContext context,
    required String productID,
    required double rating,
    required String role,
    String? review,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri2/customer/rating/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-access-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': productID,
          'rating': rating,
          'role': role,
          'review': review,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onFailure: () {},
        onSuccess: () {
          Navigator.pushNamedAndRemoveUntil(
              context, BottomBar.routeName, (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // void rateProductPhone({
  //   required BuildContext context,
  //   required String productID,
  //   required double rating,
  //   required String role,
  //   String? review,
  // }) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //
  //   try {
  //     http.Response res = await http.post(
  //       Uri.parse('$uri/api/services/rate-productPhone'),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         'x-auth-token': userProvider.user.token,
  //       },
  //       body: jsonEncode({
  //         'id': productID,
  //         'rating': rating,
  //         'role': role,
  //         'review': review,
  //       }),
  //     );
  //
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onFailure: () {},
  //       onSuccess: () {
  //         Navigator.pushNamedAndRemoveUntil(
  //             context, BottomBar.routeName, (route) => false);
  //       },
  //     );
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  // }

  void rateProductPhone({
    required BuildContext context,
    required String productID,
    required double rating,
    required String role,
    String? review,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri2/customer/rating/rate-productPhone'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-access-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': productID,
          'rating': rating,
          'role': role,
          'review': review,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onFailure: () {},
        onSuccess: () {
          Navigator.pushNamedAndRemoveUntil(
              context, BottomBar.routeName, (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
