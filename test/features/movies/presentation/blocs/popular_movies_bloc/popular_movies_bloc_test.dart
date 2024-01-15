import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/features/movies/data/models/movie_model.dart';
import 'package:moviedb/features/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:moviedb/features/movies/presentation/blocs/popular_movies_bloc/popular_movies_bloc.dart';

import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMoviesUseCase])
void main() {
  late MockGetPopularMoviesUseCase mockGetPopularMoviesUseCase;
  late PopularMoviesBloc moviesBloc;

  setUp(() {
    mockGetPopularMoviesUseCase = MockGetPopularMoviesUseCase();
    moviesBloc = PopularMoviesBloc(mockGetPopularMoviesUseCase);
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
    'initial state should be PopularMoviesInitial',
    () async {
      // assert
      expect(moviesBloc.state, equals(PopularMoviesInitial()));
    },
  );

  group('GetPopularMoviesEvent', () {
    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'should emit [PopularMoviesLoading, PopularMoviesLoaded] and add 1 to page when data is gotten successfully',
      build: () {
        when(mockGetPopularMoviesUseCase.call(tPage))
            .thenAnswer((_) async => Right(tMovieModelList));
        return moviesBloc;
      },
      act: (bloc) => bloc.add(const GetPopularMoviesEvent()),
      expect: () => [
        const PopularMoviesLoading(),
        PopularMoviesLoaded(movies: tMovieModelList),
      ],
      verify: (bloc) {
        expect(bloc.page, equals(tPage + 1));
      },
    );

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'should emit [PopularMoviesLoading, PopularMoviesError] and same page when data is gotten unsuccessfully',
      build: () {
        when(mockGetPopularMoviesUseCase.call(tPage)).thenAnswer(
            (_) async => const Left(ServerFailure('Server failed')));
        return moviesBloc;
      },
      act: (bloc) => bloc.add(const GetPopularMoviesEvent()),
      expect: () => [
        PopularMoviesLoading(),
        const PopularMoviesError(message: 'Server failed'),
      ],
      verify: (bloc) {
        expect(bloc.page, equals(tPage));
      },
    );
  });

  group('LoadMorePopularMoviesEvent', () {
    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'should emit [PopularMoviesLoaded] and add 1 to page when data is gotten successfully',
      build: () {
        when(mockGetPopularMoviesUseCase.call(tPage))
            .thenAnswer((_) async => Right(tMovieModelList));
        return moviesBloc;
      },
      act: (bloc) => bloc.add(const LoadMorePopularMoviesEvent()),
      expect: () => [
        PopularMoviesLoaded(movies: tMovieModelList),
      ],
      verify: (bloc) {
        expect(bloc.page, equals(tPage + 1));
      },
    );

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'should emit nothing, same page number and marked as last page when no more data is available',
      build: () {
        when(mockGetPopularMoviesUseCase.call(tPage))
            .thenAnswer((_) async => const Right([]));
        return moviesBloc;
      },
      act: (bloc) => bloc.add(const LoadMorePopularMoviesEvent()),
      expect: () => [
        const PopularMoviesNoMoreResults(movies: []),
      ],
      verify: (bloc) {
        expect(bloc.page, equals(tPage));
        expect(bloc.isLastPage, equals(true));
      },
    );

    blocTest<PopularMoviesBloc, PopularMoviesState>(
      'should emit [PopularMoviesError] and same page when data is gotten unsuccessfully',
      build: () {
        when(mockGetPopularMoviesUseCase.call(tPage)).thenAnswer(
            (_) async => const Left(ServerFailure('Server failed')));
        return moviesBloc;
      },
      act: (bloc) => bloc.add(const LoadMorePopularMoviesEvent()),
      expect: () => [
        const PopularMoviesError(message: 'Server failed'),
      ],
      verify: (bloc) {
        expect(bloc.page, equals(tPage));
      },
    );
  });
}
