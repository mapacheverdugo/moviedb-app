import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/features/movies/data/models/movie_model.dart';
import 'package:moviedb/features/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:moviedb/features/movies/presentation/blocs/movies_bloc/movies_bloc.dart';

import 'movies_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMoviesUseCase])
void main() {
  late MockGetPopularMoviesUseCase mockGetPopularMoviesUseCase;
  late MoviesBloc moviesBloc;

  setUp(() {
    mockGetPopularMoviesUseCase = MockGetPopularMoviesUseCase();
    moviesBloc = MoviesBloc(mockGetPopularMoviesUseCase);
  });

  final tMovieModelList = [
    MovieModel(
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
  test(
    'initial state should be MoviesInitial',
    () async {
      // assert
      expect(moviesBloc.state, equals(MoviesInitial()));
    },
  );

  group('GetMoviesEvent', () {
    blocTest<MoviesBloc, MoviesState>(
      'should emit [MoviesLoading, MoviesLoaded] and add 1 to page when data is gotten successfully',
      build: () {
        when(mockGetPopularMoviesUseCase.call(tPage))
            .thenAnswer((_) async => Right(tMovieModelList));
        return moviesBloc;
      },
      act: (bloc) => bloc.add(const GetMoviesEvent()),
      expect: () => [
        MoviesLoading(),
        MoviesLoaded(popularMovies: tMovieModelList),
      ],
      verify: (bloc) {
        expect(bloc.page, equals(tPage + 1));
      },
    );

    blocTest<MoviesBloc, MoviesState>(
      'should emit [MoviesLoading, MoviesError] and same page when data is gotten unsuccessfully',
      build: () {
        when(mockGetPopularMoviesUseCase.call(tPage)).thenAnswer(
            (_) async => const Left(ServerFailure('Server failed')));
        return moviesBloc;
      },
      act: (bloc) => bloc.add(const GetMoviesEvent()),
      expect: () => [
        MoviesLoading(),
        const MoviesError(message: 'Server failed'),
      ],
      verify: (bloc) {
        expect(bloc.page, equals(tPage));
      },
    );
  });

  group('LoadMoreMoviesEvent', () {
    blocTest<MoviesBloc, MoviesState>(
      'should emit [MoviesLoaded] and add 1 to page when data is gotten successfully',
      build: () {
        when(mockGetPopularMoviesUseCase.call(tPage))
            .thenAnswer((_) async => Right(tMovieModelList));
        return moviesBloc;
      },
      act: (bloc) => bloc.add(const LoadMoreMoviesEvent()),
      expect: () => [
        MoviesLoaded(popularMovies: tMovieModelList),
      ],
      verify: (bloc) {
        expect(bloc.page, equals(tPage + 1));
      },
    );

    blocTest<MoviesBloc, MoviesState>(
      'should emit nothing, same page number and marked as last page when no more data is available',
      build: () {
        when(mockGetPopularMoviesUseCase.call(tPage))
            .thenAnswer((_) async => const Right([]));
        return moviesBloc;
      },
      act: (bloc) => bloc.add(const LoadMoreMoviesEvent()),
      expect: () => [],
      verify: (bloc) {
        expect(bloc.page, equals(tPage));
        expect(bloc.isLastPage, equals(true));
      },
    );

    blocTest<MoviesBloc, MoviesState>(
      'should emit [MoviesError] and same page when data is gotten unsuccessfully',
      build: () {
        when(mockGetPopularMoviesUseCase.call(tPage)).thenAnswer(
            (_) async => const Left(ServerFailure('Server failed')));
        return moviesBloc;
      },
      act: (bloc) => bloc.add(const LoadMoreMoviesEvent()),
      expect: () => [
        const MoviesError(message: 'Server failed'),
      ],
      verify: (bloc) {
        expect(bloc.page, equals(tPage));
      },
    );
  });
}
