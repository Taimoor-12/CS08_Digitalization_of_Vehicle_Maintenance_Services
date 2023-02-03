import 'dart:convert';

class User {
  String id;
  // final String name;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String address;
  String? verified;
  String role;
  final String token;
  List<int>? bufferImage;
  final String number;
  String? image;
  // List<dynamic>? cart;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role,
    required this.address,
    this.verified,
    required this.number,
    required this.token,
    // this.cart,
    this.image,
    this.bufferImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      'password': password,
      'role': role,
      'address': address,
      'token': token,
      'number': number,
      'verified': verified,
      // 'cart': cart,
      'image': image,
      'bufferImage': bufferImage,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      firstName: map['firstname'] ?? '',
      lastName: map['lastname'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      role: map['role'] ?? '',
      verified: map['verified'] ?? '',
      address: map['address'] ?? '',
      token: map['token'] ?? '',
      number: map['number'] ?? '',
      image: map['image'] ?? '',
      // cart: List<Map<String, dynamic>>.from(
      //   map['cart']?.map(
      //     (x) => Map<String, dynamic>.from(x),
      //   ),
      // ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    // String? name,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? address,
    String? role,
    String? token,
    String? number,
    String? verified,
    List<int>? bufferImage,
    String? image,
    // List<dynamic>? cart,
  }) {
    return User(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password,
        address: address ?? this.address,
        role: role ?? this.role,
        token: token ?? this.token,
        verified: verified ?? this.verified,
        number: number ?? this.number,
        // cart: cart ?? this.cart,
        image: image ?? this.image,
        bufferImage: bufferImage ?? this.bufferImage);
  }
}
