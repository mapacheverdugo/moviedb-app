import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb/core/domain/usecases/usecase.dart';
import 'package:moviedb/features/movies/domain/entities/movie.dart';
import 'package:moviedb/features/movies/domain/usecases/get_movies_usecase.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetMoviesUseCase _getMoviesUseCase;

  MoviesBloc(this._getMoviesUseCase) : super(MoviesInitial()) {
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
