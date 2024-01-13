import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:moviedb/features/movies/presentation/widgets/movie_list_tile.dart';
import 'package:moviedb/injection_container.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<MoviesBloc>()..add(const GetMoviesEvent()),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Movie DB App"),
              const Text("Find your movies"),
              const Text("Categories"),
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
          return const CircularProgressIndicator();
        } else if (state is MoviesLoaded) {
          return ListView.separated(
            shrinkWrap: true,
            itemCount: state.movies.length,
            separatorBuilder: (context, index) => const SizedBox(height: 18),
            itemBuilder: (context, index) {
              final movie = state.movies[index];
              return MovieListTile(movie: movie);
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
}
