import 'package:flutter/foundation.dart';
import 'package:signalr_core/signalr_core.dart';

class SignalRConnection {
  SignalRConnection._();

  static final SignalRConnection instance = SignalRConnection._();

  final ValueNotifier<HubConnectionState> connectionState =
  ValueNotifier(HubConnectionState.disconnected);

  HubConnection? _hubConnection;

  String? _hubUrl;
  VoidCallback? _onReconnect;
  Future<void> Function(dynamic error)? _onClose;

  HubConnection? get hub => _hubConnection;

  bool get isConnected =>
      _hubConnection?.state == HubConnectionState.connected;

  bool get isConnecting =>
      _hubConnection?.state == HubConnectionState.connecting;

  Future<void> connect({
    required String hubUrl,
    required VoidCallback onReconnect,
    required Future<void> Function(dynamic error) onClose,
  }) async {
    _hubUrl = hubUrl;
    _onReconnect = onReconnect;
    _onClose = onClose;

    if (isConnected) {
      debugPrint("✅ SignalR Already Connected");
      return;
    }

    if (isConnecting) {
      debugPrint("⌛ SignalR Connecting...");
      return;
    }

    if (_hubConnection == null) {
      _hubConnection = HubConnectionBuilder()
          .withAutomaticReconnect([
        10000,
        15000,
        20000,
        30000,
        60000,
        180000,
      ])
          .withUrl(
        hubUrl,
        HttpConnectionOptions(
          transport: HttpTransportType.longPolling,
          logging: (level, message) {
            debugPrint("SIGNALR [$level] => $message");
          },
        ),
      )
          .build();

      _hubConnection!.serverTimeoutInMilliseconds = 60000;
      _hubConnection!.keepAliveIntervalInMilliseconds = 15000;

      _hubConnection!.onreconnecting((error) {
        connectionState.value = HubConnectionState.reconnecting;

        debugPrint("🟡 SignalR Reconnecting...");
        debugPrint(error?.toString() ?? "Unknown");
      });

      _hubConnection!.onreconnected((connectionId) {
        connectionState.value = HubConnectionState.connected;

        debugPrint("🟢 SignalR Reconnected");
        debugPrint("ConnectionId => $connectionId");

        _onReconnect?.call();
      });

      _hubConnection!.onclose((error) async {
        connectionState.value = HubConnectionState.disconnected;

        debugPrint("🔴 SignalR Closed");
        debugPrint(error?.toString());

        await _onClose?.call(error);
      });
    }

    connectionState.value = HubConnectionState.connecting;

    try {
      if (_hubConnection!.state == HubConnectionState.disconnected) {
        debugPrint("🚀 Starting SignalR...");
        debugPrint("Hub URL => $hubUrl");

        await _hubConnection!.start();

        connectionState.value = HubConnectionState.connected;

        debugPrint("✅ SignalR Connected");
        debugPrint("ConnectionId => ${_hubConnection!.connectionId}");

        _onReconnect?.call();
      }
    } catch (e, s) {
      connectionState.value = HubConnectionState.disconnected;

      debugPrint("❌ SignalR Connect Error => $e");
      debugPrintStack(stackTrace: s);

      try {
        await _hubConnection?.stop();
      } catch (_) {}

      _hubConnection = null;

      rethrow;
    }
  }

  Future<void> reconnect() async {
    if (_hubUrl == null ||
        _onReconnect == null ||
        _onClose == null) {
      return;
    }

    await disconnect();

    await connect(
      hubUrl: _hubUrl!,
      onReconnect: _onReconnect!,
      onClose: _onClose!,
    );
  }

  Future<void> disconnect() async {
    if (_hubConnection == null) {
      return;
    }

    try {
      debugPrint("🛑 Disconnecting SignalR...");

      await _hubConnection!.stop();
    } catch (e) {
      debugPrint("Disconnect Error => $e");
    } finally {
      connectionState.value = HubConnectionState.disconnected;
      _hubConnection = null;
    }
  }
}