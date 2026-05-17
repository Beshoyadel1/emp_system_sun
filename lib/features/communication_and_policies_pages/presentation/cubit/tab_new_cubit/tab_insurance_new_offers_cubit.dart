import 'package:flutter_bloc/flutter_bloc.dart';
import 'tab_insurance_new_offers_state.dart';

class TabInsuranceNewOffersCubit extends Cubit<TabInsuranceNewOffersState> {
  TabInsuranceNewOffersCubit() : super(TabInsuranceInitialState());

  static TabInsuranceNewOffersCubit get(context) =>
      BlocProvider.of<TabInsuranceNewOffersCubit>(context);

  int currentIndex = 0;

  void changeTab(int index) {
    currentIndex = index;
    emit(TabInsuranceChangedState(index));
  }
}
