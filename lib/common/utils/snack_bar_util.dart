import 'package:flutter/material.dart';

class SnackBarUtils {
  static snackBar(
    BuildContext context, {
    required String text,
  }) async {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.pinkAccent,
        behavior: SnackBarBehavior.fixed,
        duration: const Duration(
          milliseconds: 2000,
        ),
        content: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
