import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tidyo/Core/Theme/AppTokens.dart';
import 'package:tidyo/Core/Utils/AppLogger.dart';

class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function(FlutterErrorDetails details)? fallbackBuilder;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.fallbackBuilder,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  FlutterErrorDetails? _errorDetails;

  @override
  void initState() {
    super.initState();
    _installErrorHandler();
  }

  void _installErrorHandler() {
    if (!kReleaseMode) return;
    ErrorWidget.builder = (FlutterErrorDetails details) {
      AppLogger.e(
        'Widget build error intercepted by ErrorBoundary: ${details.exception}',
        stack: details.stack,
      );
      if (mounted) {
        setState(() => _errorDetails = details);
      }
      return widget.fallbackBuilder?.call(details) ?? _defaultErrorWidget(details);
    };
  }

  Widget _defaultErrorWidget(FlutterErrorDetails details) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: Tk.shadow,
          border: Border.all(color: const Color(0xFFFCA5A5), width: 1.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline_rounded, color: Color(0xFFEF4444), size: 40),
            const SizedBox(height: 12),
            const Text(
              'Rendering Issue Recovered',
              style: TextStyle(
                fontFamily: Tk.font,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Tk.ink,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              kDebugMode
                  ? details.exception.toString()
                  : 'An unexpected UI error was safely isolated by Tidyo.',
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: Tk.font,
                fontSize: 12,
                color: Tk.faint,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_errorDetails != null && !kDebugMode) {
      return widget.fallbackBuilder?.call(_errorDetails!) ?? _defaultErrorWidget(_errorDetails!);
    }
    return widget.child;
  }
}
