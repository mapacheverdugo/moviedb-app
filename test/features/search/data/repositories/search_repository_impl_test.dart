import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/error/exception.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/core/network/network_info.dart';
import 'package:moviedb/features/search/data/data_sources/search_local_data_source.dart';
import 'package:moviedb/features/search/data/data_sources/search_remote_data_source.dart';
import 'package:moviedb/features/search/data/models/search_result_item_model.dart';
import 'package:moviedb/features/search/data/repositories/search_repository_impl.dart';

import 'search_repository_impl_test.mocks.dart';

@GenerateMocks([
  SearchRemoteDataSource,
  SearchLocalDataSource,
  NetworkInfo,
])
void main() {
  late MockSearchRemoteDataSource mockSearchRemoteDataSource;
  late MockSearchLocalDataSource mockSearchLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late SearchRepositoryImpl searchRepositoryImpl;

  setUp(() {
    mockSearchRemoteDataSource = MockSearchRemoteDataSource();
    mockSearchLocalDataSource = MockSearchLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    searchRepositoryImpl = SearchRepositoryImpl(
      remoteDataSource: mockSearchRemoteDataSource,
      localDataSource: mockSearchLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
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

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('search', () {
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockSearchRemoteDataSource.search(query: tQuery))
            .thenAnswer((_) async => tMovieModelList);

        // act
        searchRepositoryImpl.search(query: tQuery);
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
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
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockSearchRemoteDataSource.search(query: tQuery))
              .thenAnswer((_) async => tMovieModelList);
          // act
          await searchRepositoryImpl.search(query: tQuery);
          // assert
          verify(mockSearchRemoteDataSource.search(query: tQuery));
          verify(mockSearchLocalDataSource.cacheSearchItems(tMovieModelList));
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
          expect(result,
              equals(const Left(ServerFailure('An error has occurred'))));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockSearchLocalDataSource.search(query: tQuery))
              .thenAnswer((_) async => tMovieModelList);
          // act
          final result = await searchRepositoryImpl.search(query: tQuery);
          // assert

          verify(searchRepositoryImpl.search(query: tQuery));
          expect(result, equals(Right(tMovieModelList)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockSearchLocalDataSource.search(query: tQuery))
              .thenThrow(CacheException());
          // act
          final result = await searchRepositoryImpl.search(query: tQuery);
          // assert
          verify(mockSearchLocalDataSource.search(query: tQuery));
          expect(result,
              equals(const Left(CacheFailure("An error has occurred"))));
        },
      );
    });
  });
}
