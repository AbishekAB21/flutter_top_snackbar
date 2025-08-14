import 'package:flutter/material.dart';

class FlutterTopSnackbarTheme {
  final Color backgroundColor;
  final IconData? icon;
  final TextStyle textStyle;

  const FlutterTopSnackbarTheme({
    required this.backgroundColor,
    this.icon,
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 16),
  });

  // Success
  static const success = FlutterTopSnackbarTheme(
    backgroundColor: Colors.green,
    icon: Icons.check_circle_rounded,
  );

  // Error
  static const error = FlutterTopSnackbarTheme(
    backgroundColor: Colors.red,
    icon: Icons.error_rounded,
  );

  // Info
  static const info = FlutterTopSnackbarTheme(
    backgroundColor: Colors.blue,
    icon: Icons.info_rounded,
  );

  // Warning
  static const warning = FlutterTopSnackbarTheme(
    backgroundColor: Colors.orange,
    icon: Icons.warning_rounded,
  );
}
