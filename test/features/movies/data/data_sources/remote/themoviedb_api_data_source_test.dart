import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/core/constants/constants.dart';
import 'package:moviedb/core/error/exception.dart';
import 'package:moviedb/features/movies/data/data_sources/remote/themoviedb_api_data_source.dart';
import 'package:moviedb/features/movies/data/models/movie_details_model.dart';
import 'package:moviedb/features/movies/data/models/movie_model.dart';

import '../../../../../fixtures/fixture_reader.dart';
import 'themoviedb_api_data_source_test.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {
  late MockHttpClient mockHttpClient;
  late TheMovieDbApiDataSourceImpl theMovieDbApiDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    theMovieDbApiDataSourceImpl = TheMovieDbApiDataSourceImpl(mockHttpClient);
  });

  group(
    'getPopularMovies',
    () {
      final tUrl = Uri.parse(TheMovieDbConstants.popularUrl);

      test(
        'should perform a GET request on a URL and return a List of MovieModel when get popular movies',
        () async {
          // arrange
          when(
            mockHttpClient.get(tUrl, headers: anyNamed('headers')),
          ).thenAnswer(
            (_) async => http.Response(
              fixture('movies_popular.json'),
              200,
              headers: {
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=utf-8',
              },
            ),
          );
          // act
          final result = await theMovieDbApiDataSourceImpl.getPopularMovies();
          // assert
          verify(mockHttpClient.get(
            tUrl,
            headers: anyNamed('headers'),
          ));
          expect(result, isA<List<MovieModel>>());
        },
      );

      test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
          // arrange
          when(
            mockHttpClient.get(
              tUrl,
              headers: anyNamed('headers'),
            ),
          ).thenAnswer(
            (_) async => http.Response(
              'Something went wrong',
              404,
            ),
          );
          // act
          final result = theMovieDbApiDataSourceImpl.getPopularMovies;
          // assert
          expect(result, throwsA(isA<ServerException>()));
        },
      );
    },
  );

  group(
    'getMovieDetails',
    () {
      const tMovieId = 1;
      final tUrl = Uri.parse(TheMovieDbConstants.getMovieDetailsUrl(tMovieId));

      test(
        'should perform a GET request on a URL and return a MovieDetailsModel when get movie details',
        () async {
          // arrange
          when(
            mockHttpClient.get(tUrl, headers: anyNamed('headers')),
          ).thenAnswer(
            (_) async => http.Response(
              fixture('movie_details.json'),
              200,
              headers: {
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=utf-8',
              },
            ),
          );
          // act
          final result = await theMovieDbApiDataSourceImpl.getMovieDetails(
              movieId: tMovieId);
          // assert
          verify(mockHttpClient.get(
            tUrl,
            headers: anyNamed('headers'),
          ));
          expect(result, isA<MovieDetailsModel>());
        },
      );

      test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
          // arrange
          when(
            mockHttpClient.get(
              tUrl,
              headers: anyNamed('headers'),
            ),
          ).thenAnswer(
            (_) async => http.Response(
              'Something went wrong',
              404,
            ),
          );
          // act
          final result =
              theMovieDbApiDataSourceImpl.getMovieDetails(movieId: tMovieId);
          // assert
          expect(result, throwsA(isA<ServerException>()));
        },
      );
    },
  );
}
