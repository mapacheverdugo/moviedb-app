part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  final String query;

  const SearchEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class GetSearchResults extends SearchEvent {
  const GetSearchResults({required super.query});

  @override
  List<Object> get props => [query];
}

class LoadMoreSearchResults extends SearchEvent {
  const LoadMoreSearchResults({super.query = ''});

  @override
  List<Object> get props => [];
}
