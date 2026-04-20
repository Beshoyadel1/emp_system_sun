import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/api_functions/statistics/get_provider_service_statistics_model/get_provider_service_statistics_repository.dart';
import '../../../../core/api_functions/statistics/get_provider_service_statistics_model/get_provider_service_statistics_request.dart';
import '../../../../core/api_functions/user/login_model/login_repository.dart';
import '../../../../features/dashboard_page/logic/get_provider_service_statistics_cubit/get_provider_service_statistics_state.dart';

class GetProviderServiceStatisticsCubit
    extends Cubit<GetProviderServiceStatisticsState> {

  GetProviderServiceStatisticsCubit()
      : super(GetProviderServiceStatisticsInitial());

  static GetProviderServiceStatisticsCubit get(context) =>
      BlocProvider.of(context);

  Future<void> getProviderServiceStatistics() async {
    emit(GetProviderServiceStatisticsLoading());

    final user = await AuthLocalStorage.getUser();

    if (user == null) {
      emit(GetProviderServiceStatisticsError("User not found"));
      return;
    }
    final result = await getProviderServiceStatisticsFunction(
      request: GetProviderServiceStatisticsRequest(
        providerId: user.userid,
      ),
    );

    if (result != null) {
      emit(GetProviderServiceStatisticsSuccess(result));
    } else {
      emit(GetProviderServiceStatisticsError("Error loading data"));
    }
  }
}