import 'package:logger/logger.dart';

class CustomLogPrinter extends LogPrinter {
  final String className;

  CustomLogPrinter({required this.className});

  @override
  List<String> log(LogEvent event) {
    final levelPrefix = {
      Level.trace: '🔹 TRACE',
      Level.debug: '🔹 DEBUG',
      Level.info: 'ℹ️ INFO',
      Level.warning: '⚠️ WARN',
      Level.error: '❌ ERROR',
      Level.fatal: '💀 FATAL',
    }[event.level];

    return ['[$levelPrefix] $className - ${event.message}'];
  }
}
