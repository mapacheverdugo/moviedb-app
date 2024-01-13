part of 'movie_details_bloc.dart';

sealed class MovieDetailsState extends Equatable {
  const MovieDetailsState();

  @override
  List<Object> get props => [];
}

final class MovieDetailsInitial extends MovieDetailsState {}

final class MovieDetailsLoading extends MovieDetailsState {}

final class MovieDetailsLoaded extends MovieDetailsState {
  final MovieDetailsEntity movieDetails;

  const MovieDetailsLoaded({required this.movieDetails});

  @override
  List<Object> get props => [movieDetails];
}

final class MovieDetailsError extends MovieDetailsState {
  final String message;

  const MovieDetailsError({required this.message});

  @override
  List<Object> get props => [message];
}
