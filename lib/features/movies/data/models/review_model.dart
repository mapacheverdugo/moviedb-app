import 'package:moviedb/features/movies/domain/entities/review.dart';

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.authorName,
    required super.avatarUrl,
    required super.rating,
    required super.content,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      authorName: json['author_details']['name'],
      avatarUrl: json['author_details']['avatar_path'],
      rating: (json['author_details']['rating'] as num?)?.toDouble(),
      content: json['content'],
    );
  }
}
