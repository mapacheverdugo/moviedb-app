import 'package:flutter/material.dart';
import 'package:moviedb/config/theme/app_themes.dart';
import 'package:moviedb/core/constants/constants.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/presentation/widgets/movie_list_tile.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({
    super.key,
    required this.movies,
    this.onMovieTap,
    this.onBookmarkTap,
    this.onLoadMoreTap,
  });

  final List<MovieEntity> movies;
  final Function(MovieEntity)? onMovieTap;
  final Function(MovieEntity)? onBookmarkTap;
  final VoidCallback? onLoadMoreTap;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect rect) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Colors.transparent,
            Colors.transparent,
            Colors.transparent
          ],
          stops: [
            0.0,
            0.03,
            0.97,
            1.0
          ], // 10% purple, 80% transparent, 10% purple
        ).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(
                left: AppConstants.pagePadding.left -
                    AppConstants.movieListTilePadding.left,
                right: AppConstants.pagePadding.right -
                    AppConstants.movieListTilePadding.right,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MovieListTile(
                  movie: movie,
                  padding: EdgeInsets.symmetric(
                    vertical: AppConstants.movieListTilePadding.vertical / 2,
                    horizontal:
                        AppConstants.movieListTilePadding.horizontal / 2,
                  ),
                  onTap:
                      onMovieTap != null ? () => onMovieTap?.call(movie) : null,
                  onBookmarkTap: onBookmarkTap != null
                      ? () => onBookmarkTap?.call(movie)
                      : null,
                );
              },
            ),
            _buildListFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildListFooter(BuildContext context) {
    const defaultButtonPadding = AppTheme.defaultButtonPadding;

    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.pagePadding.left -
                (defaultButtonPadding.horizontal / 2),
            vertical: AppConstants.pagePadding.top,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: AppConstants.footerButtonsHeight,
                child: onLoadMoreTap != null
                    ? TextButton(
                        onPressed: onLoadMoreTap,
                        child: const Row(
                          children: [
                            Text("Load More"),
                          ],
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
