import 'package:emp_system_sun/features/communication_and_policies_pages/data/datasource/get_all_pages_about_repository.dart';
import 'package:emp_system_sun/features/communication_and_policies_pages/data/model/about_page_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'tab_insurance_new_offers_state.dart';

typedef PagesAboutLoader = Future<List<AboutPageModel>> Function();

class TabInsuranceNewOffersCubit extends Cubit<TabInsuranceNewOffersState> {
  TabInsuranceNewOffersCubit({PagesAboutLoader? loader})
      : _loader = loader ?? getAllPagesAboutFunction,
        super(TabInsuranceInitialState());

  final PagesAboutLoader _loader;

  static TabInsuranceNewOffersCubit get(context) =>
      BlocProvider.of<TabInsuranceNewOffersCubit>(context);

  int currentIndex = 0;
  List<AboutPageModel> pages = const [];

  Future<void> loadPages() async {
    if (state is PagesAboutLoadingState) return;

    emit(PagesAboutLoadingState());

    try {
      pages = await _loader();
      if (isClosed) return;

      if (currentIndex >= pages.length) {
        currentIndex = 0;
      }

      emit(PagesAboutLoadedState());
    } catch (error) {
      if (isClosed) return;

      final message = error.toString().replaceFirst('Exception: ', '');
      emit(PagesAboutErrorState(message));
    }
  }

  void changeTab(int index) {
    if (index < 0 || index >= pages.length || index == currentIndex) return;

    currentIndex = index;
    emit(TabInsuranceChangedState(index));
  }
}
