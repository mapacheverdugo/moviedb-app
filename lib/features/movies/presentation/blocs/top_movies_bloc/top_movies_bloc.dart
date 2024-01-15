import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/features/movies/domain/usecases/get_top_movies_usecase.dart';

part 'top_movies_event.dart';
part 'top_movies_state.dart';

class TopMoviesBloc extends Bloc<TopMoviesEvent, TopMoviesState> {
  final GetTopMoviesUseCase _getTopMoviesUseCase;

  bool isLastPage = false;
  int page = 1;

  TopMoviesBloc(this._getTopMoviesUseCase) : super(TopMoviesInitial()) {
    on<GetTopMoviesEvent>((event, emit) async {
      isLastPage = false;
      page = 1;
      emit(TopMoviesLoading(movies: state.movies));
      final failureOrMovies = await _getTopMoviesUseCase(page);
      failureOrMovies.fold(
        (failure) => emit(TopMoviesError(message: failure.message)),
        (movies) {
          page++;

          emit(TopMoviesLoaded(movies: movies));
        },
      );
    });

    on<LoadMoreTopMoviesEvent>((event, emit) async {
      if (isLastPage) {
        emit(TopMoviesNoMoreResults(movies: state.movies));
        return;
      }
      final failureOrMovies = await _getTopMoviesUseCase(page);
      failureOrMovies.fold(
        (failure) => emit(TopMoviesError(message: failure.message)),
        (moreTopMovies) {
          if (moreTopMovies.isEmpty) {
            isLastPage = true;
            emit(TopMoviesNoMoreResults(movies: state.movies));
          } else {
            page++;
            emit(
              TopMoviesLoaded(
                movies: state.movies + moreTopMovies,
              ),
            );
          }
        },
      );
    });
  }
}
