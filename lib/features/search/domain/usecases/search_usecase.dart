import 'package:dartz/dartz.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/domain/usecases/usecase.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/features/search/domain/repositories/search_repository.dart';

class SearchUseCase extends UseCase<List<MovieEntity>, SearchUseCaseParams> {
  final SearchRepository repository;

  SearchUseCase({required this.repository});

  @override
  Future<Either<Failure, List<MovieEntity>>> call(
      SearchUseCaseParams params) async {
    return await repository.search(
      query: params.query,
      page: params.page,
    );
  }
}

class SearchUseCaseParams {
  final String query;
  final int page;

  SearchUseCaseParams({
    required this.query,
    this.page = 1,
  });
}
