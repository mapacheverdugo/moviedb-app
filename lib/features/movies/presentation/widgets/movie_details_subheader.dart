import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/core/constants/constants.dart';
import 'package:moviedb/features/movies/presentation/blocs/movie_details/movie_details_bloc.dart';
import 'package:moviedb/features/movies/presentation/widgets/movie_genres_chips.dart';

class MovieDetailsSubheader extends StatelessWidget {
  const MovieDetailsSubheader({
    super.key,
    required this.tabBar,
  });

  final Widget tabBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 18),
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
        ],
      ),
    );
  }
}
