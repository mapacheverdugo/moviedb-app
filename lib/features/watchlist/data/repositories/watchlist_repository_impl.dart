import 'package:dartz/dartz.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/features/watchlist/data/data_sources/watchlist_local_data_source.dart';
import 'package:moviedb/features/watchlist/data/models/watchlist_item_model.dart';
import 'package:moviedb/features/watchlist/domain/repositories/watchlist_repository.dart';

class WatchListRepositoryImpl extends WatchListRepository {
  final WatchListLocalDataSource _localDataSource;

  WatchListRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, List<MovieEntity>>> getWatchListItems() async {
    try {
      final watchList = await _localDataSource.getWatchListItems();
      return Right(watchList.map((e) => e).toList());
    } catch (e) {
      return const Left(CacheFailure('An error has occurred'));
    }
  }

  @override
  Future<Either<Failure, int>> addWatchListItem(MovieEntity movie) async {
    try {
      final result = await _localDataSource
          .addWatchListItem(WatchListItemModel.fromEntity(movie));
      return Right(result);
    } catch (e) {
      return const Left(CacheFailure('An error has occurred'));
    }
  }

  @override
  Future<Either<Failure, bool>> removeWatchListItem(int tmdbId) async {
    try {
      await _localDataSource.removeWatchListItem(tmdbId);
      return const Right(true);
    } catch (e) {
      return const Left(CacheFailure('An error has occurred'));
    }
  }

  @override
  Future<Either<Failure, bool>> checkIfAdded(int tmdbId) async {
    try {
      final result = await _localDataSource.isItemAdded(tmdbId);
      return Right(result);
    } catch (e) {
      return const Left(CacheFailure('An error has occurred'));
    }
  }
}
