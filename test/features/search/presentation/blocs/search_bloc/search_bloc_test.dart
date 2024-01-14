import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/features/search/data/models/search_result_item_model.dart';
import 'package:moviedb/features/search/domain/usecases/search_usecase.dart';
import 'package:moviedb/features/search/presentation/blocs/search_bloc/search_bloc.dart';

import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchUseCase])
void main() {
  late MockSearchUseCase mockSearchUseCase;
  late SearchBloc searchBloc;

  setUp(() {
    mockSearchUseCase = MockSearchUseCase();
    searchBloc = SearchBloc(mockSearchUseCase);
  });

  final tSearchResultItemModelList = [
    SearchResultItemModel(
      id: 1,
      title: 'Test',
      overview: 'Overview',
      voteAverage: 1,
      releaseDate: DateTime.parse('2021-01-01'),
      posterUrl: '/test.jpg',
      backdropUrl: '/test.jpg',
      voteCount: 1,
    )
  ];

  const tPage = 1;
  const tQuery = 'test';

  test(
    'initial state should be SearchInitial',
    () async {
      // assert
      expect(searchBloc.state, equals(SearchInitial()));
    },
  );

  group('GetSearchResults', () {
    blocTest<SearchBloc, SearchState>(
      'should emit [SearchLoading, SearchLoaded] and add 1 to page when data is gotten successfully',
      build: () {
        when(mockSearchUseCase.call(any))
            .thenAnswer((_) async => Right(tSearchResultItemModelList));
        return searchBloc;
      },
      act: (bloc) => bloc.add(const GetSearchResults(query: tQuery)),
      wait: SearchBloc.debounceDuration,
      expect: () => [
        SearchLoading(),
        SearchLoaded(results: tSearchResultItemModelList),
      ],
      verify: (bloc) {
        expect(bloc.page, equals(tPage + 1));
      },
    );

    blocTest<SearchBloc, SearchState>(
      'should emit [SearchLoading, SearchError] and same page when data is gotten unsuccessfully',
      build: () {
        when(mockSearchUseCase.call(any)).thenAnswer(
            (_) async => const Left(ServerFailure('Server failed')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(const GetSearchResults(query: tQuery)),
      wait: SearchBloc.debounceDuration,
      expect: () => [
        SearchLoading(),
        const SearchError(message: 'Server failed'),
      ],
      verify: (bloc) {
        expect(bloc.page, equals(tPage));
      },
    );
  });

  group('LoadMoreSearchResults', () {
    blocTest<SearchBloc, SearchState>(
      'should emit [SearchLoaded] and add 1 to page when data is gotten successfully',
      build: () {
        when(mockSearchUseCase.call(any))
            .thenAnswer((_) async => Right(tSearchResultItemModelList));
        return searchBloc;
      },
      act: (bloc) => bloc.add(const LoadMoreSearchResults(query: tQuery)),
      wait: SearchBloc.debounceDuration,
      expect: () => [
        SearchLoaded(results: tSearchResultItemModelList),
      ],
      verify: (bloc) {
        expect(bloc.page, equals(tPage + 1));
      },
    );

    blocTest<SearchBloc, SearchState>(
      'should emit nothing, same page number and marked as last page when no more data is available',
      build: () {
        when(mockSearchUseCase.call(any))
            .thenAnswer((_) async => const Right([]));
        return searchBloc;
      },
      act: (bloc) => bloc.add(const LoadMoreSearchResults(query: tQuery)),
      wait: SearchBloc.debounceDuration,
      expect: () => [],
      verify: (bloc) {
        expect(bloc.page, equals(tPage));
        expect(bloc.isLastPage, equals(true));
      },
    );

    blocTest<SearchBloc, SearchState>(
      'should emit [SearchError] and same page when data is gotten unsuccessfully',
      build: () {
        when(mockSearchUseCase.call(any)).thenAnswer(
            (_) async => const Left(ServerFailure('Server failed')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(const LoadMoreSearchResults(query: tQuery)),
      wait: SearchBloc.debounceDuration,
      expect: () => [
        const SearchError(message: 'Server failed'),
      ],
      verify: (bloc) {
        expect(bloc.page, equals(tPage));
      },
    );
  });
}
