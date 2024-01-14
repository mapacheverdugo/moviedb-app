import 'package:flutter/material.dart';
import 'package:moviedb/features/movies/domain/entities/review.dart';

class ReviewListTile extends StatelessWidget {
  final ReviewEntity review;
  final EdgeInsets padding;
  final VoidCallback? onTap;

  const ReviewListTile({
    super.key,
    required this.review,
    this.padding = EdgeInsets.zero,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return IntrinsicHeight(
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onTap: onTap,
        child: GestureDetector(
          child: Padding(
            padding: padding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipOval(
                      child: Image.network(
                        review.avatarUrl,
                        width: 44,
                        height: 44,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      _formattedRating,
                      style: textTheme.titleSmall?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildInfo(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String get _formattedRating {
    return review.rating?.toStringAsFixed(1) ?? "";
  }

  Widget _buildInfo(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          review.authorName,
          style: textTheme.titleSmall,
        ),
        const SizedBox(height: 5),
        Text(
          review.content,
        ),
      ],
    );
  }
}
