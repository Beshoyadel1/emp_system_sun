import 'dart:ui';
import 'package:emp_system_sun/core/audio_service/audio_service.dart';
import 'package:emp_system_sun/features/auth_page/presentation/auth_gate.dart';
import 'package:emp_system_sun/features/auth_page/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:emp_system_sun/features/notifications/presentation/bloc/notification_cubit/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../../core/cubit/app_cubit/app_cubit.dart';
import '../../../core/language/language_cubit/language_cubit.dart';
import '../../../core/language/language_cubit/language_states.dart';
import '../../../core/theming/colors.dart';
import '../../../core/language/language.dart';
import '../../../core/setup_git_it.dart';

final GlobalKey<ScaffoldState> scaffoldKeyDrawer = GlobalKey<ScaffoldState>();
final GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  setupGetIt();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NotificationCubit()..getUserNotification(),
        ),
        BlocProvider<LanguageCubit>(
          create: (_) =>
          getIt<LanguageCubit>()..getLanguageFromSharedPreference(),
        ),
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit()..init(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void reassemble() {
    super.reassemble();

    AudioService.instance.stopNotificationSound();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    print("📱 Screen width = $width");

    return BlocProvider(
      create: (BuildContext context) => getIt<AppCubit>(),
      child: BlocBuilder<LanguageCubit, LanguageStates>(
        buildWhen: (previous, current) =>
        current is ChangeAllAppLanguageState,
        builder: (BuildContext context, state) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            scaffoldMessengerKey: scaffoldKey,
            supportedLocales: supportedLocales,
            locale: LanguageCubit.get(context).selectedLanguage,
            localizationsDelegates: const [
              AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            title: 'San Admin System',
            debugShowCheckedModeBanner: false,
            home: const AuthGate(),
          );
        },
      ),
    );
  }
}