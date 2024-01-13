import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/features/movies/domain/entities/movie.dart';
import 'package:moviedb/features/movies/presentation/blocs/movies_bloc/movies_bloc.dart';
import 'package:moviedb/features/movies/presentation/widgets/movie_list_tile.dart';
import 'package:moviedb/injection_container.dart';

class MoviesPage extends StatelessWidget {
  static const _padding = EdgeInsets.symmetric(
    vertical: 31,
    horizontal: 15,
  );

  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<MoviesBloc>()..add(const GetMoviesEvent()),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: _padding.horizontal,
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
                    const SizedBox(height: 31),
                  ],
                ),
              ),
              Expanded(
                child: _buildList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MoviesLoaded) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: state.movies.length,
            itemBuilder: (context, index) {
              final movie = state.movies[index];
              return MovieListTile(
                movie: movie,
                padding: EdgeInsets.symmetric(
                  vertical: 9,
                  horizontal: _padding.horizontal,
                ),
                onTap: () => _onMovieTap(context, movie),
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

  void _onMovieTap(BuildContext context, MovieEntity movie) {
    Navigator.of(context).pushNamed(
      '/movie_details',
      arguments: movie,
    );
  }
}
