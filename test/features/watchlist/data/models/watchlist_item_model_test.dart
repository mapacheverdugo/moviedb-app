import 'package:flutter_test/flutter_test.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/utils/functions.dart';
import 'package:moviedb/features/watchlist/data/models/watchlist_item_model.dart';

void main() {
  final tWatchListItemModel = WatchListItemModel(
    tmdbId: 1,
    title: 'Test',
    overview: 'Overview',
    voteAverage: 1,
    releaseDate: DateTime.parse('2021-01-01'),
    posterUrl: getPosterUrl('/test.jpg'),
    backdropUrl: getBackdropUrl('/test.jpg'),
    voteCount: 1,
    popularity: 0.1,
  );

  test(
    'should be a subclass of MovieEntity',
    () async {
      // assert
      expect(tWatchListItemModel, isA<MovieEntity>());
    },
  );
}
