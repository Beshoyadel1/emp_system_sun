import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../features/dashboard_page/data/datasource/get_provider_service_statistics_data_source/get_provider_service_statistics_repository.dart';
import '../../../data/request/get_provider_service_statistics_request/get_provider_service_statistics_request.dart';
import '../../../../../features/auth_page/data/datasource/login_datasource/login_repository.dart';
import '../../../../../features/dashboard_page/presentation/cubit/get_provider_service_statistics_cubit/get_provider_service_statistics_state.dart';

class GetProviderServiceStatisticsCubit
    extends Cubit<GetProviderServiceStatisticsState> {

  GetProviderServiceStatisticsCubit()
      : super(GetProviderServiceStatisticsInitial());

  static GetProviderServiceStatisticsCubit get(context) =>
      BlocProvider.of(context);

  Future<void> getProviderServiceStatistics() async {
    if (isClosed) return;

    emit(GetProviderServiceStatisticsLoading());

    final user = await AuthLocalStorage.getUser();

    if (isClosed) return;

    if (user == null) {
      emit(GetProviderServiceStatisticsError("User not found"));
      return;
    }

    final result = await getProviderServiceStatisticsFunction(
      request: GetProviderServiceStatisticsRequest(
        providerId: user.userid,
      ),
    );

    if (isClosed) return;

    if (result != null) {
      emit(GetProviderServiceStatisticsSuccess(result));
    } else {
      emit(GetProviderServiceStatisticsError("Error loading data"));
    }
  }
}