import 'package:flutter_bloc/flutter_bloc.dart';

class OptionDashboardCubit extends Cubit<String?> {
  OptionDashboardCubit() : super(null);

  void selectOption(String? value) => emit(value);
}
