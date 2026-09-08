abstract class TabInsuranceNewOffersState {}

class TabInsuranceInitialState extends TabInsuranceNewOffersState {}

class PagesAboutLoadingState extends TabInsuranceNewOffersState {}

class PagesAboutLoadedState extends TabInsuranceNewOffersState {}

class PagesAboutErrorState extends TabInsuranceNewOffersState {
  PagesAboutErrorState(this.message);

  final String message;
}

class TabInsuranceChangedState extends TabInsuranceNewOffersState {
  final int index;

  TabInsuranceChangedState(this.index);
}
