part of 'watchlist_bloc.dart';

sealed class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object> get props => [];
}

final class WatchlistInitial extends WatchlistState {}

final class WatchlistLoading extends WatchlistState {}

final class WatchlistLoaded extends WatchlistState {
  final List<MovieEntity> movies;

  const WatchlistLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

final class WatchlistError extends WatchlistState {
  final String message;

  const WatchlistError({required this.message});

  @override
  List<Object> get props => [message];
}

final class WatchlistItemAdded extends WatchlistState {
  final int id;

  const WatchlistItemAdded({required this.id});

  @override
  List<Object> get props => [id];
}

final class WatchlistItemRemoved extends WatchlistState {}
