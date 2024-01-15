import 'package:bloc/bloc.dart';
import 'package:moviedb/core/constants/enums.dart';

class SelectedCategoryCubit extends Cubit<MoviesCategory> {
  SelectedCategoryCubit() : super(MoviesCategory.topRated);

  void select(MoviesCategory category) {
    emit(category);
  }

  void selectPopular() => emit(MoviesCategory.popular);
  void selectTopRated() => emit(MoviesCategory.topRated);
}
