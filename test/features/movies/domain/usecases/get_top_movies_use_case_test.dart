import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/features/movies/domain/repositories/movie_repository.dart';
import 'package:moviedb/features/movies/domain/usecases/get_top_movies_usecase.dart';

import 'get_popular_movies_use_case_test.mocks.dart';

@GenerateMocks([MovieRepository])
void main() {
  late GetTopMoviesUseCase getTopMoviesUseCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getTopMoviesUseCase = GetTopMoviesUseCase(repository: mockMovieRepository);
  });

  final tMovieEntityList = [
    MovieEntity(
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

  test('should get top rated movies from the repository', () async {
    // arrange
    when(mockMovieRepository.getTopMovies())
        .thenAnswer((_) async => Right(tMovieEntityList));
    // act
    final result = await getTopMoviesUseCase(1);
    // assert
    expect(result, Right(tMovieEntityList));
    verify(mockMovieRepository.getTopMovies());
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
