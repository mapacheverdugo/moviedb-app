import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moviedb/features/movies/domain/entities/movie.dart';
import 'package:moviedb/features/movies/presentation/widgets/movie_poster.dart';

class MovieListTile extends StatelessWidget {
  final MovieEntity movie;
  final EdgeInsets padding;
  final VoidCallback? onTap;

  const MovieListTile({
    super.key,
    required this.movie,
    this.padding = EdgeInsets.zero,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Hero(
                    tag: "poster-${movie.id}",
                    child: MoviePoster(
                      url: movie.posterUrl,
                    ),
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

  String? get _formattedReleaseDate {
    final releaseDate = movie.releaseDate;
    if (releaseDate == null) {
      return null;
    }
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(releaseDate);
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
          _formattedReleaseDate ?? "NA",
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
