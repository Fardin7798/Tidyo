import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  static bool enableDebugLogs = kDebugMode;

  static void d(String message, {String? tag}) {
    if (!enableDebugLogs) return;
    debugPrint(tag != null ? '🟢 [$tag] $message' : '🟢 $message');
  }

  static void w(String message, {String? tag}) {
    if (!enableDebugLogs) return;
    debugPrint(tag != null ? '🟡 [$tag] $message' : '🟡 $message');
  }

  static void e(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stack,
  }) {
    final label = tag != null ? '🔴 [$tag] $message' : '🔴 $message';
    debugPrint(label);
    if (error != null) debugPrint('Error: $error');
    if (stack != null) debugPrint('Stack: $stack');
  }
}
