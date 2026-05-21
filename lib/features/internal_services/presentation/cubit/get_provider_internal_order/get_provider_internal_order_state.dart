import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../../features/internal_services/data/datasource/get_provider_orders_datasource/get_provider_orders_repository.dart';
import '../../../../../../../../../features/auth_page/data/datasource/login_datasource/login_repository.dart';
import '../../../data/request/get_provider_orders_request/get_provider_orders_request.dart';
import '../../../../../../../../../features/internal_services/presentation/cubit/get_provider_internal_order/get_provider_internal_order_cubit.dart';

class GetProviderInternalOrderCubit
    extends Cubit<GetProviderInternalOrderState> {

  GetProviderInternalOrderCubit()
      : super(GetProviderInternalOrderInitial());

  Future<void> loadInternalOrders({
    int? orderType,
    int? serviceId,
    int? pageNumber,
  }) async {

    if (!isClosed) {
      emit(GetProviderInternalOrderLoading());
    }

    try {
      final user = await AuthLocalStorage.getUser();

      if (user == null) {
        if (!isClosed) {
          emit(const GetProviderInternalOrderError("User not found"));
        }
        return;
      }

      final response = await getProviderOrdersFunction(

        getProviderOrdersRequest: GetProviderOrdersRequest(
          providerId: user.employeeDetails?.employeeDetails?.provid,
          employeeId: user.employeeDetails?.employeeDetails?.id,
          pageNumber: pageNumber ?? 1,
          orderType: orderType,
          serviceId: serviceId,
        ),
      );

      if (!isClosed) {
        emit(

          GetProviderInternalOrderSuccess(
            response.data ?? [],
            currentPage: response.currentPage ?? 1,
            pageCount: response.pageCount ?? 1,
            totalCount: response.totalCount ?? 1,
          ),
        );
      }

    } catch (e) {
      if (!isClosed) {
        emit(GetProviderInternalOrderError(e.toString()));
      }
    }
  }
}