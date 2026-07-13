import 'package:flutter/foundation.dart';
import 'package:signalr_core/signalr_core.dart';

class SignalRConnection {
  SignalRConnection._();

  static final SignalRConnection instance = SignalRConnection._();

  HubConnection? _hubConnection;

  bool _isReconnectRunning = false;

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
    if (isConnected) {
      debugPrint("✅ SignalR Already Connected");
      return;
    }

    if (isConnecting) {
      debugPrint("⌛ SignalR Connecting...");
      return;
    }

    await disconnect();

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
          debugPrint("SIGNALR => $message");
        },
      ),
    )
        .build();

    _hubConnection!.serverTimeoutInMilliseconds = 60000;
    _hubConnection!.keepAliveIntervalInMilliseconds = 15000;

    _hubConnection!.onreconnecting((error) {
      debugPrint("🟡 SignalR Reconnecting...");
      debugPrint(error.toString());
    });

    _hubConnection!.onreconnected((connectionId) {
      debugPrint("🟢 SignalR Reconnected");
      debugPrint("ConnectionId => $connectionId");

      _isReconnectRunning = false;

      onReconnect();
    });

    _hubConnection!.onclose((error) async {
      debugPrint("🔴 SignalR Closed => $error");
      debugPrint("State => ${_hubConnection?.state}");

      await onClose(error);

      if (_isReconnectRunning) {
        return;
      }

      _isReconnectRunning = true;

      while (!isConnected) {
        try {
          debugPrint("🔄 Reconnecting after 5 seconds...");

          await Future.delayed(
            const Duration(seconds: 5),
          );

          await connect(
            hubUrl: hubUrl,
            onReconnect: onReconnect,
            onClose: onClose,
          );

          if (isConnected) {
            debugPrint("✅ Manual Reconnect Success");
            break;
          }
        } catch (e) {
          debugPrint("Reconnect failed => $e");
        }
      }

      _isReconnectRunning = false;
    });

    try {
      debugPrint("Hub URL => $hubUrl");
      debugPrint("Hub state before start => ${_hubConnection?.state}");

      await _hubConnection!.start();

      debugPrint("✅ SignalR Connected");
      debugPrint("ConnectionId => ${_hubConnection?.connectionId}");
      debugPrint("State => ${_hubConnection?.state}");
    } catch (e, s) {
      debugPrint("❌ SignalR Connect Error => $e");
      debugPrintStack(stackTrace: s);

      rethrow;
    }
  }

  Future<void> disconnect() async {
    try {
      if (_hubConnection != null) {
        debugPrint("Disconnecting SignalR...");
        await _hubConnection!.stop();
      }
    } catch (e) {
      debugPrint("Disconnect Error => $e");
    }

    _hubConnection = null;
  }
}