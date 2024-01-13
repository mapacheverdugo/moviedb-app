import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final String authorName;
  final String? avatarUrl;
  final double? rating;
  final String content;

  const ReviewEntity({
    required this.authorName,
    required this.avatarUrl,
    required this.rating,
    required this.content,
  });

  @override
  List<Object?> get props => [
        authorName,
        avatarUrl,
        rating,
        content,
      ];
}
