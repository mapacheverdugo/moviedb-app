import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/core/constants/constants.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/presentation/widgets/app_title.dart';
import 'package:moviedb/core/presentation/widgets/custom_search_bar.dart';
import 'package:moviedb/core/presentation/widgets/floating_watch_list_button.dart';
import 'package:moviedb/core/presentation/widgets/movies_list.dart';
import 'package:moviedb/features/movies/presentation/blocs/movies_bloc/movies_bloc.dart';
import 'package:moviedb/features/watchlist/presentation/blocs/watchlist_bloc/watchlist_bloc.dart';
import 'package:moviedb/injection_container.dart';

class MoviesPage extends StatelessWidget {
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
                      horizontal: AppConstants.pagePadding.left,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 22),
                        const AppTitle(),
                        const SizedBox(height: 22),
                        Text(
                          "Find your movies",
                          style: textTheme.titleLarge,
                        ),
                        const SizedBox(height: 18),
                        CustomSearchBar(
                          readOnly: true,
                          onFieldTap: () => _onSearchAction(context),
                          onSearchAction: (_) => _onSearchAction(context),
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
          return BlocBuilder<WatchlistBloc, WatchlistState>(
            builder: (context, __) {
              return MoviesList(
                movies: state.popularMovies,
                onMovieTap: (movie) => _onMovieTap(context, movie),
                onBookmarkTap: (movie) => _onBookmarkTap(context, movie),
                onLoadMoreTap: () => _onLoadMoreTap(context),
              );
            },
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
            horizontal: AppConstants.pagePadding.left,
            vertical: AppConstants.pagePadding.top,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: AppConstants.footerButtonsHeight,
                child: FloatingWatchListButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSearchAction(BuildContext context) {
    Navigator.of(context).pushNamed('/search');
  }

  void _onMovieTap(BuildContext context, MovieEntity movie) {
    Navigator.of(context).pushNamed(
      '/movie_details',
      arguments: movie,
    );
  }

  void _onBookmarkTap(BuildContext context, MovieEntity movie) {
    context.read<WatchlistBloc>().add(ToggleWatchlistItem(movie: movie));
  }

  void _onLoadMoreTap(BuildContext context) {
    context.read<MoviesBloc>().add(const LoadMoreMoviesEvent());
  }
}
