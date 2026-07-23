import 'package:equatable/equatable.dart';

class Review extends Equatable {
  static const String _idKey = "id";
  static const String _userIdKey = "userId";
  static const String _productIdKey = "productId";
  static const String _doctorUserIdKey = "doctorUserId";
  static const String _reviewCommentKey = "reviewComment";
  static const String _ratingStarKey = "ratingStar";
  static const String _isPublicKey = "isPublic";
  static const String _userKey = "user";
  static const String _doctorUserKey = "doctorUser";
  static const String _fullNameKey = "fullName";

  final int id;
  final int userId;
  final int productId;
  final int? doctorUserId;
  final String reviewComment;
  final double ratingStar;
  final bool isPublic;
  final String userName;
  final String doctorUserName;

  String get avatar {
    if (userName.isEmpty) return "";
    final names = userName.split(' ');
    return '${names[0][0]}${names.length > 1 ? names[1][0] : ''}'.toUpperCase();
  }

  const Review({
    required this.id,
    required this.userId,
    required this.productId,
    required this.doctorUserId,
    required this.reviewComment,
    required this.ratingStar,
    required this.isPublic,
    required this.userName,
    required this.doctorUserName,
  });

  factory Review.fromJson(Map json) {
    num ratingStar = json["rating"];
    return Review(
      id: json[_idKey] ?? 0,
      userId: json[_userIdKey],
      productId: json[_productIdKey] ?? 0,
      doctorUserId: json[_doctorUserIdKey] ?? 0,
      reviewComment: json[_reviewCommentKey],
      ratingStar: ratingStar.toDouble(),
      isPublic: json[_isPublicKey] ?? true,
      userName: json[_userKey]?[_fullNameKey] ?? json['name'] ?? "",
      doctorUserName: json[_doctorUserKey]?[_fullNameKey] ?? "",
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    productId,
    doctorUserId,
    reviewComment,
    ratingStar,
    isPublic,
    userName,
    doctorUserName,
  ];
}
