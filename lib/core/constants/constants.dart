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

  static const String moviePlaceHolder =
      'https://davidkoepp.com/wp-content/themes/blankslate/images/Movie%20Placeholder.jpg';

  static const String popularPath = '/movie/popular';
  static const String popularUrl = baseUrl + popularPath;

  static String getMovieDetailsPath(int movieId) {
    return '/movie/$movieId';
  }

  static String getMovieDetailsUrl(int movieId) {
    return baseUrl + getMovieDetailsPath(movieId);
  }
}
