import 'package:flutter_bloc/flutter_bloc.dart';

class SelectOrderNotificationCubit extends Cubit<int> {
  SelectOrderNotificationCubit() : super(0);

  void select(int index) => emit(index);
}
