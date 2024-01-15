import 'package:flutter/material.dart';
import 'package:moviedb/features/movies/domain/entities/genre.dart';

class MovieGenresChips extends StatelessWidget {
  const MovieGenresChips({
    super.key,
    required this.genres,
    this.padding = EdgeInsets.zero,
  });

  final List<GenreEntity> genres;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return SizedBox(
      height: 32 + padding.vertical,
      width: mq.size.width,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: padding.horizontal / 2,
          vertical: padding.vertical / 2,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final genre = genres[index];
          return Chip(
            label: Text(genre.name),
          );
        },
      ),
    );
  }
}
