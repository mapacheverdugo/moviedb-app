import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviedb/config/routes/routes.dart';
import 'package:moviedb/config/theme/app_themes.dart';

import 'injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(const MovieDbApp());
}

class MovieDbApp extends StatelessWidget {
  const MovieDbApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: darkColorScheme().primary,
    ));

    return MaterialApp(
      title: 'MovieDB',
      theme: darkTheme(),
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
