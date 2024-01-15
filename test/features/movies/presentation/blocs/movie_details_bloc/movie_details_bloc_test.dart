import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/core/error/failure.dart';
import 'package:moviedb/core/utils/functions.dart';
import 'package:moviedb/features/movies/data/models/movie_details_model.dart';
import 'package:moviedb/features/movies/domain/usecases/get_movie_details.dart';
import 'package:moviedb/features/movies/presentation/blocs/movie_details/movie_details_bloc.dart';

import 'movie_details_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetailsUseCase])
void main() {
  late MockGetMovieDetailsUseCase mockGetMovieDetailsUseCase;
  late MovieDetailsBloc movieDetailsBloc;

  setUp(() {
    mockGetMovieDetailsUseCase = MockGetMovieDetailsUseCase();
    movieDetailsBloc = MovieDetailsBloc(mockGetMovieDetailsUseCase);
  });

  const tMovieId = 1;
  final tMovieDetailsModel = MovieDetailsModel(
    tmdbId: tMovieId,
    title: 'Test',
    overview: 'Overview',
    voteAverage: 1,
    releaseDate: DateTime.parse('2021-01-01'),
    posterUrl: getPosterUrl('/test.jpg'),
    backdropUrl: getBackdropUrl('/test.jpg'),
    voteCount: 1,
    popularity: 1,
    genres: const [],
    reviews: const [],
  );

  test(
    'initial state should be MoviesInitial',
    () async {
      // assert
      expect(movieDetailsBloc.state, equals(MovieDetailsInitial()));
    },
  );

  blocTest<MovieDetailsBloc, MovieDetailsState>(
    'should emit [MovieDetailsLoading, MovieDetailsLoaded] when data is gotten successfully',
    build: () {
      when(mockGetMovieDetailsUseCase.call(tMovieId))
          .thenAnswer((_) async => Right(tMovieDetailsModel));
      return movieDetailsBloc;
    },
    act: (bloc) => bloc.add(const GetMovieDetailsEvent(movieId: tMovieId)),
    expect: () => [
      MovieDetailsLoading(),
      MovieDetailsLoaded(movieDetails: tMovieDetailsModel),
    ],
  );

  blocTest<MovieDetailsBloc, MovieDetailsState>(
    'should emit [MovieDetailsLoading, MovieDetailsError] when data is gotten unsuccessfully',
    build: () {
      when(mockGetMovieDetailsUseCase.call(tMovieId))
          .thenAnswer((_) async => const Left(ServerFailure('Server failed')));
      return movieDetailsBloc;
    },
    act: (bloc) => bloc.add(const GetMovieDetailsEvent(movieId: tMovieId)),
    expect: () => [
      MovieDetailsLoading(),
      const MovieDetailsError(message: 'Server failed'),
    ],
  );
}
