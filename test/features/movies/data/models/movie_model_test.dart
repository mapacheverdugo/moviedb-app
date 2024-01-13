import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:moviedb/features/movies/data/models/movie_model.dart';
import 'package:moviedb/features/movies/domain/entities/movie.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tMovieModel = MovieModel(
    id: 1,
    title: 'Test',
    overview: 'Overview',
    voteAverage: 1,
    releaseDate: '2021-01-01',
    posterUrl: '/test.jpg',
    backdropUrl: '/test.jpg',
    voteCount: 1,
    genres: [1, 2],
  );

  test(
    'should be a subclass of MovieEntity',
    () async {
      // assert
      expect(tMovieModel, isA<MovieEntity>());
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
              jsonDecode(fixture('movie.json'));
          // act
          final result = MovieModel.fromJson(jsonMap);
          // assert
          expect(result, tMovieModel);
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
          final result = tMovieModel.toJson();
          // assert
          final expectedMap = {
            'id': 1,
            'title': 'Test',
            'overview': 'Overview',
            'vote_average': 1,
            'release_date': '2021-01-01',
            'poster_path': '/test.jpg',
            'backdrop_path': '/test.jpg',
            'vote_count': 1,
            'genre_ids': [1, 2],
          };
          expect(result, expectedMap);
        },
      );
    },
  );
}
