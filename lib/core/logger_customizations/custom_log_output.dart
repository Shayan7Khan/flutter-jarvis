import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CustomLogOutput extends LogOutput {
  final _pretty = PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 80,
    colors: true,
    printEmojis: true,
  );
  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      final colorFunc = _pretty.levelColors?[event.level];
      final outputLine = colorFunc != null ? colorFunc(line) : line;
      debugPrint(outputLine);
    }
  }
}
