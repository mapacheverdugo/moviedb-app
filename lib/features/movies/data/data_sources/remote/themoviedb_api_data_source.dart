import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moviedb/core/constants/constants.dart';
import 'package:moviedb/core/error/exception.dart';
import 'package:moviedb/features/movies/data/models/movie_model.dart';

abstract class TheMovieDbApiDataSource {
  Future<List<MovieModel>> getMovies();
}

class TheMovieDbApiDataSourceImpl extends TheMovieDbApiDataSource {
  final http.Client _client;

  TheMovieDbApiDataSourceImpl(this._client);

  @override
  Future<List<MovieModel>> getMovies() async {
    final response =
        await _client.get(Uri.parse(TheMovieDbConstants.popularUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseJson = jsonDecode(response.body);
      final results = List<Map<String, dynamic>>.from(responseJson['results']);
      return results.map((e) => MovieModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
