import 'package:flutter/material.dart';
import 'package:moviedb/features/movies/presentation/pages/movies_page.dart';

import 'injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(const MovieDbApp());
}

class MovieDbApp extends StatelessWidget {
  const MovieDbApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieDB',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MoviesPage(),
    );
  }
}
