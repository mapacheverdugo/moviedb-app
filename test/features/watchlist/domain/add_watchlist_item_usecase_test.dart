import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/features/watchlist/domain/repositories/watchlist_repository.dart';
import 'package:moviedb/features/watchlist/domain/usecases/add_watchlist_item_usecase.dart';

import 'add_watchlist_item_usecase_test.mocks.dart';

@GenerateMocks([WatchListRepository])
void main() {
  late AddWatchListItemUseCase addWatchListItemUseCase;
  late MockWatchListRepository mockWatchListRepository;

  setUp(() {
    mockWatchListRepository = MockWatchListRepository();
    addWatchListItemUseCase =
        AddWatchListItemUseCase(repository: mockWatchListRepository);
  });

  const tTmdbId = 1;

  final tMovieEntity = MovieEntity(
    tmdbId: tTmdbId,
    title: 'Test',
    overview: 'Overview',
    voteAverage: 1,
    releaseDate: DateTime.parse('2021-01-01'),
    posterUrl: '/test.jpg',
    backdropUrl: '/test.jpg',
    voteCount: 1,
    popularity: 0.1,
  );

  test('should add watchlist item to the repository', () async {
    // arrange
    when(mockWatchListRepository.addWatchListItem(tMovieEntity))
        .thenAnswer((_) async => const Right(tTmdbId));
    // act
    final result = await addWatchListItemUseCase(tMovieEntity);
    // assert
    expect(result, const Right(tTmdbId));
    verify(mockWatchListRepository.addWatchListItem(tMovieEntity));
    verifyNoMoreInteractions(mockWatchListRepository);
  });
}
