import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb/core/domain/usecases/usecase.dart';
import 'package:moviedb/features/movies/domain/entities/movie.dart';
import 'package:moviedb/features/movies/domain/usecases/get_popular_movies_usecase.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetPopularMoviesUseCase _getPopularMoviesUseCase;

  MoviesBloc(this._getPopularMoviesUseCase) : super(MoviesInitial()) {
    on<GetMoviesEvent>((event, emit) async {
      emit(MoviesLoading());
      final failureOrMovies =
          await _getPopularMoviesUseCase(const NoParameters());
      failureOrMovies.fold(
        (failure) => emit(MoviesError(message: failure.message)),
        (popularMovies) => emit(MoviesLoaded(popularMovies: popularMovies)),
      );
    });
  }
}
