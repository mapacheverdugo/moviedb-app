import 'package:flutter/material.dart';
import 'package:moviedb/features/movies/domain/entities/movie.dart';

class MovieListTile extends StatelessWidget {
  final MovieEntity movie;

  const MovieListTile({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Row(
        children: [
          const SizedBox(
            width: 95,
            height: 120,
            child: Placeholder(),
          ),
          const SizedBox(width: 22),
          Expanded(
            child: _buildInfo(context),
          ),
        ],
      ),
    );
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
        ),
        const SizedBox(height: 5),
        Text(
          "Release date:",
          style: textTheme.titleSmall,
        ),
        Text(
          movie.releaseDate.toIso8601String(),
        ),
        const SizedBox(height: 5),
        Text(
          "Average rating:",
          style: textTheme.titleSmall,
        ),
        Text(
          movie.voteAverage.toString(),
        ),
      ],
    );
  }
}
