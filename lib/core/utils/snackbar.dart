import 'package:flutter/material.dart';

showSnackbar(String message, context) {
  final snackbar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
    ),
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
