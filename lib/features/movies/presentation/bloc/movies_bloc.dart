import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/core/domain/usecases/usecase.dart';
import 'package:moviedb/features/movies/domain/usecases/get_movies_usecase.dart';

import 'movies_event.dart';
import 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetMoviesUseCase _getMoviesUseCase;

  MoviesBloc(this._getMoviesUseCase) : super(MoviesEmpty()) {
    on<GetMoviesEvent>((event, emit) async {
      emit(MoviesLoading());
      final failureOrMovies = await _getMoviesUseCase(const NoParameters());
      failureOrMovies.fold(
        (failure) => emit(MoviesError(message: failure.message)),
        (movies) => emit(MoviesLoaded(movies: movies)),
      );
    });
  }
}
