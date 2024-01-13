part of 'movies_bloc.dart';

sealed class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
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
  final List<MovieEntity> movies;

  const MoviesLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}
