import 'package:flutter/material.dart';

enum StateResult { loading, noData, hasData, error, noInput }

void showSnackbar(
    {required String text,
    required BuildContext context,
    required Color color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: color,
    ),
  );
}
