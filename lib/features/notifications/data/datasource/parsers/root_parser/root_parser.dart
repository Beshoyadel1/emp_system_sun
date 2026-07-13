import 'package:flutter/foundation.dart';

class RootParser {
  const RootParser();

  Map<String, dynamic>? parse(List<Object?>? arguments) {
    if (arguments == null || arguments.isEmpty) {
      return null;
    }

    final first = arguments.first;

    if (first is! Map) {
      debugPrint("SignalR: Invalid arguments");
      return null;
    }

    return Map<String, dynamic>.from(first);
  }
}