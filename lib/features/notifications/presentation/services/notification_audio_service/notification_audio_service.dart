import '../../../../../../core/audio_service/audio_service.dart';

class NotificationAudioService {
  const NotificationAudioService();

  Future<void> play() async {
    await AudioService.instance.startNotificationSound();
  }

  Future<void> stop() async {
    await AudioService.instance.stopNotificationSound();
  }
}