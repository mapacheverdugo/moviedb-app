part of 'popular_movies_bloc.dart';

sealed class PopularMoviesState extends Equatable {
  final List<MovieEntity> movies;

  const PopularMoviesState({
    this.movies = const <MovieEntity>[],
  });

  @override
  List<Object> get props => [movies];
}

final class PopularMoviesInitial extends PopularMoviesState {}

final class PopularMoviesLoading extends PopularMoviesState {
  const PopularMoviesLoading({super.movies});

  @override
  List<Object> get props => [movies];
}

final class PopularMoviesError extends PopularMoviesState {
  final String message;

  const PopularMoviesError({required this.message});

  @override
  List<Object> get props => [message];
}

final class PopularMoviesLoaded extends PopularMoviesState {
  const PopularMoviesLoaded({required super.movies});

  @override
  List<Object> get props => [movies];
}

final class PopularMoviesNoMoreResults extends PopularMoviesState {
  const PopularMoviesNoMoreResults({required super.movies});

  @override
  List<Object> get props => [movies];
}
