import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/features/movies/presentation/widgets/movie_poster.dart';
import 'package:moviedb/features/watchlist/presentation/blocs/watchlist_bloc/watchlist_bloc.dart';

class MovieListTile extends StatelessWidget {
  final MovieEntity movie;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;

  const MovieListTile({
    super.key,
    required this.movie,
    this.padding = EdgeInsets.zero,
    this.onTap,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    context.read<WatchlistBloc>().add(CheckWatchlistItem(movie: movie));

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
                    tag: "poster-${movie.tmdbId}",
                    child: MoviePoster(
                      url: movie.posterUrl,
                    ),
                  ),
                ),
                const SizedBox(width: 22),
                Expanded(
                  child: _buildInfo(context),
                ),
                const SizedBox(width: 22),
                _buildTrailing(context),
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

  Widget _buildTrailing(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (onBookmarkTap != null)
          GestureDetector(
            onTap: onBookmarkTap,
            child: Icon(
              movie.isWatchlisted
                  ? Icons.bookmark_added_rounded
                  : Icons.bookmark_rounded, // TODO: change for Bootstrap Icons
              color: movie.isWatchlisted
                  ? colorScheme.primary
                  : colorScheme.onBackground,
            ),
          ),
      ],
    );
  }
}
