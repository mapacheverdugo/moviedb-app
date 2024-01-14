import 'package:flutter/material.dart';

class FloatingBackButton extends StatelessWidget {
  const FloatingBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      onPressed: () => _onBackTap(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.tertiary,
        foregroundColor: colorScheme.onTertiary,
        elevation: 0,
      ),
      child: const Row(
        children: [
          Icon(Icons.arrow_back),
          SizedBox(width: 8),
          Text("Back"),
          SizedBox(width: 8),
        ],
      ),
    );
  }

  void _onBackTap(BuildContext context) {
    Navigator.of(context).pop();
  }
}
