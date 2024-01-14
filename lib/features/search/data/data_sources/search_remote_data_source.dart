import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moviedb/core/constants/constants.dart';
import 'package:moviedb/core/error/exception.dart';
import 'package:moviedb/features/search/data/models/search_result_item_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<SearchResultItemModel>> search({required String query});
}

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  final http.Client _client;

  SearchRemoteDataSourceImpl(this._client);

  @override
  Future<List<SearchResultItemModel>> search({required String query}) async {
    final response = await _client.get(
      Uri.parse(TheMovieDbConstants.getSearchMovieUrl(query)),
      headers: TheMovieDbConstants.apiStaticHeaders,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseJson = jsonDecode(response.body);
      final results = List<Map<String, dynamic>>.from(responseJson['results']);
      return results.map((e) => SearchResultItemModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
