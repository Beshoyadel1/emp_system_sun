import 'package:emp_system_sun/core/theming/auth_local_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../features/auth_page/data/datasource/login_datasource/login_repository.dart';
import '../../../../../features/dashboard_page/data/datasource/get_provider_orders_sales_datasource/get_provider_orders_sales_repository.dart';
import '../../../data/request/get_provider_orders_sales_request/get_provider_orders_sales_request.dart';
import '../../../../../features/dashboard_page/presentation/cubit/get_provider_orders_sales_cubit/get_provider_orders_sales_state.dart';

class GetProviderOrdersSalesCubit
    extends Cubit<GetProviderOrdersSalesState> {

  GetProviderOrdersSalesCubit()
      : super(GetProviderOrdersSalesInitial());

  static GetProviderOrdersSalesCubit get(context) =>
      BlocProvider.of(context);

  Future<void> getProviderOrdersSales() async {
    if (isClosed) return;

    emit(GetProviderOrdersSalesLoading());

    final user = await AuthLocalStorage.getUser();

    if (user == null) {
      if (isClosed) return;
      emit(GetProviderOrdersSalesError("User not found"));
      return;
    }

    final result = await getProviderOrdersSalesFunction(
      request: GetProviderOrdersSalesRequest(
        providerId: user.userid ?? 0,
      ),
    );

    if (isClosed) return;

    if (result != null) {
      emit(GetProviderOrdersSalesSuccess(result));
    } else {
      emit(GetProviderOrdersSalesError("Error loading data"));
    }
  }
}