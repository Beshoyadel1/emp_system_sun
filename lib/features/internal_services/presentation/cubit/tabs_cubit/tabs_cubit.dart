import 'package:flutter_bloc/flutter_bloc.dart';

class TabsCubit extends Cubit<int> {
  TabsCubit() : super(0); // initial tab index = 0

  void changeTab(int index) {
    emit(index);
  }
}