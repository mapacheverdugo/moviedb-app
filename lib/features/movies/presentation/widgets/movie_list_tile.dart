import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moviedb/features/movies/domain/entities/movie.dart';

class MovieListTile extends StatelessWidget {
  final MovieEntity movie;
  final EdgeInsets padding;

  const MovieListTile({
    super.key,
    required this.movie,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: InkWell(
        onTap: () {},
        child: GestureDetector(
          onLongPress: () {},
          child: Padding(
            padding: padding,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    movie.posterUrl,
                    width: 95,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 22),
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

  String get _formattedReleaseDate {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(movie.releaseDate);
  }

  String get _formattedAverageRating {
    return movie.voteAverage.toStringAsFixed(1);
  }

  Widget _buildInfo(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Title:",
          style: textTheme.titleSmall,
        ),
        Text(
          movie.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 5),
        Text(
          "Release date:",
          style: textTheme.titleSmall,
        ),
        Text(
          _formattedReleaseDate,
        ),
        const SizedBox(height: 5),
        Text(
          "Average rating:",
          style: textTheme.titleSmall,
        ),
        Text(
          _formattedAverageRating,
        ),
      ],
    );
  }
}
