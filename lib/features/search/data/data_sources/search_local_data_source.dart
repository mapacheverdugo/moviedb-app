import 'package:isar/isar.dart';
import 'package:moviedb/core/error/exception.dart';
import 'package:moviedb/features/movies/data/models/movie_model.dart';
import 'package:moviedb/features/search/data/models/search_result_item_model.dart';

abstract class SearchLocalDataSource {
  Future<List<SearchResultItemModel>> search({
    required String query,
    int page = 1,
  });

  Future<void> cacheSearchItems(List<SearchResultItemModel> items);
}

class SearchLocalDataSourceImpl extends SearchLocalDataSource {
  static const _itemsPerPage = 20;

  late final Isar _isar;
  IsarCollection<MovieModel> get _moviesBox => _isar.movieModels;

  SearchLocalDataSourceImpl(this._isar);

  @override
  Future<List<SearchResultItemModel>> search({
    required String query,
    int page = 1,
  }) async {
    try {
      final movies = await _moviesBox
          .filter()
          .titleContains(query)
          .offset(_itemsPerPage * (page - 1))
          .limit(_itemsPerPage)
          .findAll();
      return movies
          .map((m) => SearchResultItemModel.fromEntity(m.toEntity()))
          .toList();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheSearchItems(List<SearchResultItemModel> items) {
    try {
      return _isar.writeTxn(() {
        return _moviesBox.putAll(
            items.map((e) => MovieModel.fromEntity(e.toEntity())).toList());
      });
    } catch (e) {
      throw CacheException();
    }
  }
}
