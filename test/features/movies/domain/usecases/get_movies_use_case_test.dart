import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/core/domain/usecases/usecase.dart';
import 'package:moviedb/features/movies/domain/entities/movie.dart';
import 'package:moviedb/features/movies/domain/repositories/movie_repository.dart';
import 'package:moviedb/features/movies/domain/usecases/get_movies_usecase.dart';

import 'get_movies_use_case_test.mocks.dart';

@GenerateMocks([MovieRepository])
void main() {
  late GetMoviesUseCase getMoviesUseCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getMoviesUseCase = GetMoviesUseCase(repository: mockMovieRepository);
  });

  final tMovieList = [
    MovieEntity(
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

  test('should get movies from the repository', () async {
    // arrange
    when(mockMovieRepository.getMovies())
        .thenAnswer((_) async => Right(tMovieList));
    // act
    final result = await getMoviesUseCase(const NoParameters());
    // assert
    expect(result, Right(tMovieList));
    verify(mockMovieRepository.getMovies());
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
