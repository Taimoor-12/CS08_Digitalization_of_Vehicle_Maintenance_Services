import 'dart:convert';

import 'package:flutter/material.dart';

class Blog {
  final String title;
  final String author;
  final String body;
  final String date;
  final String id;
  final String image;

  Blog(
      {required this.title,
      required this.author,
      required this.body,
      required this.date,
      required this.image,
      required this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'author': author,
      'date': date,
      'image': image,
    };
  }

  factory Blog.fromMap(Map<String, dynamic> map) {
    return Blog(
      id: map['_id'] ?? '',
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      author: map['author'] ?? '',
      date: map['date'] ?? '',
      image: map['image'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Blog.fromJson(String source) => Blog.fromMap(json.decode(source));

  Blog copyWith(
      {String? id,
      String? title,
      String? body,
      String? author,
      String? date,
      String? image}) {
    return Blog(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      author: author ?? this.author,
      date: date ?? this.date,
      image: image ?? this.image,
    );
  }
}
