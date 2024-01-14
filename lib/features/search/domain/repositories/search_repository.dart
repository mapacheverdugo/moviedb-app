import 'package:dartz/dartz.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/error/failure.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<MovieEntity>>> search({
    required String query,
    int page = 1,
  });
}
