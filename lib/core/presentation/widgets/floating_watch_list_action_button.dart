import 'package:flutter/material.dart';

class FloatingWatchListActionButton extends StatelessWidget {
  const FloatingWatchListActionButton({
    super.key,
    required this.isWatchlisted,
    this.onTap,
  });

  final bool isWatchlisted;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final watchlistedStyle = ElevatedButton.styleFrom(
      elevation: 0,
      padding: const EdgeInsets.all(10),
    );
    const watchlistedIcon = Icon(Icons.bookmark_added_rounded);

    final notWatchlistedStyle = ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: colorScheme.tertiary,
      foregroundColor: colorScheme.onTertiary,
      padding: const EdgeInsets.all(10),
    );
    const notWatchlistedIcon = Icon(Icons.bookmark_rounded);

    return ElevatedButton(
      onPressed: onTap,
      style: isWatchlisted ? watchlistedStyle : notWatchlistedStyle,
      child: isWatchlisted ? watchlistedIcon : notWatchlistedIcon,
    );
  }
}
