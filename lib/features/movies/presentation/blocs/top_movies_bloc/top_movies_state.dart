part of 'top_movies_bloc.dart';

sealed class TopMoviesState extends Equatable {
  final List<MovieEntity> movies;

  const TopMoviesState({
    this.movies = const <MovieEntity>[],
  });

  @override
  List<Object> get props => [movies];
}

final class TopMoviesInitial extends TopMoviesState {}

final class TopMoviesLoading extends TopMoviesState {
  const TopMoviesLoading({super.movies});

  @override
  List<Object> get props => [movies];
}

final class TopMoviesError extends TopMoviesState {
  final String message;

  const TopMoviesError({required this.message});

  @override
  List<Object> get props => [message];
}

final class TopMoviesLoaded extends TopMoviesState {
  const TopMoviesLoaded({required super.movies});

  @override
  List<Object> get props => [movies];
}

final class TopMoviesNoMoreResults extends TopMoviesState {
  const TopMoviesNoMoreResults({required super.movies});

  @override
  List<Object> get props => [movies];
}
