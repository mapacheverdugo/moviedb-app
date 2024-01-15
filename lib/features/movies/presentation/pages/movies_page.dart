import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/core/constants/constants.dart';
import 'package:moviedb/core/constants/enums.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/presentation/widgets/app_title.dart';
import 'package:moviedb/core/presentation/widgets/custom_search_bar.dart';
import 'package:moviedb/core/presentation/widgets/default_loading_indicator.dart';
import 'package:moviedb/core/presentation/widgets/floating_watch_list_button.dart';
import 'package:moviedb/core/presentation/widgets/movies_list.dart';
import 'package:moviedb/features/movies/presentation/blocs/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:moviedb/features/movies/presentation/blocs/selected_category_cubit/selected_category_cubit.dart';
import 'package:moviedb/features/movies/presentation/blocs/top_movies_bloc/top_movies_bloc.dart';
import 'package:moviedb/features/movies/presentation/widgets/movies_categories_chips.dart';
import 'package:moviedb/features/watchlist/presentation/blocs/watchlist_bloc/watchlist_bloc.dart';
import 'package:moviedb/injection_container.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                sl<PopularMoviesBloc>()..add(const GetPopularMoviesEvent()),
          ),
          BlocProvider(
            create: (context) =>
                sl<TopMoviesBloc>()..add(const GetTopMoviesEvent()),
          ),
          BlocProvider(
            create: (context) => SelectedCategoryCubit(),
          ),
        ],
        child: Stack(
          children: [
            SafeArea(
              bottom: false,
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
                        const SizedBox(height: 18),
                        BlocBuilder<SelectedCategoryCubit, MoviesCategory>(
                          builder: (context, state) {
                            return MoviesCategoriesChips(
                              selected: state,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<SelectedCategoryCubit, MoviesCategory>(
                    builder: (context, state) {
                      return Expanded(
                        child: PageTransitionSwitcher(
                          transitionBuilder: (
                            Widget child,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation,
                          ) {
                            return FadeThroughTransition(
                              animation: animation,
                              secondaryAnimation: secondaryAnimation,
                              fillColor: Colors.transparent,
                              child: child,
                            );
                          },
                          child: [
                            _buildPopularList(),
                            _buildTopList(),
                          ][state.index],
                        ),
                      );
                    },
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

  Widget _buildPopularList() {
    return BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
      builder: (context, state) {
        final loadedList = BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, __) {
            return MoviesList(
              padding: const EdgeInsets.symmetric(vertical: 30),
              movies: state.movies,
              onMovieTap: (movie) => _onMovieTap(context, movie),
              onBookmarkTap: (movie) => _onBookmarkTap(context, movie),
              onLoadMoreTap: () => _onLoadMorePopularTap(context),
            );
          },
        );

        if (state is PopularMoviesLoading) {
          return const Center(
            child: DefaultLoadingIndicator(),
          );
        } else if (state is PopularMoviesLoaded) {
          return loadedList;
        } else if (state is PopularMoviesNoMoreResults) {
          return loadedList;
        } else if (state is PopularMoviesError) {
          return Text(state.message);
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildTopList() {
    return BlocBuilder<TopMoviesBloc, TopMoviesState>(
      builder: (context, state) {
        final loadedList = BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, __) {
            return MoviesList(
              padding: const EdgeInsets.symmetric(vertical: 30),
              movies: state.movies,
              onMovieTap: (movie) => _onMovieTap(context, movie),
              onBookmarkTap: (movie) => _onBookmarkTap(context, movie),
              onLoadMoreTap: () => _onLoadMoreTopTap(context),
            );
          },
        );

        if (state is TopMoviesLoading) {
          return const Center(
            child: DefaultLoadingIndicator(),
          );
        } else if (state is TopMoviesLoaded) {
          return loadedList;
        } else if (state is TopMoviesNoMoreResults) {
          return loadedList;
        } else if (state is TopMoviesError) {
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

  void _onLoadMorePopularTap(BuildContext context) {
    context.read<PopularMoviesBloc>().add(const LoadMorePopularMoviesEvent());
  }

  void _onLoadMoreTopTap(BuildContext context) {
    context.read<TopMoviesBloc>().add(const LoadMoreTopMoviesEvent());
  }
}
