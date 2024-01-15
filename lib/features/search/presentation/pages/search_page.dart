import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/core/constants/constants.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/presentation/widgets/app_title.dart';
import 'package:moviedb/core/presentation/widgets/custom_search_bar.dart';
import 'package:moviedb/core/presentation/widgets/floating_back_button.dart';
import 'package:moviedb/core/presentation/widgets/movies_list.dart';
import 'package:moviedb/features/search/presentation/blocs/search_bloc/search_bloc.dart';
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
                          const SizedBox(height: 22),
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
        if (state is SearchLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SearchLoaded) {
          return MoviesList(
            movies: state.results,
            onMovieTap: (movie) => _onMovieTap(context, movie),
            onLoadMoreTap: () => _onLoadMoreTap(context),
          );
        } else if (state is SearchNoMoreResults) {
          return MoviesList(
            movies: state.results,
            onMovieTap: (movie) => _onMovieTap(context, movie),
          );
        } else if (state is SearchError) {
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
