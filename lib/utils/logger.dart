import 'package:flutter/foundation.dart';

/// Level log yang tersedia.
enum LogLevel { debug, info, warning, error }

/// Logger terstruktur: hanya aktif di mode debug dan tidak mencatat
/// data sensitif.
///
/// Pesan yang mengandung pola `token`, `api key`, `password`, atau `pin`
/// otomatis disamarkan dengan `***` melalui [_redact].
class Logger {
  Logger._(); // prevent instantiation

  /// Log level [debug].
  static void debug(String message, {String tag = 'APP'}) =>
      _log(LogLevel.debug, message, tag);

  /// Log level [info].
  static void info(String message, {String tag = 'APP'}) =>
      _log(LogLevel.info, message, tag);

  /// Log level [warning].
  static void warning(String message, {String tag = 'APP'}) =>
      _log(LogLevel.warning, message, tag);

  /// Log level [error].
  static void error(String message, {String tag = 'APP'}) =>
      _log(LogLevel.error, message, tag);

  static void _log(LogLevel level, String message, String tag) {
    if (!kDebugMode) return; // tidak ada log di release
    debugPrint('[${level.name.toUpperCase()}][$tag] ${_redact(message)}');
  }

  /// Menyamarkan nilai token/api key/password/pin pada pesan log.
  ///
  /// Contoh:
  /// - `"token=abc123"` → `"token=***"`
  /// - `"API_KEY: xyz"` → `"API_KEY=***"`
  static String _redact(String message) {
    return message.replaceAllMapped(
      RegExp(
        r'(token|api[_\-]?key|password|pin)\s*[:=]\s*\S+',
        caseSensitive: false,
      ),
      (m) => '${m.group(1)}=***',
    );
  }
}
