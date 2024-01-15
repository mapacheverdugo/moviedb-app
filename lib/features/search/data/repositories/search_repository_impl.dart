import 'package:dartz/dartz.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/error/exception.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/core/network/network_info.dart';
import 'package:moviedb/features/search/data/data_sources/search_local_data_source.dart';
import 'package:moviedb/features/search/data/data_sources/search_remote_data_source.dart';
import 'package:moviedb/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;
  final SearchLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SearchRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<MovieEntity>>> search({
    required String query,
    int page = 1,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final movies = await remoteDataSource.search(
          query: query,
          page: page,
        );
        await localDataSource.cacheSearchItems(movies);
        return Right(movies.map((e) => e.toEntity()).toList());
      } on ServerException {
        return const Left(ServerFailure('An error has occurred'));
      }
    } else {
      try {
        final movies = await localDataSource.search(
          query: query,
          page: page,
        );

        return Right(movies);
      } on CacheException {
        return const Left(CacheFailure("An error has occurred"));
      }
    }
  }
}
