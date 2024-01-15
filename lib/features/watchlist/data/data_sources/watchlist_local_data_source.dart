import 'package:isar/isar.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/features/watchlist/data/models/watchlist_item_model.dart';

abstract class WatchListLocalDataSource {
  Future<List<MovieEntity>> getWatchListItems();
  Future<int> addWatchListItem(WatchListItemModel item);
  Future<void> removeWatchListItem(int tmdbId);
  Future<bool> isItemAdded(int tmdbId);
}

class WatchListLocalDataSourceImpl extends WatchListLocalDataSource {
  late final Isar _isar;
  IsarCollection<WatchListItemModel> get _box => _isar.watchListItemModels;

  WatchListLocalDataSourceImpl(this._isar);

  @override
  Future<List<MovieEntity>> getWatchListItems() async {
    final result = await _box.where(sort: Sort.desc).anyId().findAll();
    return result;
  }

  @override
  Future<int> addWatchListItem(WatchListItemModel item) async {
    final result = await _isar.writeTxn(() {
      return _box.put(item);
    });

    return result;
  }

  @override
  Future<void> removeWatchListItem(int tmdbId) async {
    await _isar.writeTxn(() {
      return _box.deleteByTmdbId(tmdbId);
    });
  }

  @override
  Future<bool> isItemAdded(int tmdbId) async {
    final item = await _box.filter().tmdbIdEqualTo(tmdbId).findFirst();
    return item?.isWatchlisted == true;
  }
}
