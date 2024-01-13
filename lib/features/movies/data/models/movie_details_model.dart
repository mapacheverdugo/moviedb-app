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
    return MovieDetailsModel(
      id: json['id'],
      title: json['title'],
      posterUrl: json['poster_path'],
      backdropUrl: json['backdrop_path'],
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
}
