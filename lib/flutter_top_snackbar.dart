library flutter_top_snackbar;

import 'package:flutter/material.dart';
import 'package:flutter_top_snackbar/src/animation_type.dart';
import 'package:flutter_top_snackbar/src/flutter_top_snackbar_widget.dart';
import 'package:flutter_top_snackbar/src/theme.dart';

/// A utility class to show a snackbar from the top of the screen.
class FlutterTopSnackbar {
  /// Shows a top snackbar with a slide animation.

  // Snackbar with predefined themes
  static void show(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    FlutterTopSnackbarTheme snackbarTheme = FlutterTopSnackbarTheme.info,
    Color? customBackgroundColor,
    IconData? customIcon,
    double borderRadius = 10.0,
    double elevation = 6.0,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 16,
    ),
    bool dismissible = false,
    AnimationTypes animationType = AnimationTypes.slideFromTop,
    SnackBarAction? action,
    DismissDirection? dismissDirection,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    // If custom color/Icon exists, then override the predefined theme
    final appliedTheme = FlutterTopSnackbarTheme(
      backgroundColor: customBackgroundColor ?? snackbarTheme.backgroundColor,
      icon: customIcon ?? snackbarTheme.icon,
    );

    overlayEntry = OverlayEntry(
      builder:
          (context) => FlutterTopSnackbarWidget(
            message: message,
            duration: duration,
            onDismissed: () => overlayEntry.remove(),
            snackbarTheme: appliedTheme,
            borderRadius: borderRadius,
            animationType: animationType,
            dismissible: dismissible,
            dismissDirection: dismissDirection,
            action: action,
          ),
    );

    overlay.insert(overlayEntry);
  }

  // Success
  static void success(BuildContext context, String message) {
    show(context, message, snackbarTheme: FlutterTopSnackbarTheme.success);
  }

  // Error
  static void error(BuildContext context, String message) {
    show(context, message, snackbarTheme: FlutterTopSnackbarTheme.error);
  }

  // Info
  static void info(BuildContext context, String message) {
    show(context, message, snackbarTheme: FlutterTopSnackbarTheme.info);
  }

  // Warning
  static void warning(BuildContext context, String message) {
    show(context, message, snackbarTheme: FlutterTopSnackbarTheme.warning);
  }
}
