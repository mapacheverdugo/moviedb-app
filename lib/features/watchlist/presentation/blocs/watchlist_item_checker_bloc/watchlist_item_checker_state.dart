part of 'watchlist_item_checker_bloc.dart';

sealed class WatchlistItemCheckerState extends Equatable {
  const WatchlistItemCheckerState();

  @override
  List<Object> get props => [];
}

final class WatchlistItemCheckerInitial extends WatchlistItemCheckerState {}

final class WatchlistItemChecked extends WatchlistItemCheckerState {
  final bool isWatchlisted;

  const WatchlistItemChecked({
    required this.isWatchlisted,
  });

  @override
  List<Object> get props => [isWatchlisted];
}

final class WatchlistItemCheckError extends WatchlistItemCheckerState {
  final String message;

  const WatchlistItemCheckError({required this.message});

  @override
  List<Object> get props => [message];
}
