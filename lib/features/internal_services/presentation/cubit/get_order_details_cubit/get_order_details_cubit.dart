import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:emp_system_sun/features/notifications/data/model/notification_payload.dart';
import 'package:emp_system_sun/features/notifications/data/notification_updates.dart';
import '../../../../../../../features/internal_services/data/datasource/get_order_details_datasource/get_order_details_datasource.dart';
import '../../../../../../../features/internal_services/data/model/get_provider_orders_model/order_details_model.dart';
import '../../../../../../../features/internal_services/data/request/get_order_details_request/get_order_details_datasource.dart';
import '../../../../../../../features/internal_services/presentation/cubit/get_order_details_cubit/get_order_details_state.dart';

class GetOrderDetailsCubit extends Cubit<GetOrderDetailsState> {
  GetOrderDetailsCubit({
    required this.getOrderDetailsDatasource,
    NotificationUpdates? updates,
  })  : _updates = updates ?? NotificationUpdates.instance,
        super(GetOrderDetailsInitial()) {
    _subscription = _updates.stream.listen((payload) {
      if (isClosed ||
          !payload.isOrder ||
          payload.orderId != getOrderDetailsDatasource.orderId) {
        return;
      }
      if (_loading) {
        _pendingPatch = Map<String, dynamic>.from(
            NotificationPayload.mergeJson(_pendingPatch, payload.orderPatch));
        return;
      }
      if (orderDetails == null) return;
      try {
        orderDetails = orderDetails!.applyNotificationPatch(payload.orderPatch);
        emit(GetOrderDetailsSuccess(orderDetails: orderDetails!));
      } catch (_) {}
    });
  }
  final NotificationUpdates _updates;
  late final StreamSubscription<NotificationPayload> _subscription;
  int _request = 0;
  bool _loading = false;
  Map<String, dynamic> _pendingPatch = {};

  final GetOrderDetailsDatasource getOrderDetailsDatasource;

  OrderDetailsModel? orderDetails;

  Future<void> getOrderDetails() async {
    if (isClosed) return;
    final request = ++_request;
    _loading = true;
    _pendingPatch = {};
    emit(GetOrderDetailsLoading());

    try {
      final result = await getOrderDetailsFunction(
        getOrderDetailsDatasource: getOrderDetailsDatasource,
      );
      if (isClosed || request != _request) return;
      orderDetails = result.applyNotificationPatch(_pendingPatch);
      _loading = false;

      emit(
        GetOrderDetailsSuccess(
          orderDetails: orderDetails!,
        ),
      );
    } catch (e) {
      if (isClosed || request != _request) return;
      _loading = false;
      emit(
        GetOrderDetailsError(
          message: e.toString().replaceFirst(
                'Exception: ',
                '',
              ),
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    _request++;
    await _subscription.cancel();
    return super.close();
  }
}
