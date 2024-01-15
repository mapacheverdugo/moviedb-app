import 'package:flutter/material.dart';

enum CustomChipVariant { primary, secondary, tertiary }

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.label,
    this.variant = CustomChipVariant.tertiary,
    this.onPressed,
  });

  final String label;
  final CustomChipVariant variant;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final backgroundColor = variant == CustomChipVariant.primary
        ? colorScheme.primary
        : variant == CustomChipVariant.secondary
            ? colorScheme.secondary
            : colorScheme.tertiary;
    final foregroundColor = variant == CustomChipVariant.primary
        ? colorScheme.onPrimary
        : variant == CustomChipVariant.secondary
            ? colorScheme.onSecondary
            : colorScheme.onTertiary;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 8,
            ),
            child: Text(
              label,
              style: textTheme.titleSmall?.copyWith(
                color: foregroundColor,
                fontWeight: variant == CustomChipVariant.primary
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
