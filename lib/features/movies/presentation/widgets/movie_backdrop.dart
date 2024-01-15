import 'package:flutter/widgets.dart';

class MovieBackdrop extends StatelessWidget {
  const MovieBackdrop({
    super.key,
    required this.url,
    this.height = 200,
  });

  final String url;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
      child: Image.network(
        url,
        fit: BoxFit.cover,
        height: height,
        width: double.infinity,
      ),
    );
  }
}
