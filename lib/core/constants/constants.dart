class TheMovieDbConstants {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String apiToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjNWY3YmUyOTQxYjY0ZmY3MTkzMjhlN2Y0NTg1NzM4MCIsInN1YiI6IjY1YTE5YTBjMWI1YWU1MDEyNjczODFkNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.MRXujJvNA6B3WthG48CkaU-Hbw_0A50uZk8QuhnLBxw";
  static const Map<String, dynamic> apiStaticHeaders = <String, dynamic>{
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiToken',
  };

  static const String popularPath = '/movie/popular';
  static const String popularUrl = baseUrl + popularPath;
}
