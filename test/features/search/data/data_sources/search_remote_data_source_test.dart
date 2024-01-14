import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/core/constants/constants.dart';
import 'package:moviedb/core/error/exception.dart';
import 'package:moviedb/features/search/data/data_sources/search_remote_data_source.dart';
import 'package:moviedb/features/search/data/models/search_result_item_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'search_remote_data_source_test.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {
  late MockHttpClient mockHttpClient;
  late SearchRemoteDataSourceImpl searchRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    searchRemoteDataSourceImpl = SearchRemoteDataSourceImpl(mockHttpClient);
  });

  group(
    'search',
    () {
      const tQuery = 'test';
      final tUrl = Uri.parse(TheMovieDbConstants.getSearchMovieUrl(tQuery));

      test(
        'should perform a GET request on a URL and return a List of SearchResultItemModel when search',
        () async {
          // arrange
          when(
            mockHttpClient.get(tUrl, headers: anyNamed('headers')),
          ).thenAnswer(
            (_) async => http.Response(
              fixture('search.json'),
              200,
              headers: {
                HttpHeaders.contentTypeHeader:
                    'application/json; charset=utf-8',
              },
            ),
          );
          // act
          final result = await searchRemoteDataSourceImpl.search(query: tQuery);
          // assert
          verify(mockHttpClient.get(
            tUrl,
            headers: anyNamed('headers'),
          ));
          expect(result, isA<List<SearchResultItemModel>>());
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
          final result = searchRemoteDataSourceImpl.search(query: tQuery);
          // assert
          expect(result, throwsA(isA<ServerException>()));
        },
      );
    },
  );
}
