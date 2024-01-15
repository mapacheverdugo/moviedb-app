import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/features/search/domain/usecases/search_usecase.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  static const debounceDuration = Duration(milliseconds: 300);

  final SearchUseCase _searchUseCase;

  bool isLastPage = false;
  int page = 1;
  String query = '';

  SearchBloc(this._searchUseCase) : super(SearchInitial()) {
    on<ChangeQueryToSearch>(
      (event, emit) async {
        isLastPage = false;
        page = 1;
        emit(SearchLoading(results: state.results));
        final failureOrMovies = await _searchUseCase(
          SearchUseCaseParams(
            query: event.query,
            page: page,
          ),
        );
        failureOrMovies.fold(
          (failure) => emit(SearchError(message: failure.message)),
          (results) {
            page++;
            query = event.query;
            emit(SearchLoaded(results: results));
          },
        );
      },
      transformer: debounce(debounceDuration),
    );

    on<SearchNow>(
      (event, emit) async {
        isLastPage = false;
        page = 1;
        emit(SearchLoading(results: state.results));
        final failureOrMovies = await _searchUseCase(
          SearchUseCaseParams(
            query: event.query,
            page: page,
          ),
        );
        failureOrMovies.fold(
          (failure) => emit(SearchError(message: failure.message)),
          (results) {
            page++;
            query = event.query;
            emit(SearchLoaded(results: results));
          },
        );
      },
    );

    on<LoadMoreSearchResults>((event, emit) async {
      if (isLastPage) {
        emit(SearchNoMoreResults(results: state.results));
        return;
      }
      final failureOrMovies = await _searchUseCase(
        SearchUseCaseParams(
          query: query,
          page: page,
        ),
      );
      failureOrMovies.fold(
        (failure) => emit(SearchError(message: failure.message)),
        (morePopularMovies) {
          if (morePopularMovies.isEmpty) {
            isLastPage = true;
            emit(SearchNoMoreResults(results: state.results));
          } else {
            page++;
            emit(
              SearchLoaded(
                results: state.results + morePopularMovies,
              ),
            );
          }
        },
      );
    });
  }

  @override
  void onChange(Change<SearchState> change) {
    super.onChange(change);
    debugPrint(change.toString());
    debugPrint(change.currentState.toString());
    debugPrint(change.nextState.toString());
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
