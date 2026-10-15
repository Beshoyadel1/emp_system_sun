import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:emp_system_sun/core/services/auth_session.dart';
import 'package:emp_system_sun/core/language/language_cubit/language_cubit.dart';
import 'package:emp_system_sun/core/language/language.dart' as app_language;
import 'package:emp_system_sun/core/setup_git_it.dart';
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

  /// Toggle menu on Desktop
  void toggleMenu() {
    isMenuOpen = !isMenuOpen;
    emit(HideMenuState());
  }

  /// Force show menu
  void showMenu() {
    if (isMenuOpen) return;

    isMenuOpen = true;
    emit(HideMenuState());
  }

  /// Force hide menu
  void hideMenu() {
    if (!isMenuOpen) return;

    isMenuOpen = false;
    emit(HideMenuState());
  }

  void dropDown() {
    emit(DropDownState());
  }

  int selectedPageIndex = 1;
  int selectedPageFromOpenedPagesIndex = -1;

  void changeSelectedPageIndex() {
    emit(ChangeSelectedPageIndexState());
  }

  List<String> data = [];

  bool get isAllAppLanguageArabic => getIt<LanguageCubit>().isAllAppLanguageArabic;

  Locale get selectedLanguage => getIt<LanguageCubit>().selectedLanguage;

  Future<void> changeAllAppLanguage(int language) async {
    await getIt<LanguageCubit>().changeAllAppLanguage(language);
    languageDropDownValue = languageItemsDropDown.firstWhere(
      (element) => element.number == (isAllAppLanguageArabic ? 1 : 2),
    );
    emit(ChangeAllAppLanguageState());
  }

  List<Locale> get supportedLocales => app_language.supportedLocales;

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
  Future<void> _pageWrites = Future.value();

  Future<void> savePageData(String key, List<String> values, int version) {
    final next = _pageWrites.then((_) async {
      if (!AuthSession.isCurrent(version)) return;
      final prefs = await SharedPreferences.getInstance();
      if (!AuthSession.isCurrent(version)) return;
      await prefs.setStringList(key, values);
    });
    _pageWrites =
        next.then<void>((_) {}, onError: (Object _, StackTrace __) {});
    return next;
  }

  Future<void> resetSession() async {
    openedPages.clear();
    data.clear();
    selectedPageIndex = 1;
    selectedPageFromOpenedPagesIndex = -1;
    isMenuOpen = true;
    if (!isClosed) emit(ChangeOpenedPagesState());
    // Wait for old page saves, then remove their numeric keys. Language and
    // other general preferences are deliberately preserved.
    await _pageWrites;
    final prefs = await SharedPreferences.getInstance();
    for (final key in prefs.getKeys()) {
      if (RegExp(r'^\d+-?\d*$').hasMatch(key) && prefs.get(key) is List) {
        await prefs.remove(key);
      }
    }
  }

  void navigateToPage(int pageNumber) {
    selectedPageIndex = pageNumber;
    selectedPageFromOpenedPagesIndex = -1;
    changeSelectedPageIndex();
  }

  void changeOpenedPages() {
    emit(ChangeOpenedPagesState());
  }
}
