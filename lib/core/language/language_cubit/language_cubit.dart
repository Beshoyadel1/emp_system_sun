import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/dio_function/dio_controller.dart';
import '../language.dart' as app_language;
import '../language_model.dart';
import 'language_states.dart';

class LanguageCubit extends Cubit<LanguageStates> {
  LanguageCubit() : super(InitialState());

  static LanguageCubit get(context) => BlocProvider.of(context);

  bool isAllAppLanguageArabic = true;

  Locale selectedLanguage = app_language.supportedLocales.first;

  Future<void> changeAllAppLanguage(int language) async {
    if (language == 1) {
      isAllAppLanguageArabic = true;
      selectedLanguage = supportedLocales[0];
    } else {
      isAllAppLanguageArabic = false;
      selectedLanguage = supportedLocales[1];
    }

    Network.setLanguageCode(selectedLanguage.languageCode);
    languageDropDownValue = languageItemsDropDown.firstWhere(
      (element) => element.number == language,
    );
    emit(ChangeAllAppLanguageState());

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('language', language);
  }

  List<Locale> get supportedLocales => app_language.supportedLocales;

  List<String> languageItems = ['English', 'عربي'];

  LanguageModel? languageDropDownValue;
  List<LanguageModel> languageItemsDropDown = [
    LanguageModel(arName: 'عربي', enName: 'عربي', number: 1),
    LanguageModel(arName: 'English', enName: 'English', number: 2)
  ];

  Future<void> getLanguageFromSharedPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final language = prefs.getInt('language') == 2 ? 2 : 1;
    await changeAllAppLanguage(language);
  }
}
