import 'package:equatable/equatable.dart';
import 'package:moviedb/features/movies/domain/entities/movie.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesEmpty extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesError extends MoviesState {
  final String message;

  const MoviesError({required this.message});

  @override
  List<Object> get props => [message];
}

class MoviesLoaded extends MoviesState {
  final List<MovieEntity> movies;

  const MoviesLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}
