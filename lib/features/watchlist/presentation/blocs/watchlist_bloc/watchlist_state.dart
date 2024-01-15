part of 'watchlist_bloc.dart';

sealed class WatchlistState extends Equatable {
  final List<MovieEntity> movies;

  const WatchlistState({this.movies = const []});

  @override
  List<Object> get props => [movies];
}

final class WatchlistInitial extends WatchlistState {}

final class WatchlistLoading extends WatchlistState {
  const WatchlistLoading({required super.movies});
}

final class WatchlistLoaded extends WatchlistState {
  const WatchlistLoaded({required super.movies});
}

final class WatchlistError extends WatchlistState {
  final String message;

  const WatchlistError({required this.message});

  @override
  List<Object> get props => [message];
}

final class WatchlistItemAdded extends WatchlistState {
  const WatchlistItemAdded({required super.movies});
}

final class WatchlistItemRemoved extends WatchlistState {
  const WatchlistItemRemoved({required super.movies});
}

final class WatchlistItemChecked extends WatchlistState {
  final bool isWatchlisted;

  const WatchlistItemChecked({
    required this.isWatchlisted,
    required super.movies,
  });

  @override
  List<Object> get props => [isWatchlisted];
}
