import 'package:equatable/equatable.dart';

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
  final bool isWatchlist;
  final int? userRating;

  const MovieEntity({
    required this.tmdbId,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.releaseDate,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    this.isWatchlist = false,
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
      ];
}
