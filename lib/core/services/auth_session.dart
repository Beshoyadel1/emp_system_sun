/// Shared by the root auth cubit and the separate password/OTP flow cubits.
class AuthSession {
  static int _version = 0;
  static int get version => _version;
  static bool isCurrent(int version) => version == _version;
  static int beginAttempt() => ++_version;

  static Future<void> _effects = Future.value();
  static Future<void> _cleanup = Future.value();
  static Future<void> get ready => _cleanup;

  // An old FCM connection must finish before logout disconnects it or the
  // next account connects. Network login requests stay outside this queue.
  static Future<void> runEffect(Future<void> Function() action) {
    final next = _effects.then((_) => action());
    _effects = next.then<void>((_) {}, onError: (Object _, StackTrace __) {});
    return next;
  }

  static Future<void> endSession(Future<void> Function() cleanup) {
    ++_version; // Invalidate requests immediately, before the first await.
    return _cleanup = runEffect(cleanup);
  }
}
