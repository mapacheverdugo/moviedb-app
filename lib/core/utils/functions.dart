import 'package:moviedb/core/constants/constants.dart';

String getPosterUrl(String? path) {
  if (path != null) {
    const baseUrl = TheMovieDbConstants.basePosterUrl;
    if (path.startsWith(baseUrl)) {
      return path;
    }
    return baseUrl + path;
  } else {
    return TheMovieDbConstants.moviePlaceHolder;
  }
}

String getBackdropUrl(String? path) {
  if (path != null) {
    const baseUrl = TheMovieDbConstants.baseBackdropUrl;
    if (path.startsWith(baseUrl)) {
      return path;
    }
    return baseUrl + path;
  } else {
    return TheMovieDbConstants.moviePlaceHolder;
  }
}

String getAvatarUrl(String? path) {
  if (path != null) {
    const baseUrl = TheMovieDbConstants.baseAvatarUrl;
    if (path.startsWith(baseUrl)) {
      return path;
    }
    return baseUrl + path;
  } else {
    return TheMovieDbConstants.avatarPlaceholder;
  }
}
