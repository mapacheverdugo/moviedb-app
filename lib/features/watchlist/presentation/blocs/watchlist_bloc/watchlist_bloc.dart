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

    on<AddWatchlistItem>(_addWathcListTime);
    on<RemoveWatchlistItem>(_removeWathcListTime);
    on<GetWatchlistItems>(_getWathcListItems);
  }

  Future<void> _addWathcListTime(
    AddWatchlistItem event,
    Emitter<WatchlistState> emit,
  ) async {
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
            id: id,
          ),
        );
      },
    );
  }

  Future<void> _removeWathcListTime(
    RemoveWatchlistItem event,
    Emitter<WatchlistState> emit,
  ) async {
    final result = await _removeWatchListItemUseCase.call(event.movie.tmdbId);
    result.fold(
      (failure) => emit(
        WatchlistError(
          message: failure.message,
        ),
      ),
      (success) {
        emit(
          WatchlistItemRemoved(),
        );
      },
    );
  }

  Future<void> _getWathcListItems(
    WatchlistEvent event,
    Emitter<WatchlistState> emit,
  ) async {
    emit(WatchlistLoading());
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
}
