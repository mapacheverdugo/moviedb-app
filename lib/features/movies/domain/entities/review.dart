import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'review.g.dart';

@Embedded(ignore: {'props'})
class ReviewEntity extends Equatable {
  final String authorName;
  final String authorUsername;
  final String avatarUrl;
  final double? rating;
  final String content;

  const ReviewEntity({
    this.authorName = "",
    this.authorUsername = "",
    this.avatarUrl = "",
    this.rating,
    this.content = "",
  });

  @override
  List<Object?> get props => [
        authorName,
        authorUsername,
        avatarUrl,
        rating,
        content,
      ];
}
