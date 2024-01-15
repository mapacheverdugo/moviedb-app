import 'package:dartz/dartz.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/domain/usecases/usecase.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/features/movies/domain/repositories/movie_repository.dart';

class GetTopMoviesUseCase extends UseCase<List<MovieEntity>, int> {
  final MovieRepository repository;

  GetTopMoviesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<MovieEntity>>> call(int params) async {
    return await repository.getTopMovies(page: params);
  }
}
