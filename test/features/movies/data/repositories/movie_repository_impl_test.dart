import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/error/exception.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/core/network/network_info.dart';
import 'package:moviedb/core/utils/functions.dart';
import 'package:moviedb/features/movies/data/data_sources/movies_local_data_source.dart';
import 'package:moviedb/features/movies/data/data_sources/movies_remote_data_source.dart';
import 'package:moviedb/features/movies/data/models/movie_details_model.dart';
import 'package:moviedb/features/movies/data/models/movie_model.dart';
import 'package:moviedb/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:moviedb/features/movies/domain/entities/movie_details.dart';

import 'movie_repository_impl_test.mocks.dart';

@GenerateMocks([
  MoviesRemoteDataSource,
  MoviesLocalDataSource,
  NetworkInfo,
])
void main() {
  late MockMoviesRemoteDataSource mockMoviesRemoteDataSource;
  late MockMoviesLocalDataSource mockMoviesLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MovieRepositoryImpl movieRepositoryImpl;

  setUp(() {
    mockMoviesRemoteDataSource = MockMoviesRemoteDataSource();
    mockMoviesLocalDataSource = MockMoviesLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    movieRepositoryImpl = MovieRepositoryImpl(
      remoteDataSource: mockMoviesRemoteDataSource,
      localDataSource: mockMoviesLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

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

  final tMovieModelList = [
    MovieModel(
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

  group('getPopularMovies', () {
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockMoviesRemoteDataSource.getPopularMovies())
            .thenAnswer((_) async => tMovieModelList);

        // act
        movieRepositoryImpl.getPopularMovies();
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockMoviesRemoteDataSource.getPopularMovies())
              .thenAnswer((_) async => tMovieModelList);

          // act
          final result = await movieRepositoryImpl.getPopularMovies();

          // assert
          verify(mockMoviesRemoteDataSource.getPopularMovies());
          expect(result, isA<Right<Failure, List<MovieEntity>>>());
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockMoviesRemoteDataSource.getPopularMovies())
              .thenAnswer((_) async => tMovieModelList);
          // act
          await movieRepositoryImpl.getPopularMovies();
          // assert
          verify(mockMoviesRemoteDataSource.getPopularMovies());
          verify(
              mockMoviesLocalDataSource.cacheMovies(movies: tMovieModelList));
        },
      );

      test(
        'should return ServerFailure when a call to data source is unsuccessful',
        () async {
          // arrange
          when(mockMoviesRemoteDataSource.getPopularMovies())
              .thenThrow(ServerException());

          // act
          final result = await movieRepositoryImpl.getPopularMovies();

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
          when(mockMoviesLocalDataSource.getPopularMovies())
              .thenAnswer((_) async => tMovieModelList);
          // act
          final result = await movieRepositoryImpl.getPopularMovies();
          // assert

          verify(movieRepositoryImpl.getPopularMovies());
          expect(result, equals(Right(tMovieModelList)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockMoviesLocalDataSource.getPopularMovies())
              .thenThrow(CacheException());
          // act
          final result = await movieRepositoryImpl.getPopularMovies();
          // assert
          verify(mockMoviesLocalDataSource.getPopularMovies());
          expect(result,
              equals(const Left(CacheFailure("An error has occurred"))));
        },
      );
    });
  });

  group('getTopMovies', () {
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockMoviesRemoteDataSource.getTopMovies())
            .thenAnswer((_) async => tMovieModelList);

        // act
        movieRepositoryImpl.getTopMovies();
        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockMoviesRemoteDataSource.getTopMovies())
              .thenAnswer((_) async => tMovieModelList);

          // act
          final result = await movieRepositoryImpl.getTopMovies();

          // assert
          verify(mockMoviesRemoteDataSource.getTopMovies());
          expect(result, isA<Right<Failure, List<MovieEntity>>>());
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(mockMoviesRemoteDataSource.getTopMovies())
              .thenAnswer((_) async => tMovieModelList);
          // act
          await movieRepositoryImpl.getTopMovies();
          // assert
          verify(mockMoviesRemoteDataSource.getTopMovies());
          verify(
              mockMoviesLocalDataSource.cacheMovies(movies: tMovieModelList));
        },
      );

      test(
        'should return ServerFailure when a call to data source is unsuccessful',
        () async {
          // arrange
          when(mockMoviesRemoteDataSource.getTopMovies())
              .thenThrow(ServerException());

          // act
          final result = await movieRepositoryImpl.getTopMovies();

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
          when(mockMoviesLocalDataSource.getTopMovies())
              .thenAnswer((_) async => tMovieModelList);
          // act
          final result = await movieRepositoryImpl.getTopMovies();
          // assert

          verify(movieRepositoryImpl.getTopMovies());
          expect(result, equals(Right(tMovieModelList)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(mockMoviesLocalDataSource.getTopMovies())
              .thenThrow(CacheException());
          // act
          final result = await movieRepositoryImpl.getTopMovies();
          // assert
          verify(mockMoviesLocalDataSource.getTopMovies());
          expect(result,
              equals(const Left(CacheFailure("An error has occurred"))));
        },
      );
    });
  });

  const tMovieId = 1;
  final tMovieDetailsModel = MovieDetailsModel(
    id: tMovieId,
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

  group('getMovieDetails', () {
    test(
      'should return movie details when a call to data source is successful',
      () async {
        // arrange
        when(mockMoviesRemoteDataSource.getMovieDetails(movieId: tMovieId))
            .thenAnswer((_) async => tMovieDetailsModel);

        // act
        final result =
            await movieRepositoryImpl.getMovieDetails(movieId: tMovieId);

        // assert
        verify(mockMoviesRemoteDataSource.getMovieDetails(movieId: tMovieId));
        expect(result, isA<Right<Failure, MovieDetailsEntity>>());
      },
    );

    test(
      'should return ServerFailure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockMoviesRemoteDataSource.getMovieDetails(movieId: tMovieId))
            .thenThrow(ServerException());

        // act
        final result =
            await movieRepositoryImpl.getMovieDetails(movieId: tMovieId);

        // assert
        expect(
            result, equals(const Left(ServerFailure('An error has occurred'))));
      },
    );
  });
}
