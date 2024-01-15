import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/domain/usecases/usecase.dart';
import 'package:moviedb/features/watchlist/domain/usecases/add_watchlist_item_usecase.dart';
import 'package:moviedb/features/watchlist/domain/usecases/check_watchlist_item_usecase.dart';
import 'package:moviedb/features/watchlist/domain/usecases/get_watchlist_items_usecase.dart';
import 'package:moviedb/features/watchlist/domain/usecases/remove_watchlist_item_usecase.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  late AddWatchListItemUseCase _addWatchListItemUseCase;
  late RemoveWatchListItemUseCase _removeWatchListItemUseCase;
  late GetWatchListItemsUseCase _getWatchListItemsUseCase;
  late CheckWatchListItemUseCase _checkWatchlistItemUseCase;

  WatchlistBloc({
    required AddWatchListItemUseCase addWatchListItemUseCase,
    required RemoveWatchListItemUseCase removeWatchListItemUseCase,
    required GetWatchListItemsUseCase getWatchListItemsUseCase,
    required CheckWatchListItemUseCase checkWatchlistItem,
  }) : super(WatchlistInitial()) {
    _addWatchListItemUseCase = addWatchListItemUseCase;
    _removeWatchListItemUseCase = removeWatchListItemUseCase;
    _getWatchListItemsUseCase = getWatchListItemsUseCase;
    _checkWatchlistItemUseCase = checkWatchlistItem;

    on<ToggleWatchlistItem>(_toggleWatchListItem);
    on<GetWatchlistItems>(_getWathcListItems);
    on<CheckWatchlistItem>(_checkWatchlistItem);
  }

  Future<void> _toggleWatchListItem(
    ToggleWatchlistItem event,
    Emitter<WatchlistState> emit,
  ) async {
    final wasWatchlisted = event.movie.isWatchlisted;
    event.movie.isWatchlisted = !event.movie.isWatchlisted;

    if (!wasWatchlisted) {
      await _addWatchListItem(event, emit);
    } else {
      await _removeWatchListItem(event, emit);
    }
  }

  Future<void> _addWatchListItem(
    ToggleWatchlistItem event,
    Emitter<WatchlistState> emit,
  ) async {
    event.movie.isWatchlisted = true;
    final result = await _addWatchListItemUseCase.call(event.movie);

    result.fold(
      (failure) => emit(
        WatchlistError(
          message: failure.message,
        ),
      ),
      (id) {
        emit(
          WatchlistItemAdded(
            movies: state.movies,
          ),
        );
      },
    );
  }

  Future<void> _removeWatchListItem(
    ToggleWatchlistItem event,
    Emitter<WatchlistState> emit,
  ) async {
    event.movie.isWatchlisted = false;
    final result = await _removeWatchListItemUseCase.call(event.movie.tmdbId);
    result.fold(
      (failure) => emit(
        WatchlistError(
          message: failure.message,
        ),
      ),
      (success) {
        emit(
          WatchlistItemRemoved(
            movies: state.movies,
          ),
        );
      },
    );
  }

  Future<void> _getWathcListItems(
    WatchlistEvent event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(
      WatchlistLoading(
        movies: state.movies,
      ),
    );
    final result = await _getWatchListItemsUseCase.call(const NoParameters());
    result.fold(
      (failure) => emit(
        WatchlistError(
          message: failure.message,
        ),
      ),
      (watchlistItems) {
        emit(
          WatchlistLoaded(
            movies: watchlistItems,
          ),
        );
      },
    );
  }

  Future<void> _checkWatchlistItem(
    CheckWatchlistItem event,
    Emitter<WatchlistState> emit,
  ) async {
    final result = await _checkWatchlistItemUseCase.call(event.movie.tmdbId);
    result.fold(
      (failure) => emit(
        WatchlistError(
          message: failure.message,
        ),
      ),
      (isWatchlisted) {
        event.movie.isWatchlisted = isWatchlisted;
        emit(
          WatchlistItemChecked(
            isWatchlisted: isWatchlisted,
            movies: state.movies,
          ),
        );
      },
    );
  }
}
