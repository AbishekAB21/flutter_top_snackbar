import 'package:flutter/material.dart';
import 'package:flutter_top_snackbar/src/theme.dart';
import 'package:flutter_top_snackbar/src/animation_type.dart';

/// A widget that shows a custom snackbar from the top 

class FlutterTopSnackbarWidget extends StatefulWidget {
  final String message;
  final Duration duration;
  final VoidCallback onDismissed;
  final FlutterTopSnackbarTheme snackbarTheme;
  final double borderRadius;
  final double elevation;
  final EdgeInsetsGeometry padding;
  final bool dismissible;
  final AnimationTypes animationType;
  final SnackBarAction? action;
  final DismissDirection? dismissDirection;

  const FlutterTopSnackbarWidget({
    super.key,
    required this.message,
    required this.duration,
    required this.onDismissed,
    required this.snackbarTheme,
    this.borderRadius = 10.0,
    this.elevation = 6.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.dismissible = false,
    this.animationType = AnimationTypes.slideFromTop,
    this.action,
    this.dismissDirection,
  });

  @override
  State<FlutterTopSnackbarWidget> createState() =>
      _FlutterTopSnackbarWidgetState();
}

class _FlutterTopSnackbarWidgetState extends State<FlutterTopSnackbarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _setupAnimation();

    _controller.forward();

    Future.delayed(widget.duration, () {
      _controller.reverse().then((_) => widget.onDismissed);
    });
  }

  // Animation logic
  void _setupAnimation() {
    switch (widget.animationType) {
      // Slide from top
      case AnimationTypes.slideFromTop:
        _slideAnimation = Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
        break;

      // Fade
      case AnimationTypes.fade:
        _fadeAnimation = CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut,
        );
        break;

      // Scale
      case AnimationTypes.scale:
        _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
        );
        break;

      // Slide from left
      case AnimationTypes.slideFromLeft:
        _slideAnimation = Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
        break;

      // Slide from right
      case AnimationTypes.slideFromRight:
        _slideAnimation = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {

    // Snackbar UI
    final content = Material(
      elevation: widget.elevation,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      color: widget.snackbarTheme.backgroundColor,
      child: Padding(
        padding: widget.padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.snackbarTheme.icon != null) ...[
              Icon(
                widget.snackbarTheme.icon,
                color: widget.snackbarTheme.textStyle.color,
              ),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                widget.message,
                style: widget.snackbarTheme.textStyle,
              ),
            ),
            if (widget.action != null) widget.action!,
          ],
        ),
      ),
    );

    // Animated Content
    Widget animatedContent;
    switch (widget.animationType) {
      case AnimationTypes.slideFromTop:
      case AnimationTypes.slideFromLeft:
      case AnimationTypes.slideFromRight:
        animatedContent = SlideTransition(
          position: _slideAnimation,
          child: content,
        );
        break;
      case AnimationTypes.fade:
        animatedContent = FadeTransition(
          opacity: _fadeAnimation,
          child: content,
        );
        break;
      case AnimationTypes.scale:
        animatedContent = ScaleTransition(
          scale: _scaleAnimation,
          child: content,
        );
        break;
    }

    return Positioned(
      child:
          widget.dismissible
              ? Dismissible(
                key: UniqueKey(),
                direction: widget.dismissDirection ?? DismissDirection.up,
                child: animatedContent,
              )
              : animatedContent,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
