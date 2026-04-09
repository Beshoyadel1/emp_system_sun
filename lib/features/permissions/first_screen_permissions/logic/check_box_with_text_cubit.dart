import 'package:flutter_bloc/flutter_bloc.dart';

class CheckBoxWithTextCubit extends Cubit<bool> {
  CheckBoxWithTextCubit() : super(false);

  void toggle(bool value) => emit(value);
}
