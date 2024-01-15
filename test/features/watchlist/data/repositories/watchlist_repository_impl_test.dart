import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/error/exception.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/features/watchlist/data/data_sources/watchlist_local_data_source.dart';
import 'package:moviedb/features/watchlist/data/models/watchlist_item_model.dart';
import 'package:moviedb/features/watchlist/data/repositories/watchlist_repository_impl.dart';

import 'watchlist_repository_impl_test.mocks.dart';

@GenerateMocks([WatchListLocalDataSource])
void main() {
  late MockWatchListLocalDataSource mockWatchListLocalDataSource;
  late WatchListRepositoryImpl watchListRepositoryImpl;

  setUp(() {
    mockWatchListLocalDataSource = MockWatchListLocalDataSource();
    watchListRepositoryImpl =
        WatchListRepositoryImpl(mockWatchListLocalDataSource);
  });

  const tTmdbId = 1;

  final tMovieModel = WatchListItemModel(
    tmdbId: tTmdbId,
    title: 'Test',
    overview: 'Overview',
    voteAverage: 1,
    releaseDate: DateTime.parse('2021-01-01'),
    posterUrl: '/test.jpg',
    backdropUrl: '/test.jpg',
    voteCount: 1,
    popularity: 0.1,
  );

  final tMovieModelList = [tMovieModel];

  group('getWatchListItems', () {
    test(
      'should return watchlisted movies when a call to data source is successful',
      () async {
        // arrange
        when(mockWatchListLocalDataSource.getWatchListItems())
            .thenAnswer((_) async => tMovieModelList);

        // act
        final result = await watchListRepositoryImpl.getWatchListItems();

        // assert
        verify(mockWatchListLocalDataSource.getWatchListItems());
        expect(result, isA<Right<Failure, List<MovieEntity>>>());
      },
    );

    test(
      'should return CacheFailure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockWatchListLocalDataSource.getWatchListItems())
            .thenThrow(ServerException());

        // act
        final result = await watchListRepositoryImpl.getWatchListItems();

        // assert
        expect(
            result, equals(const Left(CacheFailure('An error has occurred'))));
      },
    );
  });

  group('addWatchListItem', () {
    test(
      'should return watchlist id when a call to data source is successful',
      () async {
        // arrange
        when(mockWatchListLocalDataSource.addWatchListItem(tMovieModel))
            .thenAnswer((_) async => tTmdbId);

        // act
        final result =
            await watchListRepositoryImpl.addWatchListItem(tMovieModel);

        // assert
        verify(mockWatchListLocalDataSource.addWatchListItem(tMovieModel));
        expect(result, isA<Right<Failure, int>>());
      },
    );

    test(
      'should return CacheFailure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockWatchListLocalDataSource.addWatchListItem(tMovieModel))
            .thenThrow(ServerException());

        // act
        final result =
            await watchListRepositoryImpl.addWatchListItem(tMovieModel);

        // assert
        expect(
            result, equals(const Left(CacheFailure('An error has occurred'))));
      },
    );
  });

  group('removeWatchListItem', () {
    test(
      'should return a bool when a call to data source is successful',
      () async {
        // arrange
        when(mockWatchListLocalDataSource.removeWatchListItem(tTmdbId))
            .thenAnswer((_) async => true);

        // act
        final result =
            await watchListRepositoryImpl.removeWatchListItem(tTmdbId);

        // assert
        verify(mockWatchListLocalDataSource.removeWatchListItem(tTmdbId));
        expect(result, isA<Right<Failure, bool>>());
      },
    );

    test(
      'should return CacheFailure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockWatchListLocalDataSource.removeWatchListItem(tTmdbId))
            .thenThrow(ServerException());

        // act
        final result =
            await watchListRepositoryImpl.removeWatchListItem(tTmdbId);

        // assert
        expect(
            result, equals(const Left(CacheFailure('An error has occurred'))));
      },
    );
  });

  group('isItemAdded', () {
    test(
      'should return a bool when a call to data source is successful',
      () async {
        // arrange
        when(mockWatchListLocalDataSource.isItemAdded(tTmdbId))
            .thenAnswer((_) async => true);

        // act
        final result = await watchListRepositoryImpl.checkIfAdded(tTmdbId);

        // assert
        verify(mockWatchListLocalDataSource.isItemAdded(tTmdbId));
        expect(result, isA<Right<Failure, bool>>());
      },
    );

    test(
      'should return CacheFailure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockWatchListLocalDataSource.isItemAdded(tTmdbId))
            .thenThrow(ServerException());

        // act
        final result = await watchListRepositoryImpl.checkIfAdded(tTmdbId);

        // assert
        expect(
            result, equals(const Left(CacheFailure('An error has occurred'))));
      },
    );
  });
}
