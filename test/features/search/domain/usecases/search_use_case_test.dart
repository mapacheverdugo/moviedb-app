import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/features/search/domain/repositories/search_repository.dart';
import 'package:moviedb/features/search/domain/usecases/search_usecase.dart';

import 'search_use_case_test.mocks.dart';

@GenerateMocks([SearchRepository])
void main() {
  late SearchUseCase searchUseCase;
  late MockSearchRepository mockSearchRepository;

  setUp(() {
    mockSearchRepository = MockSearchRepository();
    searchUseCase = SearchUseCase(repository: mockSearchRepository);
  });

  const tQuery = "test";

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

  test('should get movie details from the repository', () async {
    // arrange
    when(mockSearchRepository.search(query: tQuery))
        .thenAnswer((_) async => Right(tMovieEntityList));
    // act
    final result = await searchUseCase(SearchUseCaseParams(query: tQuery));
    // assert
    expect(result, Right(tMovieEntityList));
    verify(mockSearchRepository.search(query: tQuery));
    verifyNoMoreInteractions(mockSearchRepository);
  });
}
