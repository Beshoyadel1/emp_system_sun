abstract class TabInsuranceNewOffersState {}

class TabInsuranceInitialState extends TabInsuranceNewOffersState {}

class TabInsuranceChangedState extends TabInsuranceNewOffersState {
  final int index;

  TabInsuranceChangedState(this.index);
}
