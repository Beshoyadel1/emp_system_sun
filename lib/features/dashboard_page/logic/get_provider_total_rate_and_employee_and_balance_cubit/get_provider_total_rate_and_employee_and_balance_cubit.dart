import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/api_functions/statistics/get_provider_total_rate_and_employee_and_balance_model/get_provider_total_rate_and_employee_and_balance_repository.dart';
import '../../../../core/api_functions/statistics/get_provider_total_rate_and_employee_and_balance_model/get_provider_total_rate_and_employee_and_balance_request.dart';
import '../../../../features/dashboard_page/logic/get_provider_total_rate_and_employee_and_balance_cubit/get_provider_total_rate_and_employee_and_balance_state.dart';
import '../../../../core/api_functions/user/login_model/login_repository.dart';

class GetProviderTotalRateAndEmployeeAndBalanceCubit
    extends Cubit<GetProviderTotalRateAndEmployeeAndBalanceState> {

  GetProviderTotalRateAndEmployeeAndBalanceCubit()
      : super(GetProviderTotalRateAndEmployeeAndBalanceInitial());

  static GetProviderTotalRateAndEmployeeAndBalanceCubit get(context) =>
      BlocProvider.of(context);

  Future<void> getProviderTotalRateAndEmployeeAndBalance() async {
    emit(GetProviderTotalRateAndEmployeeAndBalanceLoading());

    final user = await AuthLocalStorage.getUser();

    if (user == null) {
      emit(GetProviderTotalRateAndEmployeeAndBalanceError(
          "User not found"));
      return;
    }

    final result =
    await getProviderTotalRateAndEmployeeAndBalanceFunction(
      request:
      GetProviderTotalRateAndEmployeeAndBalanceRequest(
        providerId: user.userid ?? 0,
      ),
    );

    if (result != null) {
      emit(GetProviderTotalRateAndEmployeeAndBalanceSuccess(result));
    } else {
      emit(GetProviderTotalRateAndEmployeeAndBalanceError(
          "Error loading data"));
    }
  }
}