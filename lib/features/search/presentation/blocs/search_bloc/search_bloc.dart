import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/features/search/domain/usecases/search_usecase.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUseCase _searchUseCase;

  bool isLastPage = false;
  int page = 1;
  String query = '';

  SearchBloc(this._searchUseCase) : super(SearchInitial()) {
    on<GetSearchResults>((event, emit) async {
      emit(SearchLoading());
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
    });

    on<LoadMoreSearchResults>((event, emit) async {
      if (isLastPage) {
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
}
