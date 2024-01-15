import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'genre.g.dart';

@Embedded(ignore: {'props'})
class GenreEntity extends Equatable {
  final int id;
  final String name;

  const GenreEntity({
    this.id = 0,
    this.name = "",
  });

  @override
  List<Object?> get props => [id, name];
}
