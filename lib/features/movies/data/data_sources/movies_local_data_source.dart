import 'package:isar/isar.dart';
import 'package:moviedb/core/error/exception.dart';
import 'package:moviedb/features/movies/data/models/movie_details_model.dart';
import 'package:moviedb/features/movies/data/models/movie_model.dart';

abstract class MoviesLocalDataSource {
  Future<List<MovieModel>> getPopularMovies({int page = 1});
  Future<List<MovieModel>> getTopMovies({int page = 1});
  Future<MovieDetailsModel> getMovieDetails({required int tmdbId});
  Future<void> cacheMovies({required List<MovieModel> movies});
  Future<void> cacheMovieDetail(MovieDetailsModel movie);
}

class MoviesLocalDataSourceImpl extends MoviesLocalDataSource {
  static const _itemsPerPage = 20;

  late final Isar _isar;
  IsarCollection<MovieModel> get _moviesBox => _isar.movieModels;
  IsarCollection<MovieDetailsModel> get _movieDetailsBox =>
      _isar.movieDetailsModels;

  MoviesLocalDataSourceImpl(this._isar);

  @override
  Future<List<MovieModel>> getPopularMovies({int page = 1}) async {
    try {
      return _moviesBox
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
      return _moviesBox
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
        return _moviesBox.putAll(movies);
      });
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheMovieDetail(MovieDetailsModel movie) {
    try {
      return _isar.writeTxn(() {
        return _movieDetailsBox.put(movie);
      });
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails({required int tmdbId}) async {
    try {
      final result =
          await _movieDetailsBox.filter().tmdbIdEqualTo(tmdbId).findFirst();
      if (result == null) {
        throw CacheException();
      }
      return result;
    } catch (e) {
      throw CacheException();
    }
  }
}
