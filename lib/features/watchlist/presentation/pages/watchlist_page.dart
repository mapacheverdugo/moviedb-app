import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/core/constants/constants.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/presentation/widgets/app_title.dart';
import 'package:moviedb/core/presentation/widgets/floating_back_button.dart';
import 'package:moviedb/core/presentation/widgets/movies_list.dart';
import 'package:moviedb/features/watchlist/presentation/blocs/watchlist_bloc/watchlist_bloc.dart';
import 'package:moviedb/injection_container.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Scaffold(
        body: BlocProvider(
          create: (context) => sl<WatchlistBloc>()..add(GetWatchlistItems()),
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
                            "Your Watch List",
                            style: textTheme.titleLarge,
                          ),
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
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {
        if (state is WatchlistLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WatchlistLoaded) {
          return MoviesList(
            movies: state.movies,
            onMovieTap: (movie) => _onMovieTap(context, movie),
          );
        } else if (state is WatchlistError) {
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
}
