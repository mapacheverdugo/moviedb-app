part of 'movies_bloc.dart';

sealed class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class GetMoviesEvent extends MoviesEvent {
  const GetMoviesEvent();

  @override
  List<Object> get props => [];
}
