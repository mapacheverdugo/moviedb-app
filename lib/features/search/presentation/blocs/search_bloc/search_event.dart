part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class ChangeQueryToSearch extends SearchEvent {
  final String query;

  const ChangeQueryToSearch({required this.query});

  @override
  List<Object> get props => [query];
}

class SearchNow extends SearchEvent {
  final String query;

  const SearchNow({required this.query});

  @override
  List<Object> get props => [query];
}

class LoadMoreSearchResults extends SearchEvent {
  const LoadMoreSearchResults();

  @override
  List<Object> get props => [];
}
