import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../features/internal_services/data/datasource/get_order_details_datasource/get_order_details_datasource.dart';
import '../../../../../../../features/internal_services/data/model/get_provider_orders_model/order_details_model.dart';
import '../../../../../../../features/internal_services/data/request/get_order_details_request/get_order_details_datasource.dart';
import '../../../../../../../features/internal_services/presentation/cubit/get_order_details_cubit/get_order_details_state.dart';

class GetOrderDetailsCubit
    extends Cubit<GetOrderDetailsState> {
  GetOrderDetailsCubit({
    required this.getOrderDetailsDatasource,
  }) : super(GetOrderDetailsInitial());

  final GetOrderDetailsDatasource getOrderDetailsDatasource;

  OrderDetailsModel? orderDetails;

  Future<void> getOrderDetails() async {
    emit(GetOrderDetailsLoading());

    try {
      final result = await getOrderDetailsFunction(
        getOrderDetailsDatasource: getOrderDetailsDatasource,
      );

      orderDetails = result;

      emit(
        GetOrderDetailsSuccess(
          orderDetails: result,
        ),
      );
    } catch (e) {
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
}