import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class MovieEntity extends Equatable {
  final int tmdbId;
  final String title;
  final String posterUrl;
  final String backdropUrl;
  final DateTime? releaseDate;
  final String overview;
  final double voteAverage;
  final int voteCount;
  final double popularity;
  bool isWatchlisted;
  int? userRating;

  MovieEntity({
    required this.tmdbId,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.releaseDate,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    this.isWatchlisted = false,
    this.userRating,
  });

  @override
  List<Object?> get props => [
        tmdbId,
        title,
        posterUrl,
        backdropUrl,
        releaseDate,
        overview,
        voteAverage,
        voteCount,
        popularity,
        isWatchlisted,
        userRating,
      ];
}
