import 'package:audioplayers/audioplayers.dart';

class AudioService {
  AudioService._();

  static final AudioService instance = AudioService._();

  late final AudioPlayer _player = AudioPlayer();
  late final AudioPlayer _chatPlayer = AudioPlayer();
  bool _loopStarted = false, _chatStarted = false;

  Future<void> playChatSound() async {
    _chatStarted = true;
    await _chatPlayer.stop();
    await _chatPlayer.setReleaseMode(ReleaseMode.release);
    await _chatPlayer.play(AssetSource('sounds/notification.mp3'));
  }

  Future<void> stopChatSound() async {
    if (!_chatStarted) return;
    await _chatPlayer.stop();
    _chatStarted = false;
  }

  Future<void> startNotificationSound() async {
    _loopStarted = true;
    await _player.stop();

    await _player.setReleaseMode(ReleaseMode.loop);

    await _player.play(
      AssetSource("sounds/notification.mp3"),
    );
  }

  Future<void> stopNotificationSound() async {
    if (!_loopStarted) return;
    await _player.stop();

    await _player.setReleaseMode(ReleaseMode.release);
    _loopStarted = false;
  }
}
