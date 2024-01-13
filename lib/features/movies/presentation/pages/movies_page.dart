import 'package:flutter/material.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Text('Test'),
          Text('Overview'),
          Text('1'),
          Text('2021-01-01'),
          Text('test.jpg'),
          Text('test.jpg'),
          Text('1'),
          Text('1'),
          Text('2'),
        ],
      )),
    );
  }
}
