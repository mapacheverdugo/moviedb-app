import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb/features/movies/domain/entities/movie_details.dart';
import 'package:moviedb/features/movies/domain/usecases/get_movie_details.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final GetMovieDetailsUseCase _getMovieDetailsUseCase;

  MovieDetailsBloc(this._getMovieDetailsUseCase)
      : super(MovieDetailsInitial()) {
    on<MovieDetailsEvent>((event, emit) async {
      if (event is GetMovieDetailsEvent) {
        emit(MovieDetailsLoading());
        final failureOrMovies = await _getMovieDetailsUseCase(event.movieId);
        failureOrMovies.fold(
          (failure) => emit(MovieDetailsError(message: failure.message)),
          (movieDetails) =>
              emit(MovieDetailsLoaded(movieDetails: movieDetails)),
        );
      }
    });
  }
}
