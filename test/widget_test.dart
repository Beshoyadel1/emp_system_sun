import 'package:emp_system_sun/core/language/language_cubit/language_cubit.dart';
import 'package:emp_system_sun/core/setup_git_it.dart';
import 'package:emp_system_sun/features/auth_page/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:emp_system_sun/features/auth_page/presentation/pages/login_page/login_widgets/login_language_button_widget.dart';
import 'package:emp_system_sun/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('app renders the auth screen with its required providers',
      (tester) async {
    SharedPreferences.setMockInitialValues({'language': 1});
    await getIt.reset();
    setupGetIt();

    final languageCubit = getIt<LanguageCubit>();
    await languageCubit.getLanguageFromSharedPreference();
    final authCubit = AuthCubit();

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<LanguageCubit>.value(value: languageCubit),
          BlocProvider<AuthCubit>.value(value: authCubit),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pump();

    expect(find.byType(LoginLanguageButtonWidget), findsOneWidget);

    await authCubit.close();
  });
}
