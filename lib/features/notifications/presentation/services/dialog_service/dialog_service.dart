import 'package:flutter/material.dart';
import '../../../../../../features/notifications/presentation/custom_widget/notification_dialog_helper.dart';
import '../../../../../../features/notifications/presentation/services/navigation_service/navigation_service.dart';
import '../../../../../../features/notifications/presentation/services/notification_audio_service/notification_audio_service.dart';
import '../../../../../../main.dart';

class NotificationDialogService {
  BuildContext get context => navigatorKey.currentContext!;

  NotificationDialogService({
    NotificationAudioService? audioService,
    NotificationNavigationService? navigationService,
  })  : _audio = audioService ?? const NotificationAudioService(),
        _navigation =
            navigationService ?? const NotificationNavigationService();

  final NotificationAudioService _audio;
  final NotificationNavigationService _navigation;

  bool _isShowing = false;

  bool get isShowing => _isShowing;

  Future<void> show({
    required String title,
    required String subtitle,
    required Future<void> Function() onView,
  }) async {
    final context = navigatorKey.currentContext;

    if (context == null) {
      return;
    }

    await _audio.play();

    if (_isShowing) {
      Navigator.of(
        context,
        rootNavigator: true,
      ).pop();

      _isShowing = false;

      await Future.delayed(
        const Duration(milliseconds: 150),
      );
    }

    _isShowing = true;

    await NotificationDialogHelper.show(
      context: context,
      title: title,
      subTitle: subtitle,
      onClose: () async {
        await _audio.stop();

        _isShowing = false;

        Navigator.pop(context);
      },
      onView: () async {
        await _audio.stop();

        _isShowing = false;

        Navigator.of(
          context,
          rootNavigator: true,
        ).pop();

        // استدعاء الـ Action القادم من الـ Handler
        await onView();
      },
    );

    _isShowing = false;
  }
}
