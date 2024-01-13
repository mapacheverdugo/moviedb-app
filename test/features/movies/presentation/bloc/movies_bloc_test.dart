import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/core/domain/usecases/usecase.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/features/movies/data/models/movie_model.dart';
import 'package:moviedb/features/movies/domain/usecases/get_movies_usecase.dart';
import 'package:moviedb/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:moviedb/features/movies/presentation/bloc/movies_event.dart';
import 'package:moviedb/features/movies/presentation/bloc/movies_state.dart';

import 'movies_bloc_test.mocks.dart';

@GenerateMocks([GetMoviesUseCase])
void main() {
  late MockGetMoviesUseCase mockGetMoviesUseCase;
  late MoviesBloc moviesBloc;

  setUp(() {
    mockGetMoviesUseCase = MockGetMoviesUseCase();
    moviesBloc = MoviesBloc(mockGetMoviesUseCase);
  });

  const tMovieModelList = [
    MovieModel(
      id: 1,
      title: 'Test',
      overview: 'Overview',
      voteAverage: 1,
      releaseDate: '2021-01-01',
      posterUrl: '/test.jpg',
      backdropUrl: '/test.jpg',
      voteCount: 1,
      genres: [1, 2],
    )
  ];

  test(
    'initial state should be MoviesEmpty',
    () async {
      // assert
      expect(moviesBloc.state, equals(MoviesEmpty()));
    },
  );

  blocTest<MoviesBloc, MoviesState>(
    'should emit [MoviesLoading, MoviesLoaded] when data is gotten successfully',
    build: () {
      when(mockGetMoviesUseCase.call(const NoParameters()))
          .thenAnswer((_) async => const Right(tMovieModelList));
      return moviesBloc;
    },
    act: (bloc) => bloc.add(GetMoviesEvent()),
    expect: () => [
      MoviesLoading(),
      const MoviesLoaded(movies: tMovieModelList),
    ],
  );

  blocTest<MoviesBloc, MoviesState>(
    'should emit [MoviesLoading, MoviesLoaded] when data is gotten unsuccessfully',
    build: () {
      when(mockGetMoviesUseCase.call(const NoParameters()))
          .thenAnswer((_) async => const Left(ServerFailure('Server failed')));
      return moviesBloc;
    },
    act: (bloc) => bloc.add(GetMoviesEvent()),
    expect: () => [
      MoviesLoading(),
      const MoviesError(message: 'Server failed'),
    ],
  );
}