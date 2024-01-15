import 'package:cached_network_image/cached_network_image.dart';
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
      child: CachedNetworkImage(
        imageUrl: url,
        errorWidget: (context, url, error) => Image.asset(
          "assets/images/poster_placeholder.png",
          fit: BoxFit.cover,
          height: height,
          width: double.infinity,
        ),
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
