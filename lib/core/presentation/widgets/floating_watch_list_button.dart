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
          Icon(Icons.bookmark_rounded),
        ],
      ),
    );
  }

  void _onWatchlistTap(BuildContext context) {
    Navigator.of(context).pushNamed('/watchlist');
  }
}
