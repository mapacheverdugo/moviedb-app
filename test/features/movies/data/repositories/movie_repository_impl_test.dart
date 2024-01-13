import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/core/error/exception.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/features/movies/data/data_sources/remote/themoviedb_api_data_source.dart';
import 'package:moviedb/features/movies/data/models/movie_model.dart';
import 'package:moviedb/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:moviedb/features/movies/domain/entities/movie.dart';

import 'movie_repository_impl_test.mocks.dart';

@GenerateMocks([TheMovieDbApiDataSource])
void main() {
  late MockTheMovieDbApiDataSource mockTheMovieDbApiDataSource;
  late MovieRepositoryImpl movieRepositoryImpl;

  setUp(() {
    mockTheMovieDbApiDataSource = MockTheMovieDbApiDataSource();
    movieRepositoryImpl = MovieRepositoryImpl(mockTheMovieDbApiDataSource);
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

  group('get movies', () {
    test(
      'should return movies when a call to data source is successful',
      () async {
        // arrange
        when(mockTheMovieDbApiDataSource.getMovies())
            .thenAnswer((_) async => tMovieModelList);

        // act
        final result = await movieRepositoryImpl.getMovies();

        // assert
        verify(mockTheMovieDbApiDataSource.getMovies());
        expect(result, isA<Right<Failure, List<MovieEntity>>>());
      },
    );

    test(
      'should return ServerFailure when a call to data source is unsuccessful',
      () async {
        // arrange
        when(mockTheMovieDbApiDataSource.getMovies())
            .thenThrow(ServerException());

        // act
        final result = await movieRepositoryImpl.getMovies();

        // assert
        expect(
            result, equals(const Left(ServerFailure('An error has occurred'))));
      },
    );
  });
}
