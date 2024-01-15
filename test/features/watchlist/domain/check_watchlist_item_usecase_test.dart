import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moviedb/features/watchlist/domain/repositories/watchlist_repository.dart';
import 'package:moviedb/features/watchlist/domain/usecases/check_watchlist_item_usecase.dart';

import 'check_watchlist_item_usecase_test.mocks.dart';

@GenerateMocks([WatchListRepository])
void main() {
  late CheckWatchListItemUseCase checkWatchListItemUseCase;
  late MockWatchListRepository mockWatchListRepository;

  setUp(() {
    mockWatchListRepository = MockWatchListRepository();
    checkWatchListItemUseCase =
        CheckWatchListItemUseCase(repository: mockWatchListRepository);
  });

  const tTmdbId = 1;

  test('should check watchlist item on the repository', () async {
    // arrange
    when(mockWatchListRepository.checkIfAdded(tTmdbId))
        .thenAnswer((_) async => const Right(true));
    // act
    final result = await checkWatchListItemUseCase(tTmdbId);
    // assert
    expect(result, const Right(true));
    verify(mockWatchListRepository.checkIfAdded(tTmdbId));
    verifyNoMoreInteractions(mockWatchListRepository);
  });
}
