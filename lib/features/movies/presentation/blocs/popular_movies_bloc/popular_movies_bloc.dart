import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/features/movies/domain/usecases/get_popular_movies_usecase.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMoviesUseCase _getPopularMoviesUseCase;

  bool isLastPage = false;
  int page = 1;

  PopularMoviesBloc(this._getPopularMoviesUseCase)
      : super(PopularMoviesInitial()) {
    on<GetPopularMoviesEvent>((event, emit) async {
      isLastPage = false;
      page = 1;
      emit(PopularMoviesLoading(movies: state.movies));
      final failureOrMovies = await _getPopularMoviesUseCase(page);
      failureOrMovies.fold(
        (failure) => emit(PopularMoviesError(message: failure.message)),
        (movies) {
          page++;

          emit(PopularMoviesLoaded(movies: movies));
        },
      );
    });

    on<LoadMorePopularMoviesEvent>((event, emit) async {
      if (isLastPage) {
        emit(PopularMoviesNoMoreResults(movies: state.movies));
        return;
      }
      final failureOrMovies = await _getPopularMoviesUseCase(page);
      failureOrMovies.fold(
        (failure) => emit(PopularMoviesError(message: failure.message)),
        (morePopularMovies) {
          if (morePopularMovies.isEmpty) {
            isLastPage = true;
            emit(PopularMoviesNoMoreResults(movies: state.movies));
          } else {
            page++;
            emit(
              PopularMoviesLoaded(
                movies: state.movies + morePopularMovies,
              ),
            );
          }
        },
      );
    });
  }
}
