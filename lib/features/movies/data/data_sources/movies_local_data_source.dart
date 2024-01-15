import 'package:isar/isar.dart';
import 'package:moviedb/core/error/exception.dart';
import 'package:moviedb/features/movies/data/models/movie_model.dart';

abstract class MoviesLocalDataSource {
  Future<List<MovieModel>> getPopularMovies({int page = 1});
  Future<List<MovieModel>> getTopMovies({int page = 1});
  Future<void> cacheMovies({required List<MovieModel> movies});
}

class MoviesLocalDataSourceImpl extends MoviesLocalDataSource {
  static const _itemsPerPage = 20;

  late final Isar _isar;
  IsarCollection<MovieModel> get _box => _isar.movieModels;

  MoviesLocalDataSourceImpl(this._isar);

  @override
  Future<List<MovieModel>> getPopularMovies({int page = 1}) async {
    try {
      return _box
          .where()
          .sortByPopularityDesc()
          .offset(_itemsPerPage * (page - 1))
          .limit(_itemsPerPage)
          .findAll();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<List<MovieModel>> getTopMovies({int page = 1}) async {
    try {
      return _box
          .where()
          .sortByVoteAverageDesc()
          .offset(_itemsPerPage * (page - 1))
          .limit(_itemsPerPage)
          .findAll();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheMovies({required List<MovieModel> movies}) {
    try {
      return _isar.writeTxn(() {
        return _box.putAll(movies);
      });
    } catch (e) {
      throw CacheException();
    }
  }
}
