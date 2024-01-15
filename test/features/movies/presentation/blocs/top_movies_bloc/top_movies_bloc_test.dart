import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/features/movies/data/models/movie_model.dart';
import 'package:moviedb/features/movies/domain/usecases/get_top_movies_usecase.dart';
import 'package:moviedb/features/movies/presentation/blocs/top_movies_bloc/top_movies_bloc.dart';

import 'top_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopMoviesUseCase])
void main() {
  late MockGetTopMoviesUseCase mockGetTopMoviesUseCase;
  late TopMoviesBloc moviesBloc;

  setUp(() {
    mockGetTopMoviesUseCase = MockGetTopMoviesUseCase();
    moviesBloc = TopMoviesBloc(mockGetTopMoviesUseCase);
  });

  final tMovieModelList = [
    MovieModel(
      tmdbId: 1,
      title: 'Test',
      overview: 'Overview',
      voteAverage: 1,
      releaseDate: DateTime.parse('2021-01-01'),
      posterUrl: '/test.jpg',
      backdropUrl: '/test.jpg',
      voteCount: 1,
      popularity: 0.1,
    )
  ];

  const tPage = 1;
  test(
    'initial state should be TopMoviesInitial',
    () async {
      // assert
      expect(moviesBloc.state, equals(TopMoviesInitial()));
    },
  );

  group('GetTopMoviesEvent', () {
    blocTest<TopMoviesBloc, TopMoviesState>(
      'should emit [TopMoviesLoading, TopMoviesLoaded] and add 1 to page when data is gotten successfully',
      build: () {
        when(mockGetTopMoviesUseCase.call(tPage))
            .thenAnswer((_) async => Right(tMovieModelList));
        return moviesBloc;
      },
      act: (bloc) => bloc.add(const GetTopMoviesEvent()),
      expect: () => [
        const TopMoviesLoading(),
        TopMoviesLoaded(movies: tMovieModelList),
      ],
      verify: (bloc) {
        expect(bloc.page, equals(tPage + 1));
      },
    );

    blocTest<TopMoviesBloc, TopMoviesState>(
      'should emit [TopMoviesLoading, TopMoviesError] and same page when data is gotten unsuccessfully',
      build: () {
        when(mockGetTopMoviesUseCase.call(tPage)).thenAnswer(
            (_) async => const Left(ServerFailure('Server failed')));
        return moviesBloc;
      },
      act: (bloc) => bloc.add(const GetTopMoviesEvent()),
      expect: () => [
        TopMoviesLoading(),
        const TopMoviesError(message: 'Server failed'),
      ],
      verify: (bloc) {
        expect(bloc.page, equals(tPage));
      },
    );
  });

  group('LoadMoreTopMoviesEvent', () {
    blocTest<TopMoviesBloc, TopMoviesState>(
      'should emit [TopMoviesLoaded] and add 1 to page when data is gotten successfully',
      build: () {
        when(mockGetTopMoviesUseCase.call(tPage))
            .thenAnswer((_) async => Right(tMovieModelList));
        return moviesBloc;
      },
      act: (bloc) => bloc.add(const LoadMoreTopMoviesEvent()),
      expect: () => [
        TopMoviesLoaded(movies: tMovieModelList),
      ],
      verify: (bloc) {
        expect(bloc.page, equals(tPage + 1));
      },
    );

    blocTest<TopMoviesBloc, TopMoviesState>(
      'should emit nothing, same page number and marked as last page when no more data is available',
      build: () {
        when(mockGetTopMoviesUseCase.call(tPage))
            .thenAnswer((_) async => const Right([]));
        return moviesBloc;
      },
      act: (bloc) => bloc.add(const LoadMoreTopMoviesEvent()),
      expect: () => [
        const TopMoviesNoMoreResults(movies: []),
      ],
      verify: (bloc) {
        expect(bloc.page, equals(tPage));
        expect(bloc.isLastPage, equals(true));
      },
    );

    blocTest<TopMoviesBloc, TopMoviesState>(
      'should emit [TopMoviesError] and same page when data is gotten unsuccessfully',
      build: () {
        when(mockGetTopMoviesUseCase.call(tPage)).thenAnswer(
            (_) async => const Left(ServerFailure('Server failed')));
        return moviesBloc;
      },
      act: (bloc) => bloc.add(const LoadMoreTopMoviesEvent()),
      expect: () => [
        const TopMoviesError(message: 'Server failed'),
      ],
      verify: (bloc) {
        expect(bloc.page, equals(tPage));
      },
    );
  });
}
