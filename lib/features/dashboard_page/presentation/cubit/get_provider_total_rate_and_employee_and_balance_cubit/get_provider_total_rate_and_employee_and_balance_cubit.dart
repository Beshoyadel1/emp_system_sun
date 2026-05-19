import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../features/dashboard_page/data/datasource/get_provider_total_rate_and_employee_and_balance_datasource/get_provider_total_rate_and_employee_and_balance_repository.dart';
import '../../../../../features/auth_page/data/datasource/login_datasource/login_repository.dart';
import '../../../data/request/get_provider_total_rate_and_employee_and_balance_request/get_provider_total_rate_and_employee_and_balance_request.dart';
import '../../../../../features/dashboard_page/presentation/cubit/get_provider_total_rate_and_employee_and_balance_cubit/get_provider_total_rate_and_employee_and_balance_state.dart';

class GetProviderTotalRateAndEmployeeAndBalanceCubit
    extends Cubit<GetProviderTotalRateAndEmployeeAndBalanceState> {

  GetProviderTotalRateAndEmployeeAndBalanceCubit()
      : super(GetProviderTotalRateAndEmployeeAndBalanceInitial());

  static GetProviderTotalRateAndEmployeeAndBalanceCubit get(context) =>
      BlocProvider.of(context);

  Future<void> getProviderTotalRateAndEmployeeAndBalance() async {
    if (isClosed) return;

    emit(GetProviderTotalRateAndEmployeeAndBalanceLoading());

    final user = await AuthLocalStorage.getUser();

    if (isClosed) return;

    if (user == null) {
      emit(GetProviderTotalRateAndEmployeeAndBalanceError("User not found"));
      return;
    }

    final result =
    await getProviderTotalRateAndEmployeeAndBalanceFunction(
      request: GetProviderTotalRateAndEmployeeAndBalanceRequest(
        providerId: user.userid ?? 0,
      ),
    );

    if (isClosed) return;

    if (result != null) {
      emit(GetProviderTotalRateAndEmployeeAndBalanceSuccess(result));
    } else {
      emit(GetProviderTotalRateAndEmployeeAndBalanceError("Error loading data"));
    }
  }
}