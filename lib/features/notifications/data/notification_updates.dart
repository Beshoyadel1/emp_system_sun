import 'dart:async';
import 'model/notification_payload.dart';
import '../../internal_services/data/datasource/get_order_details_datasource/get_order_details_datasource.dart';
import '../../internal_services/data/request/get_order_details_request/get_order_details_datasource.dart';

/// Only retains events during the current signed-in session.
class NotificationUpdates {
  static final instance = NotificationUpdates();
  final _controller =
      StreamController<NotificationPayload>.broadcast(sync: true);
  Stream<NotificationPayload> get stream => _controller.stream;
  final Map<int, Map<String, dynamic>> orders = {};
  final Map<int, int> orderVersions = {};
  final Map<int, DateTime> _orderTimes = {};
  final Map<String, NotificationPayload> notifications = {};
  int revision = 0;
  int _session = 0;
  final Map<int, Future<void>> _detailRequests = {};
  final Map<int, Map<String, dynamic>> _detailPatches = {};

  /// At most one request per order, only when a mounted filtered list lacks data.
  Future<void> enrichOrder(NotificationPayload payload) {
    final id = payload.orderId;
    if (id == null) return Future.value();
    if (_detailRequests.containsKey(id)) return _detailRequests[id]!;
    _detailPatches[id] = payload.orderPatch;
    final session = _session;
    final request = () async {
      final details = await getOrderDetailsFunction(
          getOrderDetailsDatasource: GetOrderDetailsDatasource(orderId: id));
      if (session != _session) return;
      final patch = <String, dynamic>{
        'id': id,
        'provid': details.provid,
        'branchid': details.branchid,
        'userid': details.userid,
        'usertype': details.usertype,
        'username': details.user?.username,
        'orderstatus': details.status,
        'status': details.status,
        'orderdate': details.date?.toIso8601String(),
        'totalprice': details.totalprice,
        'provname': details.providerInfo?.name,
        'provlatinname': details.providerInfo?.latinname,
        'branchname': details.providerInfo?.branchname,
        'branchlatinname': details.providerInfo?.branchlatinname,
        'services': [
          for (final s in details.services ?? [])
            {
              'id': s.id,
              'parentid': s.parentid,
              'name': s.name,
              'latinname': s.latinname,
            }
        ],
        ...?_detailPatches[id],
      }..removeWhere((_, v) => v == null);
      orders[id] = patch;
      orderVersions[id] = ++revision;
      _controller.add(NotificationPayload({
        ...payload.data,
        'orderInfo': patch,
        if (patch['orderstatus'] != null) 'status': patch['orderstatus']
      },
          title: payload.title,
          body: payload.body,
          messageId: payload.messageId,
          sentAt: payload.sentAt));
    }();
    final pending = request.whenComplete(() {
      if (session == _session) {
        _detailRequests.remove(id);
        _detailPatches.remove(id);
      }
    });
    _detailRequests[id] = pending;
    return pending;
  }

  bool add(NotificationPayload payload) {
    if (notifications.containsKey(payload.key)) return false;
    notifications[payload.key] = payload;
    if (notifications.length > 500) {
      notifications.remove(notifications.keys.first);
    }
    final id = payload.orderId;
    if (payload.isOrder && id != null && id > 0) {
      final previousTime = _orderTimes[id];
      if (previousTime != null && payload.sentAt.isBefore(previousTime)) {
        return false;
      }
      orders[id] = Map<String, dynamic>.from(
          NotificationPayload.mergeJson(orders[id] ?? {}, payload.orderPatch));
      if (_detailPatches.containsKey(id)) {
        _detailPatches[id] = Map<String, dynamic>.from(
            NotificationPayload.mergeJson(
                _detailPatches[id], payload.orderPatch));
      }
      _orderTimes[id] = payload.sentAt;
      orderVersions[id] = ++revision;
      if (orders.length > 500) {
        final oldest = orders.keys.first;
        orders.remove(oldest);
        orderVersions.remove(oldest);
        _orderTimes.remove(oldest);
      }
    }
    _controller.add(payload);
    return true;
  }

  void reset() {
    _session++;
    _detailRequests.clear();
    _detailPatches.clear();
    orders.clear();
    orderVersions.clear();
    _orderTimes.clear();
    notifications.clear();
    revision = 0;
  }

  Future<void> dispose() => _controller.close();
}
