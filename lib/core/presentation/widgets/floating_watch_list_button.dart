import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';

class FloatingWatchListButton extends StatelessWidget {
  const FloatingWatchListButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _onWatchlistTap(context),
      child: const Row(
        children: [
          Text("Watch List"),
          SizedBox(width: 8),
          Icon(
            BootstrapIcons.bookmark_fill,
            size: 18,
          ),
        ],
      ),
    );
  }

  void _onWatchlistTap(BuildContext context) {
    Navigator.of(context).pushNamed('/watchlist');
  }
}
