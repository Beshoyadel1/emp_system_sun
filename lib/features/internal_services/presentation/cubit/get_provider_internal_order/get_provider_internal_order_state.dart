import 'package:emp_system_sun/core/theming/auth_local_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../../features/internal_services/data/datasource/get_provider_orders_datasource/get_provider_orders_repository.dart';
import '../../../data/request/get_provider_orders_request/get_provider_orders_request.dart';
import 'get_provider_internal_order_cubit.dart';
import 'dart:async';
import 'package:emp_system_sun/core/api/dio_function/api_constants.dart';
import 'package:emp_system_sun/features/internal_services/data/model/get_provider_orders_model/order_model.dart';
import 'package:emp_system_sun/features/notifications/data/model/notification_payload.dart';
import 'package:emp_system_sun/features/notifications/data/notification_updates.dart';

class GetProviderInternalOrderCubit
    extends Cubit<GetProviderInternalOrderState> {
  GetProviderInternalOrderCubit({NotificationUpdates? updates})
      : _updates = updates ?? NotificationUpdates.instance,
        super(GetProviderInternalOrderInitial()) {
    _subscription = _updates.stream.listen(_onUpdate);
  }

  final NotificationUpdates _updates;
  late final StreamSubscription<NotificationPayload> _subscription;
  int? _orderType, _serviceId, _branchId, _providerId;
  Set<int>? _allowedServiceIds;
  int _request = 0;
  final Map<int, Map<String, dynamic>> _pendingPatches = {};

  bool? _matches(OrderModel order) {
    if (_providerId != null) {
      if (order.providerId == null) return null;
      if (order.providerId != _providerId) return false;
    }
    if (_branchId != null) {
      if (order.branchId == null) return null;
      if (order.branchId != _branchId) return false;
    }
    if (_orderType != null) {
      if (order.orderStatus == null) return null;
      final statuses = switch (_orderType) {
        OrderType.New => OrderType.newOrders,
        OrderType.current => OrderType.currentOrders,
        OrderType.done => OrderType.doneOrders,
        _ => <int>[],
      };
      if (!statuses.contains(order.orderStatus)) return false;
    }
    if (_serviceId != null) {
      if (order.services == null) return null;
      if (!order.services!
          .any((s) => s.id == _serviceId || s.parentId == _serviceId)) {
        return false;
      }
    }
    if (_allowedServiceIds != null) {
      if (order.services == null) return null;
      if (!order.services!.any((s) =>
          _allowedServiceIds!.contains(s.id) ||
          _allowedServiceIds!.contains(s.parentId))) {
        return false;
      }
    }
    return true;
  }

  void _onUpdate(NotificationPayload payload) {
    if (isClosed || !payload.isOrder || payload.orderId == null) return;
    if (state is GetProviderInternalOrderLoading) {
      _pendingPatches[payload.orderId!] = Map<String, dynamic>.from(
          NotificationPayload.mergeJson(
              _pendingPatches[payload.orderId] ?? {}, payload.orderPatch));
      return;
    }
    if (state is! GetProviderInternalOrderSuccess) return;
    final snapshot = state as GetProviderInternalOrderSuccess;
    final orders = List<OrderModel>.from(snapshot.orders);
    final index = orders.indexWhere((o) => o.id == payload.orderId);
    final order = (index < 0 ? OrderModel(id: payload.orderId) : orders[index])
        .applyPatch(index < 0
            ? _updates.orders[payload.orderId] ?? payload.orderPatch
            : payload.orderPatch);
    final match = _matches(order);
    var count = snapshot.totalCount;
    if (index >= 0) {
      if (match == false) {
        orders.removeAt(index);
        count = (count - 1).clamp(0, count);
      } else {
        orders[index] = order;
      }
    } else if (match == true && snapshot.currentPage == 1) {
      orders.insert(0, order);
      count++;
    } else if (match == null && snapshot.currentPage == 1) {
      unawaited(_updates.enrichOrder(payload).catchError((Object error) {
        // Keep the current snapshot usable; a manual refresh can retry.
      }));
      return;
    } else {
      return;
    }
    emit(GetProviderInternalOrderSuccess(orders,
        currentPage: snapshot.currentPage,
        pageCount: snapshot.pageCount,
        totalCount: count));
  }

  Future<void> loadInternalOrders({
    int? orderType,
    int? serviceId,
    int? pageNumber,
  }) async {
    final request = ++_request;
    _pendingPatches.clear();
    _orderType = orderType;
    _serviceId = serviceId;

    if (!isClosed) {
      emit(GetProviderInternalOrderLoading());
    }

    try {
      final user = await AuthLocalStorage.getUser();
      if (isClosed || request != _request) return;

      if (user == null) {
        if (!isClosed) {
          emit(const GetProviderInternalOrderError("User not found"));
        }
        return;
      }
      final employee = user.employeeDetails;
      if (employee == null) {
        emit(const GetProviderInternalOrderError('Employee details missing'));
        return;
      }
      final allOrders = employee.permissions?.acceptAllOrders == true;
      final managesOrders =
          employee.permissions?.acceptAndRefuseAndAssignOrders == true;
      _providerId = employee.employeeDetails?.provid;
      _branchId = allOrders || managesOrders
          ? null
          : employee.employeeDetails?.branchid;
      _allowedServiceIds =
          managesOrders && !allOrders ? employee.serviceIds.toSet() : null;
      if (_allowedServiceIds?.isEmpty == true) {
        emit(const GetProviderInternalOrderSuccess([]));
        return;
      }

      final requestedPage = pageNumber ?? 1;
      final providerRequest = GetProviderOrdersRequest.forEmployee(
          employee: employee,
          pageNumber: _allowedServiceIds == null ? requestedPage : 1,
          orderType: orderType,
          serviceId: serviceId);
      final response = await getProviderOrdersFunction(
        getProviderOrdersRequest: providerRequest,
      );
      var visibleOrders = response.data;
      var visiblePage = response.currentPage;
      var visiblePageCount = response.pageCount;
      var visibleTotal = response.totalCount;
      if (_allowedServiceIds != null) {
        final allProviderOrders = <OrderModel>[...response.data];
        for (var page = 2; page <= response.pageCount; page++) {
          if (isClosed || request != _request) return;
          final next = await getProviderOrdersFunction(
            getProviderOrdersRequest: GetProviderOrdersRequest.forEmployee(
              employee: employee,
              pageNumber: page,
              orderType: orderType,
              serviceId: serviceId,
            ),
          );
          allProviderOrders.addAll(next.data);
        }
        final matching = allProviderOrders
            .where((order) => _matches(order) == true)
            .toList();
        final pageSize = response.data.isEmpty ? 10 : response.data.length;
        visibleTotal = matching.length;
        visiblePageCount =
            (matching.length / pageSize).ceil().clamp(1, 1 << 30);
        visiblePage = requestedPage.clamp(1, visiblePageCount);
        visibleOrders =
            matching.skip((visiblePage - 1) * pageSize).take(pageSize).toList();
      }

      if (!isClosed && request == _request) {
        emit(
          GetProviderInternalOrderSuccess(
            visibleOrders,
            currentPage: visiblePage,
            pageCount: visiblePageCount,
            totalCount: visibleTotal,
          ),
        );
        for (final entry in _pendingPatches.entries.toList()) {
          _onUpdate(NotificationPayload({
            'type': 'update_order_status',
            'orderId': entry.key,
            'orderInfo': entry.value
          }));
        }
        _pendingPatches.clear();
      }
    } catch (e) {
      if (!isClosed && request == _request) {
        emit(GetProviderInternalOrderError(e.toString()));
      }
    }
  }

  @override
  Future<void> close() async {
    _request++;
    await _subscription.cancel();
    return super.close();
  }
}
