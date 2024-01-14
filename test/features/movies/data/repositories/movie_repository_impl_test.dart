import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/error/exception.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/core/utils/functions.dart';
import 'package:moviedb/features/movies/data/data_sources/movies_remote_data_source.dart';
import 'package:moviedb/features/movies/data/models/movie_details_model.dart';
import 'package:moviedb/features/movies/data/models/movie_model.dart';
import 'package:moviedb/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:moviedb/features/movies/domain/entities/movie_details.dart';

import 'movie_repository_impl_test.mocks.dart';

@GenerateMocks([MoviesRemoteDataSource])
void main() {
  late MockMoviesRemoteDataSource mockMoviesRemoteDataSource;
  late MovieRepositoryImpl movieRepositoryImpl;

  setUp(() {
    mockMoviesRemoteDataSource = MockMoviesRemoteDataSource();
    movieRepositoryImpl = MovieRepositoryImpl(mockMoviesRemoteDataSource);
  });

  final tMovieModelList = [
    MovieModel(
      id: 1,
      title: 'Test',
      overview: 'Overview',
      voteAverage: 1,
      releaseDate: DateTime.parse('2021-01-01'),
      posterUrl: '/test.jpg',
      backdropUrl: '/test.jpg',
      voteCount: 1,
    )
  ];

  group('get popular movies', () {
    test(
      'should return movies when a call to data source is successful',
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
      'should return ServerFailure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockMoviesRemoteDataSource.getPopularMovies())
            .thenThrow(ServerException());

        // act
        final result = await movieRepositoryImpl.getPopularMovies();

        // assert
        expect(
            result, equals(const Left(ServerFailure('An error has occurred'))));
      },
    );
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

  group('get movie details', () {
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
