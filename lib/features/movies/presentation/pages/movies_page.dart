import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/config/theme/app_themes.dart';
import 'package:moviedb/features/movies/domain/entities/movie.dart';
import 'package:moviedb/features/movies/presentation/blocs/movies_bloc/movies_bloc.dart';
import 'package:moviedb/features/movies/presentation/widgets/movie_list_tile.dart';
import 'package:moviedb/injection_container.dart';

class MoviesPage extends StatelessWidget {
  static const _padding = EdgeInsets.symmetric(
    vertical: 31,
    horizontal: 29,
  );
  static const _movieListTilePadding = EdgeInsets.symmetric(
    vertical: 9,
    horizontal: 9,
  );
  static const _footerButtonsHeight = 42.0;

  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<MoviesBloc>()..add(const GetMoviesEvent()),
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: _padding.left,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 22),
                        Text(
                          "Movie DB App",
                          style: textTheme.displaySmall,
                        ),
                        const SizedBox(height: 22),
                        Text(
                          "Find your movies",
                          style: textTheme.titleLarge,
                        ),
                        const SizedBox(height: 22),
                        Text(
                          "Categories",
                          style: textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: _buildList(),
                  ),
                ],
              ),
            ),
            _buildMainFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MoviesLoaded) {
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
                  0.1,
                  0.9,
                  1.0
                ], // 10% purple, 80% transparent, 10% purple
              ).createShader(rect);
            },
            blendMode: BlendMode.dstOut,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 31),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                      left: _padding.left - _movieListTilePadding.left,
                      right: _padding.right - _movieListTilePadding.right,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.popularMovies.length,
                    itemBuilder: (context, index) {
                      final movie = state.popularMovies[index];
                      return MovieListTile(
                        movie: movie,
                        padding: EdgeInsets.symmetric(
                          vertical: _movieListTilePadding.vertical / 2,
                          horizontal: _movieListTilePadding.horizontal / 2,
                        ),
                        onTap: () => _onMovieTap(context, movie),
                      );
                    },
                  ),
                  _buildListFooter(context),
                ],
              ),
            ),
          );
        } else if (state is MoviesError) {
          return Text(state.message);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildMainFooter() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: _padding.left,
            vertical: _padding.top,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: _footerButtonsHeight,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Row(
                    children: [
                      Text("Watch List"),
                      SizedBox(width: 8),
                      Icon(Icons.bookmark),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
            horizontal: _padding.left - (defaultButtonPadding.horizontal / 2),
            vertical: _padding.top,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: _footerButtonsHeight,
                child: TextButton(
                  onPressed: () {},
                  child: const Row(
                    children: [
                      Text("Load More"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onMovieTap(BuildContext context, MovieEntity movie) {
    Navigator.of(context).pushNamed(
      '/movie_details',
      arguments: movie,
    );
  }
}
