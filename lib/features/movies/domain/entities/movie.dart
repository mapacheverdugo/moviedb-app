import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final int id;
  final String title;
  final String posterUrl;
  final String backdropUrl;
  final String releaseDate;
  final List<int> genres;
  final String overview;
  final double voteAverage;
  final int voteCount;

  const MovieEntity({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.releaseDate,
    required this.genres,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        posterUrl,
        backdropUrl,
        releaseDate,
        genres,
        overview,
        voteAverage,
        voteCount,
      ];
}
