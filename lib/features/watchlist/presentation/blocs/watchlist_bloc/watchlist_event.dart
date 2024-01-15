part of 'watchlist_bloc.dart';

sealed class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object> get props => [];
}

final class GetWatchlistItems extends WatchlistEvent {}

final class ToggleWatchlistItem extends WatchlistEvent {
  final MovieEntity movie;

  const ToggleWatchlistItem({required this.movie});

  @override
  List<Object> get props => [movie];
}
