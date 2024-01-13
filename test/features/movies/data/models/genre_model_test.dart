import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:moviedb/features/movies/data/models/genre_model.dart';
import 'package:moviedb/features/movies/domain/entities/genre.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tGenreModel = GenreModel(
    id: 1,
    name: 'Test',
  );

  test(
    'should be a subclass of GenreEntity',
    () async {
      // assert
      expect(tGenreModel, isA<GenreEntity>());
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
              jsonDecode(fixture('genre.json'));
          // act
          final result = GenreModel.fromJson(jsonMap);
          // assert
          expect(result, isA<GenreModel>());
        },
      );
    },
  );
}
