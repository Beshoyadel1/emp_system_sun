import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../language_model.dart';
import 'language_states.dart';

class LanguageCubit extends Cubit<LanguageStates> {
  LanguageCubit() : super(InitialState());

  static LanguageCubit get(context) => BlocProvider.of(context);

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

  LanguageModel? languageDropDownValue;
  List<LanguageModel> languageItemsDropDown = [
    LanguageModel(arName: 'عربي', enName: 'عربي', number: 1),
    LanguageModel(arName: 'English', enName: 'English', number: 2)
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
}
