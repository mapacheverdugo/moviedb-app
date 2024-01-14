import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class MovieEntity extends Equatable {
  @Id()
  final int id;
  final String title;
  final String posterUrl;
  final String backdropUrl;
  final DateTime? releaseDate;
  final String overview;
  final double voteAverage;
  final int voteCount;

  const MovieEntity({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.releaseDate,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
  });

  set id(int id) {
    id = id;
  }

  @override
  List<Object?> get props => [
        id,
        title,
        posterUrl,
        backdropUrl,
        releaseDate,
        overview,
        voteAverage,
        voteCount,
      ];
}
