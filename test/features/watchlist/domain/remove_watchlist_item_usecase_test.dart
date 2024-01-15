import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/features/watchlist/domain/repositories/watchlist_repository.dart';
import 'package:moviedb/features/watchlist/domain/usecases/remove_watchlist_item_usecase.dart';

import 'remove_watchlist_item_usecase_test.mocks.dart';

@GenerateMocks([WatchListRepository])
void main() {
  late RemoveWatchListItemUseCase removeWatchListItemUseCase;
  late MockWatchListRepository mockWatchListRepository;

  setUp(() {
    mockWatchListRepository = MockWatchListRepository();
    removeWatchListItemUseCase =
        RemoveWatchListItemUseCase(repository: mockWatchListRepository);
  });

  const tTmdbId = 1;

  test('should add watchlist item to the repository', () async {
    // arrange
    when(mockWatchListRepository.removeWatchListItem(tTmdbId))
        .thenAnswer((_) async => const Right(true));
    // act
    final result = await removeWatchListItemUseCase(tTmdbId);
    // assert
    expect(result, const Right(true));
    verify(mockWatchListRepository.removeWatchListItem(tTmdbId));
    verifyNoMoreInteractions(mockWatchListRepository);
  });
}
