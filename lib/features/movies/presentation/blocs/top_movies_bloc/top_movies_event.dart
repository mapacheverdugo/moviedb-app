part of 'top_movies_bloc.dart';

sealed class TopMoviesEvent extends Equatable {
  const TopMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetTopMoviesEvent extends TopMoviesEvent {
  const GetTopMoviesEvent();

  @override
  List<Object> get props => [];
}

class LoadMoreTopMoviesEvent extends TopMoviesEvent {
  const LoadMoreTopMoviesEvent();

  @override
  List<Object> get props => [];
}
