import 'package:dartz/dartz.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/features/movies/domain/entities/movie.dart';
import 'package:moviedb/features/movies/domain/entities/movie_details.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getMovies();
  Future<Either<Failure, MovieDetailsEntity>> getMovieDetails(
      {required int movieId});
}
