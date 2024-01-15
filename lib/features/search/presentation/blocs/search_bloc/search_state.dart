part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  final List<MovieEntity> results;

  const SearchState({
    this.results = const <MovieEntity>[],
  });

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {
  const SearchLoading({super.results});

  @override
  List<Object> get props => [results];
}

final class SearchLoaded extends SearchState {
  const SearchLoaded({required super.results});

  @override
  List<Object> get props => [results];
}

final class SearchNoMoreResults extends SearchState {
  const SearchNoMoreResults({required super.results});

  @override
  List<Object> get props => [results];
}

final class SearchError extends SearchState {
  final String message;

  const SearchError({required this.message});

  @override
  List<Object> get props => [message];
}
