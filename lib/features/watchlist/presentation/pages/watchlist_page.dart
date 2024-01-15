import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:moviedb/core/constants/constants.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/presentation/widgets/app_title.dart';
import 'package:moviedb/core/presentation/widgets/default_loading_indicator.dart';
import 'package:moviedb/core/presentation/widgets/floating_back_button.dart';
import 'package:moviedb/core/presentation/widgets/movies_list.dart';
import 'package:moviedb/core/presentation/widgets/simple_state_message.dart';
import 'package:moviedb/features/watchlist/presentation/blocs/watchlist_bloc/watchlist_bloc.dart';

class WatchlistPage extends StatelessWidget {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  WatchlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    context.read<WatchlistBloc>().add(GetWatchlistItems());

    return Scaffold(
      body: Scaffold(
        body: Stack(
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
                          "Your Watch List",
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
    return BlocBuilder<WatchlistBloc, WatchlistState>(
      builder: (context, state) {
        if (state.movies.isNotEmpty) {
          return MoviesList(
            movies: state.movies,
            padding: const EdgeInsets.symmetric(
              vertical: 31,
            ),
            onMovieTap: (movie) => _onMovieTap(context, movie),
            onBookmarkTap: (movie) => _onBookmarkTap(context, movie),
          );
        } else {
          if (state is WatchlistLoading) {
            return const Center(
              child: DefaultLoadingIndicator(),
            );
          } else if (state is WatchlistError) {
            return SimpleStateMessage(
              title: "Error",
              subtitle: state.message,
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/animations/popcorns.json',
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  repeat: false,
                ),
                const SimpleStateMessage(
                  title: "No movies in your watch list yet!",
                  subtitle:
                      "Add some movies to your watch list to see them here.",
                ),
              ],
            );
          }
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

  void _onBookmarkTap(BuildContext context, MovieEntity movie) {
    if (movie.isWatchlisted) {
      _listKey.currentState?.removeItem(
        1,
        (context, animation) => Container(),
      );
    }

    context.read<WatchlistBloc>().add(ToggleWatchlistItem(movie: movie));
    context.read<WatchlistBloc>().add(GetWatchlistItems());
  }
}
