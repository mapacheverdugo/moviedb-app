import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb/features/movies/domain/entities/movie.dart';
import 'package:moviedb/features/movies/domain/usecases/get_popular_movies_usecase.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetPopularMoviesUseCase _getPopularMoviesUseCase;

  bool isLastPage = false;
  int page = 1;

  MoviesBloc(this._getPopularMoviesUseCase) : super(MoviesInitial()) {
    on<GetMoviesEvent>((event, emit) async {
      emit(MoviesLoading());
      final failureOrMovies = await _getPopularMoviesUseCase(page);
      failureOrMovies.fold(
        (failure) => emit(MoviesError(message: failure.message)),
        (popularMovies) {
          page++;

          emit(MoviesLoaded(popularMovies: popularMovies));
        },
      );
    });

    on<LoadMoreMoviesEvent>((event, emit) async {
      if (isLastPage) {
        return;
      }
      final failureOrMovies = await _getPopularMoviesUseCase(page);
      failureOrMovies.fold(
        (failure) => emit(MoviesError(message: failure.message)),
        (morePopularMovies) {
          if (morePopularMovies.isEmpty) {
            isLastPage = true;
          } else {
            page++;
            emit(
              MoviesLoaded(
                popularMovies: state.popularMovies + morePopularMovies,
              ),
            );
          }
        },
      );
    });
  }
}
