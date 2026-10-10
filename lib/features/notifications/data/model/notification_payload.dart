import 'dart:convert';
import 'dart:typed_data';

enum NotificationKind {
  newOrder,
  orderStatus,
  orderAssigned,
  offerAccepted,
  serviceRequest,
  serviceOffer,
  chat,
  chatStatus,
  ownership,
  general,
}

/// Transport-independent data from FCM. Nested objects may be JSON strings.
class NotificationPayload {
  NotificationPayload(
    Map<String, dynamic> data, {
    String? title,
    String? body,
    this.messageId,
    DateTime? sentAt,
  })  : data = Map.unmodifiable(data),
        sentAt = sentAt ?? DateTime.now(),
        title = title ??
            value(data, 'title')?.toString() ??
            value(data, 'fromusername')?.toString() ??
            value(object(value(data, 'notification')), 'title')?.toString() ??
            '',
        body = body ??
            value(data, 'body')?.toString() ??
            value(data, 'message')?.toString() ??
            value(data, 'description')?.toString() ??
            value(object(value(data, 'notification')), 'description')
                ?.toString() ??
            '';

  final Map<String, dynamic> data;
  final String title, body;
  final String? messageId;
  final DateTime sentAt;

  static String normalize(String key) => key.toLowerCase().replaceAll('_', '');
  static dynamic value(Map data, String key) {
    for (final entry in data.entries) {
      if (normalize(entry.key.toString()) == normalize(key)) return entry.value;
    }
    return null;
  }

  static Map<String, dynamic> object(dynamic raw) {
    if (raw is String) {
      try {
        raw = jsonDecode(raw);
      } catch (_) {
        return {};
      }
    }
    return raw is Map ? Map<String, dynamic>.from(raw) : {};
  }

  /// Merge compact JSON without erasing absent fields or images.
  static dynamic mergeJson(dynamic current, dynamic patch) {
    if (current is Map && patch is Map) {
      final result = Map<String, dynamic>.from(current);
      for (final entry in patch.entries) {
        final matches = result.keys
            .where((key) => normalize(key) == normalize(entry.key.toString()));
        final key = matches.isEmpty ? entry.key.toString() : matches.first;
        result[key] = mergeJson(result[key], entry.value);
      }
      return result;
    }
    if (patch is List && current is List && current is! Uint8List) {
      return patch.map((item) {
        if (item is! Map) return item;
        final id = value(item, 'id');
        final old = current
            .whereType<Map>()
            .where((e) => id != null && '${value(e, 'id')}' == '$id');
        return old.isEmpty ? item : mergeJson(old.first, item);
      }).toList();
    }
    return patch;
  }

  static dynamic serializable(dynamic value) {
    if (value is Uint8List) return base64Encode(value);
    if (value is Map) {
      return {
        for (final e in value.entries) e.key.toString(): serializable(e.value)
      };
    }
    if (value is List) return value.map(serializable).toList();
    return value;
  }

  dynamic get(String key) => value(data, key);
  int? integer(String key) => int.tryParse('${get(key)}');
  String get type => normalize('${get('type') ?? get('eventType') ?? ''}');

  NotificationKind get kind => switch (type) {
        'neworder' => NotificationKind.newOrder,
        'updateorderstatus' ||
        'orderstatus' ||
        'ordercancelled' ||
        'cancelorder' =>
          NotificationKind.orderStatus,
        'orderassigned' => NotificationKind.orderAssigned,
        'acceptserviceoffer' ||
        'offeraccepted' =>
          NotificationKind.offerAccepted,
        'newservicerequest' => NotificationKind.serviceRequest,
        'newserviceoffer' => NotificationKind.serviceOffer,
        'chat' || 'receivemessage' => NotificationKind.chat,
        'openclosechat' => NotificationKind.chatStatus,
        'transferownership' => NotificationKind.ownership,
        _ => NotificationKind.general,
      };

  bool get isOrder => const {
        NotificationKind.newOrder,
        NotificationKind.orderStatus,
        NotificationKind.orderAssigned,
        NotificationKind.offerAccepted,
      }.contains(kind);

  Map<String, dynamic> get orderPatch {
    final raw = object(get('orderInfo'));
    final patch = {
      for (final entry in raw.entries) normalize(entry.key): entry.value
    };
    final id = integer('orderId') ?? int.tryParse('${patch['id']}');
    if (id != null) patch['id'] = id;
    final status = integer('status') ??
        int.tryParse('${patch['orderstatus'] ?? patch['status']}');
    if (status != null) {
      patch['orderstatus'] = status;
      patch['status'] = status;
    } else if (type == 'ordercancelled' || type == 'cancelorder') {
      // Existing employee API status enum; explicit server values take precedence.
      patch['orderstatus'] = 6;
      patch['status'] = 6;
    }
    final date = patch['date'] ?? patch['orderdate'];
    if (date != null) {
      patch['date'] = date;
      patch['orderdate'] = date;
    }
    return patch;
  }

  int? get orderId => int.tryParse('${orderPatch['id']}');
  Map<String, dynamic> get notification => object(get('notification'));
  int? get notificationId =>
      integer('notificationId') ?? int.tryParse('${value(notification, 'id')}');

  bool isFor(int userId, int userType) {
    final chat =
        kind == NotificationKind.chat || kind == NotificationKind.chatStatus;
    final id = integer('toUserId') ??
        integer('toUser') ??
        (chat ? null : integer('userId'));
    final type = integer('toUserType') ?? (chat ? null : integer('userType'));
    return (id == null || id == 0 || id == userId) &&
        (type == null || type == 0 || type == userType);
  }

  String get key {
    if (messageId?.isNotEmpty == true) return 'push:$messageId';
    if (kind == NotificationKind.chat && (integer('id') ?? 0) > 0) {
      return 'chat:${integer('id')}';
    }
    final sorted = {
      for (final key in (data.keys.toList()..sort())) key: data[key]
    };
    return '${kind.name}:${jsonEncode(sorted)}';
  }
}
