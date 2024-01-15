import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/core/constants/enums.dart';
import 'package:moviedb/core/presentation/widgets/custom_chip.dart';
import 'package:moviedb/features/movies/presentation/blocs/selected_category_cubit/selected_category_cubit.dart';

class MoviesCategoriesChips extends StatelessWidget {
  const MoviesCategoriesChips({
    super.key,
    required this.selected,
    this.padding = EdgeInsets.zero,
  });

  final MoviesCategory selected;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return SizedBox(
      height: 32 + padding.vertical,
      width: mq.size.width,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: padding.horizontal / 2,
          vertical: padding.vertical / 2,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = _categories[index];
          return CustomChip(
            label: category.name,
            onPressed: () => _onChipPressed(context, category),
            variant: selected == category
                ? CustomChipVariant.primary
                : CustomChipVariant.tertiary,
          );
        },
      ),
    );
  }

  List<MoviesCategory> get _categories =>
      [...MoviesCategory.values]..sort((a, b) => a.index.compareTo(b.index));

  void _onChipPressed(BuildContext context, MoviesCategory category) {
    final selectedCategoryCubit = context.read<SelectedCategoryCubit>();
    selectedCategoryCubit.select(category);
  }
}
