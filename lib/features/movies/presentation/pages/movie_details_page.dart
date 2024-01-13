import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moviedb/features/movies/domain/entities/movie.dart';
import 'package:moviedb/features/movies/presentation/widgets/movie_poster.dart';

class MovieDetailsPage extends StatelessWidget {
  final MovieEntity baseMovie;

  const MovieDetailsPage({
    super.key,
    required this.baseMovie,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 18),
          _buildInfo(context),
        ],
      ),
    );
  }

  String get _formattedReleaseDate {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(baseMovie.releaseDate);
  }

  String get _formattedAverageRating {
    return baseMovie.voteAverage.toStringAsFixed(1);
  }

  Widget _buildHeader(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 270,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            child: Image.network(
              baseMovie.backdropUrl,
              fit: BoxFit.cover,
              height: 210,
              width: double.infinity,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 120,
              padding: const EdgeInsets.symmetric(horizontal: 29),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MoviePoster(
                    url: baseMovie.posterUrl,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              baseMovie.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 29,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Overviews:",
            style: textTheme.titleSmall,
          ),
          const SizedBox(height: 5),
          Text(baseMovie.overview),
          const SizedBox(height: 12),
          Text(
            "Release Date:",
            style: textTheme.titleSmall,
          ),
          Text(_formattedReleaseDate),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Average Rating:",
                      style: textTheme.titleSmall,
                    ),
                    Text(
                      _formattedAverageRating,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rate Count:",
                      style: textTheme.titleSmall,
                    ),
                    Text(
                      baseMovie.voteCount.toString(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
