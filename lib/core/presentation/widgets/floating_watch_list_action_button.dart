import 'package:bootstrap_icons/bootstrap_icons.dart';
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
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 14,
      ),
    );
    const watchlistedIcon = Icon(
      BootstrapIcons.bookmark_check_fill,
      size: 18,
    );

    final notWatchlistedStyle = ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: colorScheme.tertiary,
      foregroundColor: colorScheme.onTertiary,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 14,
      ),
    );
    const notWatchlistedIcon = Icon(
      BootstrapIcons.bookmark_fill,
      size: 18,
    );

    return ElevatedButton(
      onPressed: onTap,
      style: isWatchlisted ? watchlistedStyle : notWatchlistedStyle,
      child: SizedBox(
        height: 18,
        width: 18,
        child: isWatchlisted ? watchlistedIcon : notWatchlistedIcon,
      ),
    );
  }
}
