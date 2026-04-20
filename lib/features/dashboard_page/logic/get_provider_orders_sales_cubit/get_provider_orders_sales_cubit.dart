import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/api_functions/statistics/get_provider_orders_sales_model/get_provider_orders_sales_repository.dart';
import '../../../../core/api_functions/statistics/get_provider_orders_sales_model/get_provider_orders_sales_request.dart';
import '../../../../core/api_functions/user/login_model/login_repository.dart';
import '../../../../features/dashboard_page/logic/get_provider_orders_sales_cubit/get_provider_orders_sales_state.dart';

class GetProviderOrdersSalesCubit
    extends Cubit<GetProviderOrdersSalesState> {

  GetProviderOrdersSalesCubit()
      : super(GetProviderOrdersSalesInitial());

  static GetProviderOrdersSalesCubit get(context) =>
      BlocProvider.of(context);

  Future<void> getProviderOrdersSales() async {
    emit(GetProviderOrdersSalesLoading());

    final user = await AuthLocalStorage.getUser();

    if (user == null) {
      emit(GetProviderOrdersSalesError("User not found"));
      return;
    }

    final result = await getProviderOrdersSalesFunction(
      request: GetProviderOrdersSalesRequest(
        providerId: user.userid ?? 0,
      ),
    );

    if (result != null) {
      emit(GetProviderOrdersSalesSuccess(result));
    } else {
      emit(GetProviderOrdersSalesError("Error loading data"));
    }
  }
}