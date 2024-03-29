// Mocks generated by Mockito 5.4.4 from annotations
// in moviedb/test/features/watchlist/data/repositories/watchlist_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:moviedb/core/domain/entities/movie.dart' as _i4;
import 'package:moviedb/features/watchlist/data/data_sources/watchlist_local_data_source.dart'
    as _i2;
import 'package:moviedb/features/watchlist/data/models/watchlist_item_model.dart'
    as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [WatchListLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchListLocalDataSource extends _i1.Mock
    implements _i2.WatchListLocalDataSource {
  MockWatchListLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.MovieEntity>> getWatchListItems() => (super.noSuchMethod(
        Invocation.method(
          #getWatchListItems,
          [],
        ),
        returnValue:
            _i3.Future<List<_i4.MovieEntity>>.value(<_i4.MovieEntity>[]),
      ) as _i3.Future<List<_i4.MovieEntity>>);

  @override
  _i3.Future<int> addWatchListItem(_i5.WatchListItemModel? item) =>
      (super.noSuchMethod(
        Invocation.method(
          #addWatchListItem,
          [item],
        ),
        returnValue: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);

  @override
  _i3.Future<void> removeWatchListItem(int? tmdbId) => (super.noSuchMethod(
        Invocation.method(
          #removeWatchListItem,
          [tmdbId],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<bool> isItemAdded(int? tmdbId) => (super.noSuchMethod(
        Invocation.method(
          #isItemAdded,
          [tmdbId],
        ),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
}
