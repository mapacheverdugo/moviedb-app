import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/core/domain/entities/movie.dart';
import 'package:moviedb/core/domain/usecases/usecase.dart';
import 'package:moviedb/features/watchlist/domain/repositories/watchlist_repository.dart';
import 'package:moviedb/features/watchlist/domain/usecases/get_watchlist_items_usecase.dart';

import 'get_watchlist_items_usecase_test.mocks.dart';

@GenerateMocks([WatchListRepository])
void main() {
  late GetWatchListItemsUseCase getWatchListItemsUseCase;
  late MockWatchListRepository mockWatchListRepository;

  setUp(() {
    mockWatchListRepository = MockWatchListRepository();
    getWatchListItemsUseCase =
        GetWatchListItemsUseCase(repository: mockWatchListRepository);
  });

  const tTmdbId = 1;

  final tMovieListEntity = [
    MovieEntity(
      tmdbId: tTmdbId,
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

  test('should get watchlist items from the repository', () async {
    // arrange
    when(mockWatchListRepository.getWatchListItems())
        .thenAnswer((_) async => Right(tMovieListEntity));
    // act
    final result = await getWatchListItemsUseCase(const NoParameters());
    // assert
    expect(result, Right(tMovieListEntity));
    verify(mockWatchListRepository.getWatchListItems());
    verifyNoMoreInteractions(mockWatchListRepository);
  });
}
