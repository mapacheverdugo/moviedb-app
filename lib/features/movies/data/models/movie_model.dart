import 'package:moviedb/features/movies/domain/entities/movie.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required super.id,
    required super.title,
    required super.posterUrl,
    required super.backdropUrl,
    required super.releaseDate,
    required super.genres,
    required super.overview,
    required super.voteAverage,
    required super.voteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> jsonMap) {
    return MovieModel(
      id: jsonMap['id'] as int,
      title: jsonMap['title'] as String,
      posterUrl: jsonMap['poster_path'] as String,
      backdropUrl: jsonMap['backdrop_path'] as String,
      releaseDate: jsonMap['release_date'] as String,
      genres: (jsonMap['genre_ids'] as List<dynamic>)
          .map((dynamic id) => id as int)
          .toList(),
      overview: jsonMap['overview'] as String,
      voteAverage: (jsonMap['vote_average'] as num).toDouble(),
      voteCount: jsonMap['vote_count'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'vote_average': voteAverage,
      'release_date': releaseDate,
      'poster_path': posterUrl,
      'backdrop_path': backdropUrl,
      'vote_count': voteCount,
      'genre_ids': genres,
    };
  }

  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      title: title,
      posterUrl: posterUrl,
      backdropUrl: backdropUrl,
      releaseDate: releaseDate,
      genres: genres,
      overview: overview,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }
}
