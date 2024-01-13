import 'package:dartz/dartz.dart';
import 'package:moviedb/core/domain/usecases/usecase.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/features/movies/domain/entities/movie_details.dart';
import 'package:moviedb/features/movies/domain/repositories/movie_repository.dart';

class GetMovieDetailsUseCase extends UseCase<MovieDetailsEntity, int> {
  final MovieRepository repository;

  GetMovieDetailsUseCase({required this.repository});

  @override
  Future<Either<Failure, MovieDetailsEntity>> call(int params) async {
    return await repository.getMovieDetails(movieId: params);
  }
}
