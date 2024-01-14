import 'package:dartz/dartz.dart';
import 'package:moviedb/core/domain/usecases/usecase.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/features/watchlist/domain/repositories/watchlist_repository.dart';

class CheckWatchListItemUseCase extends UseCase<bool, int> {
  final WatchListRepository repository;

  CheckWatchListItemUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(int params) async {
    return await repository.checkIfAdded(params);
  }
}
