class ReviewModel {
  final String userId;
  final String comment;
  final int rating;

  ReviewModel({
    required this.userId,
    required this.comment,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "comment": comment,
      "rating": rating,
    };
  }

  static ReviewModel fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      userId: map["userId"] ?? '',
      comment: map["comment"] ?? '',
      rating: map["rating"] ?? 0,
    );
  }
}
