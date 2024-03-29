// Mocks generated by Mockito 5.4.4 from annotations
// in moviedb/test/features/search/data/repositories/search_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:moviedb/core/network/network_info.dart' as _i6;
import 'package:moviedb/features/search/data/data_sources/search_local_data_source.dart'
    as _i5;
import 'package:moviedb/features/search/data/data_sources/search_remote_data_source.dart'
    as _i2;
import 'package:moviedb/features/search/data/models/search_result_item_model.dart'
    as _i4;

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

/// A class which mocks [SearchRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchRemoteDataSource extends _i1.Mock
    implements _i2.SearchRemoteDataSource {
  MockSearchRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.SearchResultItemModel>> search({
    required String? query,
    int? page = 1,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #search,
          [],
          {
            #query: query,
            #page: page,
          },
        ),
        returnValue: _i3.Future<List<_i4.SearchResultItemModel>>.value(
            <_i4.SearchResultItemModel>[]),
      ) as _i3.Future<List<_i4.SearchResultItemModel>>);
}

/// A class which mocks [SearchLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchLocalDataSource extends _i1.Mock
    implements _i5.SearchLocalDataSource {
  MockSearchLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.SearchResultItemModel>> search({
    required String? query,
    int? page = 1,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #search,
          [],
          {
            #query: query,
            #page: page,
          },
        ),
        returnValue: _i3.Future<List<_i4.SearchResultItemModel>>.value(
            <_i4.SearchResultItemModel>[]),
      ) as _i3.Future<List<_i4.SearchResultItemModel>>);

  @override
  _i3.Future<void> cacheSearchItems(List<_i4.SearchResultItemModel>? items) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheSearchItems,
          [items],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i6.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
}
