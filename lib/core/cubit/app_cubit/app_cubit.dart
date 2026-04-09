import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/general_models/general_model.dart';
import '../../../../core/general_models/pages_model.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isLogin = true;

  void changeSecure() {
    emit(ChangeSecureState());
  }

  bool isRememberMe = false;

  void changeRememberMe() {
    emit(ChangeRememberMeState());
  }

  bool isMenuOpen = true;

  void hideMenu() {
    emit(HideMenuState());
  }

  int selectedPageIndex = 1;
  int selectedPageFromOpenedPagesIndex = -1;

  void changeSelectedPageIndex() {
    emit(ChangeSelectedPageIndexState());
  }

  List<String> data = [];

  bool isAllAppLanguageArabic = true;

  Locale? selectedLanguage;

  Future<void> changeAllAppLanguage(int language) async {
    if (language == 1) {
      isAllAppLanguageArabic = true;
      selectedLanguage = supportedLocales[0];
    } else {
      isAllAppLanguageArabic = false;
      selectedLanguage = supportedLocales[1];
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('language', language);
    emit(ChangeAllAppLanguageState());
  }

  List<Locale> supportedLocales = [
    const Locale('ar', 'EG'),
    const Locale('en', 'US'),
  ];

  List<String> languageItems = ['English', 'عربي'];

  GeneralModel? languageDropDownValue;
  List<GeneralModel> languageItemsDropDown = [
    GeneralModel(arName: 'عربي', enName: 'عربي', number: 1),
    GeneralModel(arName: 'English', enName: 'English', number: 2)
  ];

  Future<void> getLanguageFromSharedPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? languageFromSharedPreference = prefs.getInt('language');
    if (languageFromSharedPreference != null) {
      languageDropDownValue = languageItemsDropDown
          .where((element) => element.number == languageFromSharedPreference)
          .first;
      changeAllAppLanguage(languageFromSharedPreference);
    } else {
      languageDropDownValue =
          languageItemsDropDown.where((element) => element.number == 1).first;
      changeAllAppLanguage(languageDropDownValue!.number!);
    }
  }

  List<PageNodeWithIDModel> openedPages = [];

  void navigateToPage(int pageNumber) {
    selectedPageIndex = pageNumber;
    selectedPageFromOpenedPagesIndex = -1;
    changeSelectedPageIndex();
  }
  void changeOpenedPages() {
    emit(ChangeOpenedPagesState());
  }
}
