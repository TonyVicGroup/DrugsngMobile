import 'package:equatable/equatable.dart';

class Reviewer extends Equatable {
  final int id;
  final String fullName;
  final String email;

  const Reviewer({
    required this.id,
    required this.fullName,
    required this.email,
  });

  String get avatar {
    final names = fullName.split(' ');
    return '${names[0][0]}${names.length > 1 ? names[1][0] : ''}'.toUpperCase();
  }

  factory Reviewer.fromJson(Map json) => Reviewer(
    id: json['id'],
    fullName: json['fullName'],
    email: json['emailAddress'],
  );

  @override
  List<Object?> get props => [id, fullName, email];
}

class ProductReview extends Equatable {
  final int productId;
  final String productName;
  final String reviewComment;
  final int rating;
  final Reviewer reviewer;

  const ProductReview({
    required this.productId,
    required this.productName,
    required this.reviewComment,
    required this.rating,
    required this.reviewer,
  });

  factory ProductReview.fromJson(Map json) => ProductReview(
    // id: json[_idKey],
    // userId: json[_userIdKey],
    // userName: json[_userNameKey],
    // reviewComment: json[_reviewCommentKey],
    productId: json['productId'],
    productName: json['productName'],
    reviewComment: json['reviewComment'],
    rating: json['rating'],
    reviewer: Reviewer.fromJson(json['user']),
  );

  @override
  List<Object?> get props => [
    productId,
    productName,
    reviewComment,
    rating,
    reviewer,
  ];
}
