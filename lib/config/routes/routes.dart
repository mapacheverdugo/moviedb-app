import 'package:flutter/material.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/features/movies/presentation/pages/movie_details_page.dart';
import 'package:moviedb/features/movies/presentation/pages/movies_page.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/movie_details':
        return _materialRoute(
          MovieDetailsPage(baseMovie: settings.arguments as MovieEntity),
        );

      default:
        return _materialRoute(const MoviesPage());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
