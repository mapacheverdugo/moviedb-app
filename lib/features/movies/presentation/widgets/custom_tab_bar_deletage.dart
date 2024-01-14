import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar({
    super.key,
    required this.tabs,
    this.padding = EdgeInsets.zero,
  });

  final List<Widget> tabs;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        TabBar(
          labelPadding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 0,
          ),
          padding: padding,
          isScrollable: true,
          indicatorWeight: 4,
          indicatorColor: colorScheme.tertiary,
          indicatorPadding: EdgeInsets.zero,
          tabs: tabs,
        ),
        const Spacer(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(41 + padding.vertical);
}
