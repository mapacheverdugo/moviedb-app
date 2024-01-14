import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/utils/functions.dart';
import 'package:moviedb/features/search/data/models/search_result_item_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tSearchResultItemModel = SearchResultItemModel(
    id: 1,
    title: 'Test',
    overview: 'Overview',
    voteAverage: 1,
    releaseDate: DateTime.parse('2021-01-01'),
    posterUrl: getPosterUrl('/test.jpg'),
    backdropUrl: getBackdropUrl('/test.jpg'),
    voteCount: 1,
  );

  test(
    'should be a subclass of MovieEntity',
    () async {
      // assert
      expect(tSearchResultItemModel, isA<MovieEntity>());
    },
  );

  group(
    'fromJson',
    () {
      test(
        'should return a valid model when the JSON is valid',
        () async {
          // arrange
          final Map<String, dynamic> jsonMap =
              jsonDecode(fixture('search_result_item.json'));
          // act
          final result = SearchResultItemModel.fromJson(jsonMap);
          // assert
          expect(result, isA<SearchResultItemModel>());
        },
      );
    },
  );

  group(
    'toJson',
    () {
      test(
        'should return a JSON map containing the proper data',
        () async {
          // act
          final result = tSearchResultItemModel.toJson();
          // assert
          final expectedMap = {
            'id': 1,
            'title': 'Test',
            'overview': 'Overview',
            'vote_average': 1,
            'release_date': '2021-01-01T00:00:00.000',
            'poster_path': getPosterUrl('/test.jpg'),
            'backdrop_path': getBackdropUrl('/test.jpg'),
            'vote_count': 1,
          };
          expect(result, expectedMap);
        },
      );
    },
  );
}
