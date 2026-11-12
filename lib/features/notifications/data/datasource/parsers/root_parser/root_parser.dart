class RootParser {
  const RootParser();

  Map<String, dynamic>? parse(List<Object?>? arguments) {
    if (arguments == null || arguments.isEmpty) {
      return null;
    }

    final first = arguments.first;

    if (first is! Map) {
      return null;
    }

    return Map<String, dynamic>.from(first);
  }
}
