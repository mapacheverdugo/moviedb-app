enum MoviesCategory { topRated, popular }

extension MoviesCategoryExtension on MoviesCategory {
  String get name {
    switch (this) {
      case MoviesCategory.topRated:
        return 'Top Rated';
      case MoviesCategory.popular:
        return 'Popular';
    }
  }

  int get index {
    switch (this) {
      case MoviesCategory.topRated:
        return 0;
      case MoviesCategory.popular:
        return 1;
    }
  }
}
