part of 'movies_bloc.dart';

sealed class MoviesState extends Equatable {
  final List<MovieEntity> popularMovies;

  const MoviesState({
    this.popularMovies = const <MovieEntity>[],
  });

  @override
  List<Object> get props => [popularMovies];
}

final class MoviesInitial extends MoviesState {}

final class MoviesLoading extends MoviesState {}

final class MoviesError extends MoviesState {
  final String message;

  const MoviesError({required this.message});

  @override
  List<Object> get props => [message];
}

final class MoviesLoaded extends MoviesState {
  const MoviesLoaded({required super.popularMovies});

  @override
  List<Object> get props => [popularMovies];
}
