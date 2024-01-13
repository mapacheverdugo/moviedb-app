import 'package:flutter/material.dart';
import 'package:moviedb/features/movies/presentation/pages/movies_page.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      /* case '/movie-details':
        return _materialRoute(
            MoviesDetailsPage(article: settings.arguments as MovieDetailsEntity)); */

      default:
        return _materialRoute(const MoviesPage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
