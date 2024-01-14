import 'package:dartz/dartz.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/domain/usecases/usecase.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/features/watchlist/domain/repositories/watchlist_repository.dart';

class GetWatchListItemsUseCase
    extends UseCase<List<MovieEntity>, NoParameters> {
  final WatchListRepository repository;

  GetWatchListItemsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<MovieEntity>>> call(NoParameters params) async {
    return await repository.getWatchListItems();
  }
}
