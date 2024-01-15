import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/core/constants/constants.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/features/movies/presentation/blocs/movie_details/movie_details_bloc.dart';
import 'package:moviedb/features/movies/presentation/widgets/movie_backdrop.dart';
import 'package:moviedb/features/movies/presentation/widgets/movie_genres_chips.dart';
import 'package:moviedb/features/movies/presentation/widgets/movie_poster.dart';

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  static const _appbarHeight = 56.0;
  static const _posterHeight = 120.0;
  static const _posterWidth = 95.0;
  static const _backdropHeight = 210.0;
  static const _chipsHeight = 32.0;
  static const _chipsSpacing = 18.0;

  final bottomHeight = 60;
  final extraRadius = 5;

  final BuildContext context;
  final MovieEntity baseMovie;
  final PreferredSizeWidget tabBar;

  HeaderDelegate({
    required this.context,
    required this.baseMovie,
    required this.tabBar,
  });

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    final imageTop =
        -shrinkOffset.clamp(0.0, maxExtent - minExtent - bottomHeight);

    final double clowsingRate = (shrinkOffset == 0
            ? 0.0
            : (shrinkOffset / (maxExtent - minExtent - bottomHeight)))
        .clamp(0, 1);

    final double opacity = shrinkOffset == minExtent
        ? 0
        : 1 - (shrinkOffset.clamp(minExtent, minExtent + 30) - minExtent) / 30;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final mqWidth = MediaQuery.of(context).size.width;

    return Container(
      color: colorScheme.background,
      width: mqWidth,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: colorScheme.background,
              child: tabBar,
            ),
          ),
          Positioned(
            top: _backdropHeight + _posterHeight / 2 + imageTop,
            left: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: _chipsSpacing),
                BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
                  builder: (context, state) {
                    if (state is MovieDetailsLoaded) {
                      return MovieGenresChips(
                        genres: state.movieDetails.genres,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppConstants.pagePadding.horizontal / 2,
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                const SizedBox(height: _chipsSpacing),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 1 - opacity,
              child: AppBar(
                automaticallyImplyLeading: false,
                leading: Container(),
                leadingWidth: 20,
                title: Text(baseMovie.title),
              ),
            ),
          ),
          Positioned(
            bottom:
                _chipsSpacing * 2 + _chipsHeight + tabBar.preferredSize.height,
            child: Container(
              width: mqWidth,
              height: _posterHeight,
              padding: EdgeInsets.symmetric(
                horizontal: AppConstants.pagePadding.horizontal / 2,
              ),
              child: Row(
                children: [
                  Transform.scale(
                    scale: 1 - (clowsingRate / 3),
                    alignment: Alignment.topLeft,
                    child: Opacity(
                      opacity: opacity,
                      child: Hero(
                        tag: "poster-${baseMovie.tmdbId}",
                        child: MoviePoster(
                          url: baseMovie.posterUrl,
                          width: _posterWidth,
                          height: _posterHeight,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Column(
                      children: [
                        const Spacer(),
                        const SizedBox(height: 12),
                        Flexible(
                          child: Opacity(
                            opacity: opacity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  baseMovie.title,
                                  maxLines: 2,
                                  style: textTheme.titleLarge,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: imageTop,
            left: 0,
            right: 0,
            child: SizedBox(
              height: _backdropHeight,
              child: Opacity(
                opacity: opacity,
                child: MovieBackdrop(
                  url: baseMovie.backdropUrl,
                  height: _backdropHeight,
                ),
              ),
            ),
          ),
        ].reversed.toList(),
      ),
    );
  }

  @override
  double get maxExtent =>
      _backdropHeight +
      _posterHeight / 2 +
      tabBar.preferredSize.height +
      (_chipsSpacing * 2) +
      _chipsHeight;

  @override
  double get minExtent {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double topPadding = mediaQuery.padding.top;
    return _appbarHeight + topPadding + tabBar.preferredSize.height;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
