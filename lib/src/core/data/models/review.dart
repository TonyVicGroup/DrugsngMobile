class Review {
  static const String _idKey = "id";
  static const String _userIdKey = "userId";
  static const String _userNameKey = "userName";
  static const String _reviewCommentKey = "reviewComment";

  final int id;
  final int userId;
  final String userName;
  final String reviewComment;

  Review({
    required this.id,
    required this.userId,
    required this.userName,
    required this.reviewComment,
  });

  factory Review.fromJson(Map json) {
    return Review(
      id: json[_idKey],
      userId: json[_userIdKey],
      userName: json[_userNameKey],
      reviewComment: json[_reviewCommentKey],
    );
  }
}
