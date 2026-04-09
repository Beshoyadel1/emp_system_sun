import 'package:emp_system_sun/features/internal_services/logic/Details_container_setting_cubit/Details_container_setting_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DetailsContainerSettingCubit extends Cubit<DetailsContainerSettingState> {
  DetailsContainerSettingCubit() : super(DetailsContainerSettingState());

  void toggle() => emit(state.copyWith(isExpanded: !state.isExpanded));

  void selectOption(int value) =>
      emit(state.copyWith(selectedOption: value));
}
