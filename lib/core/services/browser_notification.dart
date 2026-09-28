import 'browser_notification_stub.dart'
    if (dart.library.js_interop) 'browser_notification_web.dart';

void showBrowserNotification(String title, String body) {
  showNativeBrowserNotification(title, body);
}
