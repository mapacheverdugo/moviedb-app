import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/domain/usecases/usecase.dart';
import 'package:moviedb/features/watchlist/domain/usecases/add_watchlist_item_usecase.dart';
import 'package:moviedb/features/watchlist/domain/usecases/get_watchlist_items_usecase.dart';
import 'package:moviedb/features/watchlist/domain/usecases/remove_watchlist_item_usecase.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  late AddWatchListItemUseCase _addWatchListItemUseCase;
  late RemoveWatchListItemUseCase _removeWatchListItemUseCase;
  late GetWatchListItemsUseCase _getWatchListItemsUseCase;

  WatchlistBloc({
    required AddWatchListItemUseCase addWatchListItemUseCase,
    required RemoveWatchListItemUseCase removeWatchListItemUseCase,
    required GetWatchListItemsUseCase getWatchListItemsUseCase,
  }) : super(WatchlistInitial()) {
    _addWatchListItemUseCase = addWatchListItemUseCase;
    _removeWatchListItemUseCase = removeWatchListItemUseCase;
    _getWatchListItemsUseCase = getWatchListItemsUseCase;

    on<ToggleWatchlistItem>(_toggleWatchListItem);
    on<GetWatchlistItems>(_getWathcListItems);
  }

  Future<void> _toggleWatchListItem(
    ToggleWatchlistItem event,
    Emitter<WatchlistState> emit,
  ) async {
    final wasWatchlisted = event.movie.isWatchlisted;

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
            movies: [...state.movies, event.movie],
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
            movies: [...state.movies]
              ..removeWhere((e) => e.tmdbId == event.movie.tmdbId),
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

/*   @override
  void onChange(Change<WatchlistState> change) {
    super.onChange(change);
    debugPrint(change.toString());
    debugPrint(change.currentState.toString());
    debugPrint(change.nextState.toString());
  } */
}
