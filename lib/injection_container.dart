import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:moviedb/features/movies/data/data_sources/movies_remote_data_source.dart';
import 'package:moviedb/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:moviedb/features/movies/domain/repositories/movie_repository.dart';
import 'package:moviedb/features/movies/domain/usecases/get_movie_details.dart';
import 'package:moviedb/features/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:moviedb/features/movies/presentation/blocs/movie_details/movie_details_bloc.dart';
import 'package:moviedb/features/movies/presentation/blocs/movies_bloc/movies_bloc.dart';
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
  _initMovieFeature();
  _initSearchFeature();
  _initWatchListFeature();

  // External
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [WatchListItemModelSchema],
    directory: dir.path,
  );
  sl.registerLazySingleton(() => isar);
  sl.registerLazySingleton(() => http.Client());
}

void _initMovieFeature() {
  // Bloc
  sl.registerFactory(
    () => MoviesBloc(sl()),
  );
  sl.registerFactory(
    () => MovieDetailsBloc(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetPopularMoviesUseCase(repository: sl()));
  sl.registerLazySingleton(() => GetMovieDetailsUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<MoviesRemoteDataSource>(
    () => MoviesRemoteDataSourceImpl(sl()),
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
    () => SearchRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<SearchRemoteDataSource>(
    () => SearchRemoteDataSourceImpl(sl()),
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
