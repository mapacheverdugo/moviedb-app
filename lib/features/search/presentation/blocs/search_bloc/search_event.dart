part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class GetSearchResults extends SearchEvent {
  final String query;

  const GetSearchResults(this.query);

  @override
  List<Object> get props => [query];
}

class LoadMoreSearchResults extends SearchEvent {
  const LoadMoreSearchResults();

  @override
  List<Object> get props => [];
}
