import 'package:flutter/widgets.dart';

class AppConstants {
  static const pagePadding = EdgeInsets.symmetric(
    vertical: 31,
    horizontal: 29,
  );
  static const movieListTilePadding = EdgeInsets.symmetric(
    vertical: 9,
    horizontal: 9,
  );
  static const footerButtonsHeight = 42.0;
}

class TheMovieDbConstants {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String apiToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjNWY3YmUyOTQxYjY0ZmY3MTkzMjhlN2Y0NTg1NzM4MCIsInN1YiI6IjY1YTE5YTBjMWI1YWU1MDEyNjczODFkNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.MRXujJvNA6B3WthG48CkaU-Hbw_0A50uZk8QuhnLBxw";
  static const Map<String, String> apiStaticHeaders = <String, String>{
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiToken',
  };

  static const String baseBackdropUrl = 'https://image.tmdb.org/t/p/w1280';
  static const String basePosterUrl = 'https://image.tmdb.org/t/p/w500';
  static const String baseAvatarUrl = 'https://image.tmdb.org/t/p/w185';

  static const String moviePlaceHolder =
      'https://github.com/mapacheverdugo/mapacheverdugo/assets/16374322/eb88b766-7773-43cf-a655-fdb4e7d61013';

  static const String avatarPlaceholder =
      'https://github.com/mapacheverdugo/mapacheverdugo/assets/16374322/193019ca-4124-49df-8613-6ddc89a19207';

  static String _getPopularMoviesPath(int page) {
    return '/movie/popular?page=$page';
  }

  static String getPopularMoviesUrl(int page) {
    return baseUrl + _getPopularMoviesPath(page);
  }

  static String _getMovieDetailsPath(int movieId) {
    return '/movie/$movieId?append_to_response=reviews';
  }

  static String getMovieDetailsUrl(int movieId) {
    return baseUrl + _getMovieDetailsPath(movieId);
  }

  static String _getSearchMoviePath(String query, {int page = 1}) {
    return '/search/movie?query=$query&page=$page';
  }

  static String getSearchMovieUrl(String query, {int page = 1}) {
    return baseUrl + _getSearchMoviePath(query, page: page);
  }
}
