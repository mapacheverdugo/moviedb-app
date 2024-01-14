import 'package:moviedb/core/utils/functions.dart';
import 'package:moviedb/features/movies/domain/entities/movie.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required super.id,
    required super.title,
    required super.posterUrl,
    required super.backdropUrl,
    required super.releaseDate,
    required super.overview,
    required super.voteAverage,
    required super.voteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    final backdropPath = json['backdrop_path'] as String?;
    final posterPath = json['poster_path'] as String?;
    final releaseDate = json['release_date'] as String;

    return MovieModel(
      id: json['id'] as int,
      title: json['title'] as String,
      posterUrl: getPosterUrl(posterPath),
      backdropUrl: getBackdropUrl(backdropPath),
      releaseDate: DateTime.tryParse(releaseDate),
      overview: json['overview'] as String,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'vote_average': voteAverage,
      'release_date': releaseDate?.toIso8601String(),
      'poster_path': posterUrl,
      'backdrop_path': backdropUrl,
      'vote_count': voteCount,
    };
  }

  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      title: title,
      posterUrl: posterUrl,
      backdropUrl: backdropUrl,
      releaseDate: releaseDate,
      overview: overview,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }
}
