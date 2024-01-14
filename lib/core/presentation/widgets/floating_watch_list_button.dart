import 'package:flutter/material.dart';

class FloatingWatchListButton extends StatelessWidget {
  const FloatingWatchListButton({
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Row(
        children: [
          Text("Watch List"),
          SizedBox(width: 8),
          Icon(Icons.bookmark),
        ],
      ),
    );
  }
}
