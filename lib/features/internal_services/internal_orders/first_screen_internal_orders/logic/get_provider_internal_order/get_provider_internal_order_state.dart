import 'package:emp_system_sun/core/api_functions/order/get_provider_orders_model/get_provider_orders_repository.dart';
import 'package:emp_system_sun/core/api_functions/order/get_provider_orders_model/get_provider_orders_request.dart';
import 'package:emp_system_sun/core/api_functions/user/login_model/login_repository.dart';
import 'package:emp_system_sun/features/internal_services/internal_orders/first_screen_internal_orders/logic/get_provider_internal_order/get_provider_internal_order_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class GetProviderInternalOrderCubit
    extends Cubit<GetProviderInternalOrderState> {

  GetProviderInternalOrderCubit()
      : super(GetProviderInternalOrderInitial());

  Future<void> loadInternalOrders({
    int? orderType,
    int? serviceId,
    int? pageNumber,
  }) async {

    emit(GetProviderInternalOrderLoading());

    try {
      final user = await AuthLocalStorage.getUser();

      if (user == null) {
        emit(const GetProviderInternalOrderError("User not found"));
        return;
      }

      final response = await getProviderOrdersFunction(
        getProviderOrdersRequest: GetProviderOrdersRequest(
          providerId: user.employeeWrapper?.employeeDetails?.provid,
          employeeId: user.employeeWrapper?.employeeDetails?.id,
          pageNumber: pageNumber ?? 1,
          orderType: orderType,
          serviceId: serviceId,
        ),
      );

      final currentPage = response.currentPage ?? 1;
      final pageCount = response.pageCount ?? 1;
      final totalCount = response.totalCount ?? 1;


      emit(
        GetProviderInternalOrderSuccess(
          response.data ?? [],
          currentPage: currentPage,
          pageCount: pageCount,
          totalCount: totalCount,
        ),
      );

    } catch (e) {
      emit(GetProviderInternalOrderError(e.toString()));
    }
  }
}