import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/utils.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
  required VoidCallback onFailure,
}) {
  switch (response.statusCode) {
    case 201:
      onSuccess();
      break;
    case 200:
      onSuccess();
      break;
    case 400:
      onFailure();
      showSnackBar(context, response.body);
      break;

    default:
      onFailure();
      showSnackBar(context, response.body);
      print(response.body);
  }
}
