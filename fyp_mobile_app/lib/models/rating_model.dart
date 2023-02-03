import 'dart:convert';

class Rating {
  final String userId;
  final double rating;
  final String role;
  String? review;
  Rating({
    required this.userId,
    required this.rating,
    required this.role,
    this.review,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'rating': rating,
      'review': review,
      'role': role,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      userId: map['userId'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      review: map['review'] ?? '',
      role: map['role'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) => Rating.fromMap(json.decode(source));
}
