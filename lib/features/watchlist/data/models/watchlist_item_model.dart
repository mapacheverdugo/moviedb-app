import 'package:isar/isar.dart';
import 'package:moviedb/core/domain/entities/movie.dart';

part 'watchlist_item_model.g.dart';

@Collection(ignore: {'props'})
// ignore: must_be_immutable
class WatchListItemModel extends MovieEntity {
  final Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  // ignore: overridden_fields, annotate_overrides
  final int tmdbId;

  WatchListItemModel({
    required this.tmdbId,
    required super.title,
    required super.posterUrl,
    required super.backdropUrl,
    required super.releaseDate,
    required super.overview,
    required super.voteAverage,
    required super.voteCount,
    required super.popularity,
    super.isWatchlisted = true,
  }) : super(tmdbId: tmdbId);

  factory WatchListItemModel.fromEntity(MovieEntity entity) {
    return WatchListItemModel(
      tmdbId: entity.tmdbId,
      title: entity.title,
      posterUrl: entity.posterUrl,
      backdropUrl: entity.backdropUrl,
      releaseDate: entity.releaseDate,
      overview: entity.overview,
      voteAverage: entity.voteAverage,
      voteCount: entity.voteCount,
      popularity: entity.popularity,
      isWatchlisted: entity.isWatchlisted,
    );
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
      isWatchlisted: isWatchlisted,
      userRating: userRating,
    );
  }
}
