import 'package:dartz/dartz.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/error/failure.dart';

abstract class WatchListRepository {
  Future<Either<Failure, List<MovieEntity>>> getWatchListItems();
  Future<Either<Failure, int>> addWatchListItem(MovieEntity movie);
  Future<Either<Failure, bool>> removeWatchListItem(int id);
  Future<Either<Failure, bool>> checkIfAdded(int id);
}
