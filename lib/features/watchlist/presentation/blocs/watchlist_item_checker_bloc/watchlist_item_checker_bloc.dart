import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/features/watchlist/domain/usecases/check_watchlist_item_usecase.dart';

part 'watchlist_item_checker_event.dart';
part 'watchlist_item_checker_state.dart';

class WatchlistItemCheckerBloc
    extends Bloc<WatchlistItemCheckerEvent, WatchlistItemCheckerState> {
  late CheckWatchListItemUseCase _checkWatchlistItemUseCase;

  WatchlistItemCheckerBloc({
    required CheckWatchListItemUseCase checkWatchlistItem,
  }) : super(WatchlistItemCheckerInitial()) {
    _checkWatchlistItemUseCase = checkWatchlistItem;

    on<CheckWatchlistItem>(_checkWatchlistItem);
  }

  Future<void> _checkWatchlistItem(
    CheckWatchlistItem event,
    Emitter<WatchlistItemCheckerState> emit,
  ) async {
    final result = await _checkWatchlistItemUseCase.call(event.movie.tmdbId);
    result.fold(
      (failure) => emit(
        WatchlistItemCheckError(
          message: failure.message,
        ),
      ),
      (isWatchlisted) {
        event.movie.isWatchlisted = isWatchlisted;
        /* emit(
          WatchlistItemChecked(
            isWatchlisted: isWatchlisted,
            movies: state.movies,
          ),
        ); */
      },
    );
  }
}
