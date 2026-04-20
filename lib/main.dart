import 'dart:ui';
import 'package:emp_system_sun/features/auth_page/auth_cubit/auth_cubit.dart';
import 'package:emp_system_sun/features/auth_page/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../../features/auth_page/login_page/login_page.dart';
import '../../../core/cubit/app_cubit/app_cubit.dart';
import '../../../core/language/language_cubit/language_cubit.dart';
import '../../../core/language/language_cubit/language_states.dart';
import '../../../core/theming/colors.dart';
import '../../../core/language/language.dart';
import '../../../core/setup_git_it.dart';

final GlobalKey<ScaffoldState> scaffoldKeyDrawer = GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  setupGetIt();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>(
          create: (_) =>
          getIt<LanguageCubit>()..getLanguageFromSharedPreference(),
        ),

        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit()..checkAuth(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final width = MediaQuery.of(context).size.width;
    //   print("📱 Screen width = $width");
    // });
    return BlocProvider(
      create: (BuildContext context) => getIt<AppCubit>(),
      child: BlocBuilder<LanguageCubit, LanguageStates>(
        buildWhen: (previous, current) {
          return current is ChangeAllAppLanguageState;
        },
        builder: (BuildContext context, state) {
          return MaterialApp(
            scaffoldMessengerKey: scaffoldKey,
            supportedLocales: supportedLocales,
            locale: LanguageCubit.get(context).selectedLanguage,
            localizationsDelegates: const [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
                PointerDeviceKind.stylus,
                PointerDeviceKind.unknown
              },
            ),
            title: 'SUN SYSTEM',
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.lightWhiteColor,
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            home: const AuthGate(),
          );
        },
      ),
    );
  }
}