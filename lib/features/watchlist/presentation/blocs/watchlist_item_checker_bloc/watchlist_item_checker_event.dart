part of 'watchlist_item_checker_bloc.dart';

sealed class WatchlistItemCheckerEvent extends Equatable {
  const WatchlistItemCheckerEvent();

  @override
  List<Object> get props => [];
}

final class CheckWatchlistItem extends WatchlistItemCheckerEvent {
  final MovieEntity movie;

  const CheckWatchlistItem({required this.movie});

  @override
  List<Object> get props => [movie];
}
