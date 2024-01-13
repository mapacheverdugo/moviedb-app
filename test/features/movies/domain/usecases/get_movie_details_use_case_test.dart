import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/features/movies/domain/entities/movie_details.dart';
import 'package:moviedb/features/movies/domain/repositories/movie_repository.dart';
import 'package:moviedb/features/movies/domain/usecases/get_movie_details.dart';

import 'get_movies_use_case_test.mocks.dart';

@GenerateMocks([MovieRepository])
void main() {
  late GetMovieDetailsUseCase getMovieDetailsUseCase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    getMovieDetailsUseCase =
        GetMovieDetailsUseCase(repository: mockMovieRepository);
  });

  const tMovieId = 1;

  final tMovieEntity = MovieDetailsEntity(
    id: tMovieId,
    title: 'Test',
    overview: 'Overview',
    voteAverage: 1,
    releaseDate: DateTime.parse('2021-01-01'),
    posterUrl: '/test.jpg',
    backdropUrl: '/test.jpg',
    voteCount: 1,
    popularity: 1,
    genres: const [],
    reviews: const [],
  );

  test('should get movie details from the repository', () async {
    // arrange
    when(mockMovieRepository.getMovieDetails(movieId: tMovieId))
        .thenAnswer((_) async => Right(tMovieEntity));
    // act
    final result = await getMovieDetailsUseCase(tMovieId);
    // assert
    expect(result, Right(tMovieEntity));
    verify(mockMovieRepository.getMovieDetails(movieId: tMovieId));
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
