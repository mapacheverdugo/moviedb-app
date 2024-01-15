import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/utils/functions.dart';

// ignore: must_be_immutable
class MovieModel extends MovieEntity {
  MovieModel({
    required super.tmdbId,
    required super.title,
    required super.posterUrl,
    required super.backdropUrl,
    required super.releaseDate,
    required super.overview,
    required super.voteAverage,
    required super.voteCount,
    required super.popularity,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    final backdropPath = json['backdrop_path'] as String?;
    final posterPath = json['poster_path'] as String?;
    final releaseDate = json['release_date'] as String;

    return MovieModel(
      tmdbId: json['id'] as int,
      title: json['title'] as String,
      posterUrl: getPosterUrl(posterPath),
      backdropUrl: getBackdropUrl(backdropPath),
      releaseDate: DateTime.tryParse(releaseDate),
      overview: json['overview'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
      popularity: (json['popularity'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': tmdbId,
      'title': title,
      'overview': overview,
      'vote_average': voteAverage,
      'release_date': releaseDate?.toIso8601String(),
      'poster_path': posterUrl,
      'backdrop_path': backdropUrl,
      'vote_count': voteCount,
      'popularity': popularity,
    };
  }

  MovieEntity toEntity() {
    return MovieEntity(
      tmdbId: tmdbId,
      title: title,
      posterUrl: posterUrl,
      backdropUrl: backdropUrl,
      releaseDate: releaseDate,
      overview: overview,
      voteAverage: voteAverage,
      voteCount: voteCount,
      popularity: popularity,
    );
  }
}
