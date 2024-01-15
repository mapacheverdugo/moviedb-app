import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

void setStatusBarColor(Brightness brightness) {
  if (brightness == Brightness.dark) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
  } else {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }
}
