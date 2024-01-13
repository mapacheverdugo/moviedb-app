import 'package:dartz/dartz.dart';
import 'package:moviedb/core/domain/usecases/usecase.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/features/movies/domain/entities/movie.dart';
import 'package:moviedb/features/movies/domain/repositories/movie_repository.dart';

class GetMoviesUseCase extends UseCase<List<MovieEntity>, NoParameters> {
  final MovieRepository repository;

  GetMoviesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<MovieEntity>>> call(NoParameters params) async {
    return await repository.getMovies();
  }
}
