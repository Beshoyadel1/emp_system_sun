import 'dart:async';
import 'package:flutter/material.dart';
import '../../pages/notification_dialog/notification_dialog.dart';
import '../notification_audio_service/notification_audio_service.dart';
import '../../../../../../main.dart';

class NotificationDialogService {
  NotificationDialogService({NotificationAudioService? audioService})
      : _audio = audioService ?? const NotificationAudioService();
  final NotificationAudioService _audio;
  DialogRoute<void>? _route;
  int _generation = 0;
  Future<void> _tail = Future.value();
  bool get isShowing => _route?.isActive ?? false;

  Future<void> _stop() async {
    try {
      await _audio.stop();
    } catch (error) {
      debugPrint('Notification sound: $error');
    }
  }

  /// Cancel the current popup and all requests queued before this call.
  Future<void> dismiss() async {
    _generation++;
    final route = _route;
    _route = null;
    if (route?.isActive == true) route!.navigator?.removeRoute(route);
    final stopping = _stop();
    _tail = Future.wait([_tail, stopping]).then((_) {});
    await stopping;
  }

  Future<void> show(
      {required String title,
      required String subtitle,
      required Future<void> Function() onView}) {
    final generation = _generation;
    final pending =
        _tail.then((_) => _present(generation, title, subtitle, onView));
    _tail = pending.catchError((Object error) {
      debugPrint('Notification popup: $error');
    });
    return pending;
  }

  Future<void> _present(int generation, String title, String subtitle,
      Future<void> Function() onView) async {
    final context = navigatorKey.currentContext;
    if (generation != _generation || context == null || !context.mounted) {
      return;
    }
    try {
      try {
        await _audio.play();
      } catch (error) {
        debugPrint('Notification sound: $error');
      }
      if (generation != _generation || !context.mounted) return;
      late final DialogRoute<void> route;
      route = DialogRoute<void>(
          context: context,
          barrierDismissible: false,
          builder: (_) => NotificationDialog(
                title: title,
                subTitle: subtitle,
                onClose: () async {
                  if (identical(_route, route) && route.isActive) {
                    route.navigator?.removeRoute(route);
                  }
                },
                onView: () async {
                  if (!identical(_route, route)) return;
                  await dismiss();
                  await onView();
                },
              ));
      _route = route;
      await Navigator.of(context, rootNavigator: true).push(route);
      if (identical(_route, route)) _route = null;
    } finally {
      // Back/system navigation also completes the route and stops its loop.
      await _stop();
    }
  }
}
