import 'package:isar/isar.dart';
import 'package:moviedb/core/utils/functions.dart';
import 'package:moviedb/features/movies/data/models/genre_model.dart';
import 'package:moviedb/features/movies/data/models/review_model.dart';
import 'package:moviedb/features/movies/domain/entities/genre.dart';
import 'package:moviedb/features/movies/domain/entities/movie_details.dart';
import 'package:moviedb/features/movies/domain/entities/review.dart';

part 'movie_details_model.g.dart';

@Collection(
  ignore: {'props'},
)
// ignore: must_be_immutable
class MovieDetailsModel extends MovieDetailsEntity {
  final Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  // ignore: overridden_fields, annotate_overrides
  final int tmdbId;

  MovieDetailsModel({
    required this.tmdbId,
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
  }) : super(tmdbId: tmdbId);

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    final backdropPath = json['backdrop_path'] as String?;
    final posterPath = json['poster_path'] as String?;

    return MovieDetailsModel(
      tmdbId: json['id'],
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
      tmdbId: tmdbId,
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
