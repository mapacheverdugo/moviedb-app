import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/error/exception.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/features/search/data/data_sources/search_remote_data_source.dart';
import 'package:moviedb/features/search/data/models/search_result_item_model.dart';
import 'package:moviedb/features/search/data/repositories/search_repository.dart';

import 'search_repository_impl.mocks.dart';

@GenerateMocks([SearchRemoteDataSource])
void main() {
  late MockSearchRemoteDataSource mockSearchRemoteDataSource;
  late SearchRepositoryImpl searchRepositoryImpl;

  setUp(() {
    mockSearchRemoteDataSource = MockSearchRemoteDataSource();
    searchRepositoryImpl = SearchRepositoryImpl(mockSearchRemoteDataSource);
  });

  const tQuery = 'test';

  final tMovieModelList = [
    SearchResultItemModel(
      tmdbId: 1,
      title: 'Test',
      overview: 'Overview',
      voteAverage: 1,
      releaseDate: DateTime.parse('2021-01-01'),
      posterUrl: '/test.jpg',
      backdropUrl: '/test.jpg',
      voteCount: 1,
      popularity: 0.1,
    )
  ];

  group('search movies', () {
    test(
      'should return movies when a call to data source is successful',
      () async {
        // arrange
        when(mockSearchRemoteDataSource.search(query: tQuery))
            .thenAnswer((_) async => tMovieModelList);

        // act
        final result = await searchRepositoryImpl.search(query: tQuery);

        // assert
        verify(mockSearchRemoteDataSource.search(query: tQuery));
        expect(result, isA<Right<Failure, List<MovieEntity>>>());
      },
    );

    test(
      'should return ServerFailure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockSearchRemoteDataSource.search(query: tQuery))
            .thenThrow(ServerException());

        // act
        final result = await searchRepositoryImpl.search(query: tQuery);

        // assert
        expect(
            result, equals(const Left(ServerFailure('An error has occurred'))));
      },
    );
  });
}
