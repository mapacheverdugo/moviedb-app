import 'package:dartz/dartz.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/error/exception.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/core/network/network_info.dart';
import 'package:moviedb/features/movies/data/data_sources/movies_local_data_source.dart';
import 'package:moviedb/features/movies/data/data_sources/movies_remote_data_source.dart';
import 'package:moviedb/features/movies/data/models/movie_model.dart';
import 'package:moviedb/features/movies/domain/entities/movie_details.dart';
import 'package:moviedb/features/movies/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MoviesRemoteDataSource remoteDataSource;
  final MoviesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies(
      {int page = 1}) async {
    return _getMovies(category: _CategoryChooser.popular, page: page);
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getTopMovies(
      {int page = 1}) async {
    return _getMovies(category: _CategoryChooser.top, page: page);
  }

  @override
  Future<Either<Failure, MovieDetailsEntity>> getMovieDetails({
    required int movieId,
  }) async {
    try {
      final movieDetails =
          await remoteDataSource.getMovieDetails(movieId: movieId);
      return Right(movieDetails.toEntity());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    }
  }

  Future<Either<Failure, List<MovieEntity>>> _getMovies({
    required _CategoryChooser category,
    int page = 1,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        List<MovieEntity> movies = [];
        switch (category) {
          case _CategoryChooser.popular:
            movies = await remoteDataSource.getPopularMovies(page: page);
            break;
          case _CategoryChooser.top:
            movies = await remoteDataSource.getTopMovies(page: page);
            break;
        }
        localDataSource.cacheMovies(
            movies: movies.map((m) => MovieModel.fromEntity(m)).toList());
        return Right(movies);
      } on ServerException {
        return const Left(ServerFailure("An error has occurred"));
      }
    } else {
      try {
        List<MovieEntity> movies = [];
        switch (category) {
          case _CategoryChooser.popular:
            movies = await localDataSource.getPopularMovies(page: page);
            break;
          case _CategoryChooser.top:
            movies = await localDataSource.getTopMovies(page: page);
            break;
        }
        return Right(movies);
      } on CacheException {
        return const Left(CacheFailure("An error has occurred"));
      }
    }
  }
}

enum _CategoryChooser {
  popular,
  top,
}
