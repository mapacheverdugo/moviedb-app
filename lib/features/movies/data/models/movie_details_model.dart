import 'package:moviedb/core/utils/functions.dart';
import 'package:moviedb/features/movies/data/models/genre_model.dart';
import 'package:moviedb/features/movies/data/models/review_model.dart';
import 'package:moviedb/features/movies/domain/entities/movie_details.dart';

class MovieDetailsModel extends MovieDetailsEntity {
  const MovieDetailsModel({
    required super.id,
    required super.title,
    required super.posterUrl,
    required super.backdropUrl,
    required super.releaseDate,
    required super.overview,
    required super.voteAverage,
    required super.voteCount,
    required super.popularity,
    required super.genres,
    required super.reviews,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    final backdropPath = json['backdrop_path'] as String?;
    final posterPath = json['poster_path'] as String?;

    return MovieDetailsModel(
      id: json['id'],
      title: json['title'],
      posterUrl: getPosterUrl(posterPath),
      backdropUrl: getBackdropUrl(backdropPath),
      releaseDate: DateTime.parse(json['release_date']),
      overview: json['overview'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'],
      popularity: (json['popularity'] as num).toDouble(),
      genres: json['genres'] != null
          ? List<GenreModel>.from(
              json['genres'].map((g) => GenreModel.fromJson(g)))
          : [],
      reviews: json['reviews'] != null
          ? List<ReviewModel>.from(
              json['reviews']['results'].map((r) => ReviewModel.fromJson(r)))
          : [],
    );
  }

  MovieDetailsEntity toEntity() {
    return MovieDetailsEntity(
      id: id,
      title: title,
      posterUrl: posterUrl,
      backdropUrl: backdropUrl,
      releaseDate: releaseDate,
      overview: overview,
      voteAverage: voteAverage,
      voteCount: voteCount,
      popularity: popularity,
      genres: genres,
      reviews: reviews,
    );
  }
}
