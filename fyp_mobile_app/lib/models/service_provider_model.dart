import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fyp_mobile_app/providers/swapCartButtonProvider.dart';
import 'rating_model.dart';
import 'rating_model.dart';

// class ServiceProvider {
//   final String id;
//   final String name;
//   final String category;
//   final int price;
//   final String brandName;
//   final String address;
//   List<int>? bufferImage;
//   double? average;
//   final List<Rating>? rating;
//   // bool addToCart;
//   ServiceProvider({
//     required this.id,
//     required this.name,
//     required this.category,
//     required this.price,
//     required this.brandName,
//     required this.address,
//     this.bufferImage,
//     this.rating,
//     this.average,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'category': category,
//       'price': price,
//       'brandName': brandName,
//       'address': address,
//       'bufferImage': bufferImage,
//       'rating': rating,
//       'average': average,
//
//       // 'rating': rating,
//     };
//   }
//
//   factory ServiceProvider.fromMap(Map<String, dynamic> map) {
//     return ServiceProvider(
//       id: map['id'] ?? '',
//       name: map['name'] ?? '',
//       category: map['category'] ?? '',
//       price: map['price']?.toInt() ?? 0,
//       // bufferImage: List<int>.from(map['image']?.map((x) => List<int>.from(x))),
//       brandName: map['brandName'] ?? '',
//       address: map['address'] ?? '',
//       average: map['aver']?.toDouble() ?? 0.0,
//       rating: map['rating'] != null
//           ? List<Rating>.from(
//               map['rating']?.map(
//                 (x) => Rating.fromMap(x),
//               ),
//             )
//           : null,
//     );
//   }
//
//   String toJson() => json.encode(toMap());
//
//   factory ServiceProvider.fromJson(String source) =>
//       ServiceProvider.fromMap(json.decode(source));
//
//   // ServiceProvider copyWith({
//   //   String? name,
//   //   String? category,
//   //   int? price,
//   //   String? brandName,
//   //   String? address,
//   //   List<int>? bufferImage,
//   //   bool? isSelected,
//   // }) {
//   //   return ServiceProvider(
//   //     name ?? this.name,
//   //     category ?? this.category,
//   //     price ?? this.price,
//   //     brandName ?? this.brandName,
//   //     address ?? this.address,
//   //     bufferImage ?? this.bufferImage,
//   //     isSelected ?? this.isSelected,
//   //   );
//   // }
// }

class ServiceProvider {
  final String id;
  final String name;
  final String serviceType;
  final int price;
  final String description;
  final String timeRequired;
  final String where;
  final String providerName;
  final String email;
  final String number;
  final List<Rating>? rating;
  double? average;
  final String image;
  final String address;
  // double? average;
  // final List<Rating>? rating;
  // bool addToCart;
  ServiceProvider({
    required this.id,
    required this.name,
    required this.serviceType,
    required this.price,
    required this.description,
    required this.timeRequired,
    required this.where,
    required this.providerName,
    required this.email,
    required this.number,
    required this.image,
    required this.address,
    // this.bufferImage,
    this.rating,
    this.average,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'serviceType': serviceType,
      'price': price,
      'description': description,
      'timeRequired': timeRequired,
      'where': where,
      'providerName': providerName,
      'email': email,
      'number': number,
      'rating': rating,
      'address': address,

      'image': image,
      // 'rating': rating,
      'average': average,

      // 'rating': rating,
    };
  }

  factory ServiceProvider.fromMap(Map<String, dynamic> map) {
    return ServiceProvider(
      id: map['serviceProviderId'] ?? '',
      name: map['name'] ?? '',
      serviceType: map['serviceType'] ?? '',
      price: map['price']?.toInt() ?? 0,
      // bufferImage: List<int>.from(map['image']?.map((x) => List<int>.from(x))),
      description: map['description'] ?? '',
      timeRequired: map['timeRequired'] ?? '',
      where: map['where'] ?? '',
      providerName: '',
      email: map['email'] ?? '',
      number: map['mobile'] ?? '',
      image: map['image'] ?? '',
      address: map['address'] ?? '',
      average: map['aver']?.toDouble() ?? 0.0,
      rating: map['rating'] != null
          ? List<Rating>.from(
              map['rating']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceProvider.fromJson(String source) =>
      ServiceProvider.fromMap(json.decode(source));

// ServiceProvider copyWith({
//   String? name,
//   String? category,
//   int? price,
//   String? brandName,
//   String? address,
//   List<int>? bufferImage,
//   bool? isSelected,
// }) {
//   return ServiceProvider(
//     name ?? this.name,
//     category ?? this.category,
//     price ?? this.price,
//     brandName ?? this.brandName,
//     address ?? this.address,
//     bufferImage ?? this.bufferImage,
//     isSelected ?? this.isSelected,
//   );
// }
}
