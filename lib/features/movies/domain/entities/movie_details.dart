import 'package:equatable/equatable.dart';
import 'package:moviedb/features/movies/domain/entities/genre.dart';
import 'package:moviedb/features/movies/domain/entities/review.dart';

class MovieDetailsEntity extends Equatable {
  final int id;
  final String title;
  final String posterUrl;
  final String backdropUrl;
  final DateTime releaseDate;
  final String overview;
  final double voteAverage;
  final int voteCount;
  final double popularity;
  final List<GenreEntity> genres;
  final List<ReviewEntity> reviews;

  const MovieDetailsEntity({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.releaseDate,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    required this.genres,
    required this.reviews,
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
