import 'dart:js_interop';

@JS('showBrowserNotification')
external void _showBrowserNotification(
    JSString title, JSString body, JSFunction? onClick);

void showNativeBrowserNotification(String title, String body,
    {void Function()? onClick}) {
  try {
    _showBrowserNotification(title.toJS, body.toJS, onClick?.toJS);
  } catch (_) {}
}
