import 'dart:js_interop';

@JS('showBrowserNotification')
external void _showBrowserNotification(JSString title, JSString body);

void showNativeBrowserNotification(String title, String body) {
  try {
    _showBrowserNotification(title.toJS, body.toJS);
  } catch (_) {}
}
