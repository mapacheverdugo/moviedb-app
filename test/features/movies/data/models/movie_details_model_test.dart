import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:moviedb/core/utils/functions.dart';
import 'package:moviedb/features/movies/data/models/movie_details_model.dart';
import 'package:moviedb/features/movies/domain/entities/movie_details.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tMovieDetailsModel = MovieDetailsModel(
    id: 1,
    title: 'Test',
    overview: 'Overview',
    voteAverage: 1,
    releaseDate: DateTime.parse('2021-01-01'),
    posterUrl: getPosterUrl('/test.jpg'),
    backdropUrl: getBackdropUrl('/test.jpg'),
    voteCount: 1,
    popularity: 1,
    genres: const [],
    reviews: const [],
  );

  test(
    'should be a subclass of MovieDetailsEntity',
    () async {
      // assert
      expect(tMovieDetailsModel, isA<MovieDetailsEntity>());
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
              jsonDecode(fixture('movie_details.json'));
          // act
          final result = MovieDetailsModel.fromJson(jsonMap);
          // assert
          expect(result, isA<MovieDetailsModel>());
        },
      );
    },
  );
}
