import 'package:flutter/material.dart';
import 'package:moviedb/features/movies/domain/entities/movie.dart';

class MovieListTile extends StatelessWidget {
  final MovieEntity movie;

  const MovieListTile({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Row(
        children: [
          const SizedBox(
            width: 95,
            height: 120,
            child: Placeholder(),
          ),
          const SizedBox(width: 22),
          Expanded(
            child: _buildInfo(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Title:"),
        Text(movie.title),
        const SizedBox(height: 5),
        Text("Release date:"),
        Text(movie.releaseDate),
        Text("Average rating:"),
        const SizedBox(height: 5),
        Text(movie.voteAverage.toString()),
      ],
    );
  }
}
