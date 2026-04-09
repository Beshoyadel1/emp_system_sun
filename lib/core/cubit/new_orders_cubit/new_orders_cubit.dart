import 'package:emp_system_sun/features/internal_services/internal_services_statistics/Internal_services_page/model/new_order_steps_model/new_order_steps_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'new_orders_state.dart';

class NewOrdersCubit extends Cubit<NewOrdersState> {
  NewOrdersCubit() : super(NewOrdersInitial());

  void showOrdersList() {
    emit(NewOrdersInitial());
  }

  void showOrderDetails() {
    emit(NewOrderDetails());
  }

  int selectedIndex = 0;
  int currentPage = 1;
  int? currentFilterId;

  Future<void> getOrders({
    required int page,
    int? filterId,
  }) async {
    currentPage = page;
    currentFilterId = filterId;

    emit(NewOrdersLoading());

    try {
      await Future.delayed(const Duration(seconds: 1));

      List<String> orders = List.generate(
          5, (index) => "Order ${index + 1} - Page $page");

      emit(NewOrdersLoaded(orders));
    } catch (e) {
      emit(NewOrdersError("Failed to load orders"));
    }
  }
  int selectedFilterIndex = 0;
  void changeTab(int index) {
    selectedIndex = index;
    emit(ChangeIndexState()); // مهم جدا
  }
  void selectTab(int index) {
    for (int i = 0; i < steps.length; i++) {
      steps[i] = NewOrderStepsModel(
        title: steps[i].title,
        content: steps[i].content,
        isActive: i <= index,
        date: steps[i].date,
      );
    }

    selectedIndex = index;
    emit(ChangeIndexState());
  }
}
