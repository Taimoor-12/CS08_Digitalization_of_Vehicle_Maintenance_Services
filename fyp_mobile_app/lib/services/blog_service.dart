import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/constants.dart';
import 'package:fyp_mobile_app/error_handling.dart';
import 'package:fyp_mobile_app/models/blog_model.dart';
import 'package:fyp_mobile_app/utils.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class BlogService {
  Future<List<Blog>> getBlogs({required BuildContext context}) async {
    List<Blog> blogs = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/superUser/blog/findAll/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      var jsonData = jsonDecode(res.body);
      print(jsonData.length);

      for (int i = 0; i < jsonData.length; i++) {
        Blog blog = Blog.fromJson(
          jsonEncode(jsonData[i]),
        );

        blogs.add(blog);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return blogs;
  }
}
