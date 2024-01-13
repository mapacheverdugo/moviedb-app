import 'package:flutter/widgets.dart';

class MoviePoster extends StatelessWidget {
  final String url;
  final double width;
  final double height;

  const MoviePoster({
    super.key,
    required this.url,
    this.width = 95,
    this.height = 120,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        url,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
