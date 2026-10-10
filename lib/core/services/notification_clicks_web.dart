import 'dart:convert';
import 'dart:js_interop';

@JS('listenForSunNotificationClicks')
external JSFunction _listen(JSFunction callback);

void Function() listenForNotificationClicks(
    void Function(Map<String, dynamic>) onClick) {
  final stop = _listen(((JSString raw) {
    try {
      final decoded = jsonDecode(raw.toDart);
      if (decoded is Map) onClick(Map<String, dynamic>.from(decoded));
    } catch (_) {}
  }).toJS);
  return () => stop.callAsFunction();
}
