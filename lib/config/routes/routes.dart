import 'package:flutter/material.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/features/movies/presentation/pages/movie_details_page.dart';
import 'package:moviedb/features/movies/presentation/pages/movies_page.dart';
import 'package:moviedb/features/search/presentation/pages/search_page.dart';
import 'package:moviedb/features/watchlist/presentation/pages/watchlist_page.dart';
import 'package:page_transition/page_transition.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/movie_details':
        return _routeBuilder(
          MovieDetailsPage(baseMovie: settings.arguments as MovieEntity),
        );
      case '/watchlist':
        return _routeBuilder(WatchlistPage());
      case '/search':
        return _routeBuilder(const SearchPage());
      default:
        return _routeBuilder(const MoviesPage());
    }
  }

  static Route<dynamic> _routeBuilder(Widget page) {
    return PageTransition(
      child: page,
      type: PageTransitionType.fade,
    );
  }
}
