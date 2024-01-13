import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moviedb/features/movies/domain/entities/movie.dart';
import 'package:moviedb/features/movies/presentation/blocs/movie_details/movie_details_bloc.dart';
import 'package:moviedb/features/movies/presentation/widgets/movie_genres_chips.dart';
import 'package:moviedb/features/movies/presentation/widgets/movie_poster.dart';
import 'package:moviedb/injection_container.dart';

class MovieDetailsPage extends StatelessWidget {
  static const _posterHeight = 120.0;
  static const _posterWidth = 95.0;
  static const _backdropHeight = 210.0;

  static const _padding = EdgeInsets.symmetric(
    vertical: 31,
    horizontal: 29,
  );
  static const _footerButtonsHeight = 42.0;

  const MovieDetailsPage({
    super.key,
    required this.baseMovie,
  });

  final MovieEntity baseMovie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<MovieDetailsBloc>()
          ..add(GetMovieDetailsEvent(movieId: baseMovie.id)),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 18),
                  _buildInfo(context),
                  SizedBox(height: _padding.vertical + _footerButtonsHeight),
                ],
              ),
            ),
            _buildFooter(context),
          ],
        ),
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

    return Column(
      children: [
        SizedBox(
          height: _backdropHeight + (_posterHeight / 2),
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
                  height: _backdropHeight,
                  width: double.infinity,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: _posterHeight,
                  padding:
                      EdgeInsets.symmetric(horizontal: _padding.horizontal / 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Hero(
                        tag: "poster-${baseMovie.id}",
                        child: MoviePoster(
                          url: baseMovie.posterUrl,
                          width: _posterWidth,
                          height: _posterHeight,
                        ),
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
        ),
        const SizedBox(height: 18),
        BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
          builder: (context, state) {
            if (state is MovieDetailsLoaded) {
              return MovieGenresChips(
                genres: state.movieDetails.genres,
                padding: EdgeInsets.symmetric(
                  horizontal: _padding.horizontal / 2,
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        const SizedBox(height: 18),
      ],
    );
  }

  Widget _buildInfo(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _padding.horizontal / 2,
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

  Widget _buildFooter(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: _padding.left,
            vertical: _padding.top,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: _footerButtonsHeight,
                child: ElevatedButton(
                  onPressed: () => _onBackTap(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.tertiary,
                    foregroundColor: colorScheme.onTertiary,
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back),
                      SizedBox(width: 8),
                      Text("Back"),
                      SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: _footerButtonsHeight,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                  ),
                  child: const Icon(Icons.bookmark),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onBackTap(BuildContext context) {
    Navigator.of(context).pop();
  }
}
