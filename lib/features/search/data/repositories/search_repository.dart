import 'package:dartz/dartz.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/error/exception.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/features/search/data/data_sources/search_remote_data_source.dart';
import 'package:moviedb/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource _remoteDataSource;

  SearchRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<MovieEntity>>> search(
      {required String query}) async {
    try {
      final movies = await _remoteDataSource.search(query: query);
      return Right(movies.map((e) => e.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    }
  }
}
