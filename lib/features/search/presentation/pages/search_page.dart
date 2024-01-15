import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/core/constants/constants.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/presentation/widgets/app_title.dart';
import 'package:moviedb/core/presentation/widgets/custom_search_bar.dart';
import 'package:moviedb/core/presentation/widgets/default_loading_indicator.dart';
import 'package:moviedb/core/presentation/widgets/floating_back_button.dart';
import 'package:moviedb/core/presentation/widgets/movies_list.dart';
import 'package:moviedb/core/presentation/widgets/simple_state_message.dart';
import 'package:moviedb/features/search/presentation/blocs/search_bloc/search_bloc.dart';
import 'package:moviedb/features/watchlist/presentation/blocs/watchlist_bloc/watchlist_bloc.dart';
import 'package:moviedb/injection_container.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Scaffold(
        body: BlocProvider(
          create: (context) => sl<SearchBloc>(),
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
                          Builder(builder: (context) {
                            return CustomSearchBar(
                              autofocus: true,
                              onChanged: (query) =>
                                  _onInputChanged(context, query),
                              onSearchAction: (query) =>
                                  _onSearchAction(context, query),
                            );
                          }),
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
      ),
    );
  }

  Widget _buildList() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchInitial) {
          return const SimpleStateMessage(
            title: "Start typing to search a movie!",
          );
        }
        if (state is SearchLoading) {
          return const Center(
            child: DefaultLoadingIndicator(),
          );
        } else if (state is SearchLoaded) {
          if (state.results.isEmpty) {
            return const SimpleStateMessage(
              title: "No results found",
              subtitle: "Try searching something else.",
            );
          }
          return MoviesList(
            movies: state.results,
            padding: const EdgeInsets.symmetric(
              vertical: 31,
            ),
            onMovieTap: (movie) => _onMovieTap(context, movie),
            onLoadMoreTap: () => _onLoadMoreTap(context),
            onBookmarkTap: (movie) => _onBookmarkedTap(context, movie),
          );
        } else if (state is SearchNoMoreResults) {
          return MoviesList(
            movies: state.results,
            padding: const EdgeInsets.symmetric(
              vertical: 31,
            ),
            onMovieTap: (movie) => _onMovieTap(context, movie),
            onBookmarkTap: (movie) => _onBookmarkedTap(context, movie),
          );
        } else if (state is SearchError) {
          return SimpleStateMessage(
            title: "Error",
            subtitle: state.message,
          );
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
                child: FloatingBackButton(),
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

  void _onBookmarkedTap(BuildContext context, MovieEntity movie) {
    context.read<WatchlistBloc>().add(
          ToggleWatchlistItem(movie: movie),
        );
  }

  void _onLoadMoreTap(BuildContext context) {
    context.read<SearchBloc>().add(const LoadMoreSearchResults());
  }

  void _onInputChanged(BuildContext context, String query) {
    context.read<SearchBloc>().add(
          ChangeQueryToSearch(query: query),
        );
  }

  void _onSearchAction(BuildContext context, String query) {
    context.read<SearchBloc>().add(
          SearchNow(query: query),
        );
  }
}
