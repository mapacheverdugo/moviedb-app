import 'package:moviedb/core/utils/objectbox.dart';
import 'package:moviedb/features/watchlist/data/models/watchlist_item_model.dart';
import 'package:moviedb/objectbox.g.dart';

abstract class WatchListLocalDataSource {
  Future<List<WatchListItemModel>> getWatchListItems();
  Future<int> addWatchListItem(WatchListItemModel item);
  Future<void> removeWatchListItem(int id);
  Future<bool> isItemAdded(int id);
}

class WatchListLocalDataSourceImpl extends WatchListLocalDataSource {
  final ObjectBox _objectBox;

  late Box<WatchListItemModel> _box;

  WatchListLocalDataSourceImpl(this._objectBox) {
    _box = _objectBox.store.box<WatchListItemModel>();
  }

  @override
  Future<List<WatchListItemModel>> getWatchListItems() async {
    return _box.getAllAsync();
  }

  @override
  Future<int> addWatchListItem(WatchListItemModel item) async {
    return _box.put(item);
  }

  @override
  Future<void> removeWatchListItem(int id) async {
    _box.remove(id);
  }

  @override
  Future<bool> isItemAdded(int id) async {
    final values = await _box.getAllAsync();
    return values.toList().indexWhere((e) => e.id == id) > -1;
  }
}
