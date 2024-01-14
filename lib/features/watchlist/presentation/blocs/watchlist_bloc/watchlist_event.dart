part of 'watchlist_bloc.dart';

sealed class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object> get props => [];
}

final class GetWatchlistItems extends WatchlistEvent {}

final class AddWatchlistItem extends WatchlistEvent {
  final MovieEntity movie;

  const AddWatchlistItem({required this.movie});

  @override
  List<Object> get props => [movie];
}

final class RemoveWatchlistItem extends WatchlistEvent {
  final MovieEntity movie;

  const RemoveWatchlistItem({required this.movie});

  @override
  List<Object> get props => [movie];
}

final class CheckWatchlistItem extends WatchlistEvent {
  final MovieEntity movie;

  const CheckWatchlistItem({required this.movie});

  @override
  List<Object> get props => [movie];
}
