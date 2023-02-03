import 'dart:convert';

import 'package:fyp_mobile_app/models/service_provider_model.dart';

// class Order {
//   final String id;
//   final List<ServiceProvider> products;
//   final String address;
//   final String userId;
//   final int orderedAt;
//   final int status;
//   final String orderNo;
//   final double totalPrice;
//   Order({
//     required this.id,
//     required this.products,
//     required this.address,
//     required this.userId,
//     required this.orderedAt,
//     required this.status,
//     required this.orderNo,
//     required this.totalPrice,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'products': products.map((x) => x.toMap()).toList(),
//       'address': address,
//       'userId': userId,
//       'orderedAt': orderedAt,
//       'status': status,
//       'orderNo': orderNo,
//       'totalPrice': totalPrice,
//     };
//   }
//
//   factory Order.fromMap(Map<String, dynamic> map) {
//     return Order(
//       id: map['_id'] ?? '',
//       products: List<ServiceProvider>.from(
//         map['products']?.map(
//           (x) => ServiceProvider.fromMap(
//             (x['product']),
//           ),
//         ),
//       ),
//       address: map['address'] ?? '',
//       userId: map['userId'] ?? '',
//       orderedAt: map['orderedAt']?.toInt() ?? 0,
//       status: map['status']?.toInt() ?? 0,
//       orderNo: map['orderNo'] ?? '',
//       totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
//     );
//   }
//
//   String toJson() => json.encode(toMap());
//
//   factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
// }

class Order {
  final String id;
  final String status;
  final String requestedOn;
  final double totalPrice;
  final String customerId;
  final String firstName;
  String? carName;
  String? carNumber;
  final String customerAddress;
  final String serviceName;
  final String serviceProviderId;
  String? mechanicName;
  String? mechanicPhone;
  String? mechanicEmail;
  String? customerEmail;
  Order({
    required this.id,
    required this.status,
    required this.requestedOn,
    required this.totalPrice,
    required this.customerId,
    required this.firstName,
    this.carName,
    this.carNumber,
    this.mechanicName,
    this.mechanicPhone,
    this.mechanicEmail,
    this.customerEmail,
    required this.customerAddress,
    required this.serviceName,
    required this.serviceProviderId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'requestedOn': requestedOn,
      'totalPrice': totalPrice,
      'customerId': customerId,
      'firstName': firstName,
      'carName': carName,
      'carNumber': carNumber,
      'customerAddress': customerAddress,
      'serviceName': serviceName,
      'serviceProviderId': serviceProviderId,
      'mechanicEmail': mechanicEmail,
      'mechanicPhone': mechanicPhone,
      'mechanicName': mechanicName,
      'customerEmail': customerEmail
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? '',
      status: map['status'] ?? '',
      requestedOn: map['requestedOn'] ?? '',
      totalPrice: map['servicePrice']?.toDouble() ?? 0.0,
      customerId: map['customerId'] ?? '',
      firstName: map['firstName'] ?? '',
      carName: map['carName'] ?? '',
      carNumber: map['carNumber'] ?? '',
      customerAddress: map['custAddress'] ?? '',
      serviceName: map['serviceName'] ?? '',
      serviceProviderId: map['serviceProviderId'] ?? '',
      mechanicName: '',
      mechanicPhone: '',
      mechanicEmail: '',
      customerEmail: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));

  Order copyWith({
    String? id,
    String? status,
    String? requestedOn,
    double? totalPrice,
    String? customerId,
    String? firstName,
    String? carName,
    String? carNumber,
    String? customerAddress,
    String? serviceName,
    String? serviceProviderId,
    String? mechanicName,
    String? mechanicPhone,
    String? mechanicEmail,
    String? customerEmail,
    // List<dynamic>? cart,
  }) {
    return Order(
      id: id ?? this.id,
      status: status ?? this.status,
      requestedOn: requestedOn ?? this.requestedOn,
      totalPrice: totalPrice ?? this.totalPrice,
      customerAddress: customerAddress ?? this.customerAddress,
      customerId: customerId ?? this.customerId,
      firstName: firstName ?? this.firstName,
      serviceName: serviceName ?? this.serviceName,
      serviceProviderId: serviceProviderId ?? this.serviceProviderId,
      carName: carName ?? this.carName,
      carNumber: carNumber ?? this.carNumber,
      mechanicName: mechanicName ?? this.mechanicName,
      mechanicPhone: mechanicPhone ?? this.mechanicPhone,
      mechanicEmail: mechanicEmail ?? this.mechanicEmail,
      customerEmail: customerEmail ?? this.customerEmail,
    );
  }
}
