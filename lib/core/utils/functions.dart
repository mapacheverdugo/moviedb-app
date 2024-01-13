import 'package:moviedb/core/constants/constants.dart';

String getPosterUrl(String? path) {
  if (path != null) {
    return TheMovieDbConstants.basePosterUrl + path;
  } else {
    return TheMovieDbConstants.moviePlaceHolder;
  }
}

String getBackdropUrl(String? path) {
  if (path != null) {
    return TheMovieDbConstants.baseBackdropUrl + path;
  } else {
    return TheMovieDbConstants.moviePlaceHolder;
  }
}
