import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:kisan_app/core/constants/env_config.dart';

class AppLogs {
  static final String _tag = EnvConfig.appName;

  /// Log a message with an optional name/tag
  static void log(String message, {String? name, Object? error}) {
    if (kDebugMode) {
      developer.log(
        message,
        name: name ?? _tag,
        error: error,
        time: DateTime.now(),
      );
    }
  }

  /// Print a message to the console only in debug mode
  static void debugPrint(Object? message) {
    if (kDebugMode) {
      // ignore: avoid_print
      print('[$_tag] $message');
    }
  }

  /// Log an error message
  static void error(
    String message, {
    String? name,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (kDebugMode) {
      developer.log(
        '❌ ERROR: $message',
        name: name ?? _tag,
        error: error,
        stackTrace: stackTrace,
        time: DateTime.now(),
        level: 1000, // High level for errors
      );
    }
  }

  /// Log an info message
  static void info(String message, {String? name}) {
    if (kDebugMode) {
      developer.log(
        'ℹ️ INFO: $message',
        name: name ?? _tag,
        time: DateTime.now(),
        level: 500,
      );
    }
  }

  /// Log a success message
  static void success(String message, {String? name}) {
    if (kDebugMode) {
      developer.log(
        '✅ SUCCESS: $message',
        name: name ?? _tag,
        time: DateTime.now(),
        level: 200,
      );
    }
  }
}
