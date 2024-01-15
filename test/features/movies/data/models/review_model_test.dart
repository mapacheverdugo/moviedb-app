import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:moviedb/features/movies/data/models/review_model.dart';
import 'package:moviedb/features/movies/domain/entities/review.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tReviewModel = ReviewModel(
    authorName: "Test",
    authorUsername: "test",
    avatarUrl: "/test.jpg",
    rating: 1,
    content: "Test",
  );

  test(
    'should be a subclass of ReviewEntity',
    () async {
      // assert
      expect(tReviewModel, isA<ReviewEntity>());
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
              jsonDecode(fixture('review.json'));
          // act
          final result = ReviewModel.fromJson(jsonMap);
          // assert
          expect(result, isA<ReviewModel>());
        },
      );
    },
  );
}
