import 'package:dartz/dartz.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/domain/usecases/usecase.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/features/watchlist/domain/repositories/watchlist_repository.dart';

class AddWatchListItemUseCase extends UseCase<int, MovieEntity> {
  final WatchListRepository repository;

  AddWatchListItemUseCase({required this.repository});

  @override
  Future<Either<Failure, int>> call(MovieEntity params) async {
    return await repository.addWatchListItem(params);
  }
}
