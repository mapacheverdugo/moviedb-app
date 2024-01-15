part of 'popular_movies_bloc.dart';

sealed class PopularMoviesEvent extends Equatable {
  const PopularMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetPopularMoviesEvent extends PopularMoviesEvent {
  const GetPopularMoviesEvent();

  @override
  List<Object> get props => [];
}

class LoadMorePopularMoviesEvent extends PopularMoviesEvent {
  const LoadMorePopularMoviesEvent();

  @override
  List<Object> get props => [];
}
