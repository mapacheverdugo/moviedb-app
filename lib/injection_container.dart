import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:moviedb/core/network/network_info.dart';
import 'package:moviedb/features/movies/data/data_sources/movies_local_data_source.dart';
import 'package:moviedb/features/movies/data/data_sources/movies_remote_data_source.dart';
import 'package:moviedb/features/movies/data/models/movie_details_model.dart';
import 'package:moviedb/features/movies/data/models/movie_model.dart';
import 'package:moviedb/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:moviedb/features/movies/domain/repositories/movie_repository.dart';
import 'package:moviedb/features/movies/domain/usecases/get_movie_details.dart';
import 'package:moviedb/features/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:moviedb/features/movies/domain/usecases/get_top_movies_usecase.dart';
import 'package:moviedb/features/movies/presentation/blocs/movie_details/movie_details_bloc.dart';
import 'package:moviedb/features/movies/presentation/blocs/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:moviedb/features/movies/presentation/blocs/top_movies_bloc/top_movies_bloc.dart';
import 'package:moviedb/features/search/data/data_sources/search_local_data_source.dart';
import 'package:moviedb/features/search/data/data_sources/search_remote_data_source.dart';
import 'package:moviedb/features/search/data/repositories/search_repository_impl.dart';
import 'package:moviedb/features/search/domain/repositories/search_repository.dart';
import 'package:moviedb/features/search/domain/usecases/search_usecase.dart';
import 'package:moviedb/features/search/presentation/blocs/search_bloc/search_bloc.dart';
import 'package:moviedb/features/watchlist/data/data_sources/watchlist_local_data_source.dart';
import 'package:moviedb/features/watchlist/data/models/watchlist_item_model.dart';
import 'package:moviedb/features/watchlist/data/repositories/watchlist_repository_impl.dart';
import 'package:moviedb/features/watchlist/domain/repositories/watchlist_repository.dart';
import 'package:moviedb/features/watchlist/domain/usecases/add_watchlist_item_usecase.dart';
import 'package:moviedb/features/watchlist/domain/usecases/check_watchlist_item_usecase.dart';
import 'package:moviedb/features/watchlist/domain/usecases/get_watchlist_items_usecase.dart';
import 'package:moviedb/features/watchlist/domain/usecases/remove_watchlist_item_usecase.dart';
import 'package:moviedb/features/watchlist/presentation/blocs/watchlist_bloc/watchlist_bloc.dart';
import 'package:moviedb/features/watchlist/presentation/blocs/watchlist_item_checker_bloc/watchlist_item_checker_bloc.dart';
import 'package:path_provider/path_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features
  _initMoviesFeature();
  _initSearchFeature();
  _initWatchListFeature();

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [
      WatchListItemModelSchema,
      MovieModelSchema,
      MovieDetailsModelSchema,
    ],
    directory: dir.path,
  );
  sl.registerLazySingleton(() => isar);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
}

void _initMoviesFeature() {
  // Bloc
  sl.registerFactory(
    () => PopularMoviesBloc(sl()),
  );
  sl.registerFactory(
    () => TopMoviesBloc(sl()),
  );
  sl.registerFactory(
    () => MovieDetailsBloc(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetPopularMoviesUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetTopMoviesUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetMovieDetailsUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<MoviesRemoteDataSource>(
    () => MoviesRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<MoviesLocalDataSource>(
    () => MoviesLocalDataSourceImpl(sl()),
  );
}

void _initSearchFeature() {
  // Bloc
  sl.registerFactory(
    () => SearchBloc(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => SearchUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<SearchRepository>(
    () => SearchRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<SearchLocalDataSource>(
    () => SearchLocalDataSourceImpl(sl()),
  );
}

void _initWatchListFeature() {
  // Bloc
  sl.registerFactory(
    () => WatchlistBloc(
      addWatchListItemUseCase: sl(),
      removeWatchListItemUseCase: sl(),
      getWatchListItemsUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => WatchlistItemCheckerBloc(
      checkWatchlistItem: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetWatchListItemsUseCase(repository: sl()));
  sl.registerLazySingleton(() => AddWatchListItemUseCase(repository: sl()));
  sl.registerLazySingleton(() => RemoveWatchListItemUseCase(repository: sl()));
  sl.registerLazySingleton(() => CheckWatchListItemUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<WatchListRepository>(
    () => WatchListRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<WatchListLocalDataSource>(
    () => WatchListLocalDataSourceImpl(sl()),
  );
}
