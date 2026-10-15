import 'package:emp_system_sun/features/auth_page/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:emp_system_sun/features/auth_page/presentation/bloc/auth_cubit/auth_state.dart';
import 'package:emp_system_sun/features/auth_page/presentation/pages/login_page/login_page.dart';
import 'package:emp_system_sun/features/store_page/presentation/pages/store_widgets/facility_account/facility_account_check.dart';
import 'package:emp_system_sun/core/language/language.dart';
import 'package:emp_system_sun/core/language/language_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../store_page/presentation/pages/store_page.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      // Profile updates report progress to the form without changing the page.
      buildWhen: (previous, current) =>
          current is AuthLoading ||
          current is AuthLogoutError ||
          current is AuthIncompleteProfile ||
          current is AuthAuthenticated ||
          current is AuthUnauthenticated,
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is AuthLogoutError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(AppLocalizations.of(context)
                      .translate(AppLanguageKeys.logoutFailed)),
                  TextButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: Text(AppLocalizations.of(context)
                        .translate(AppLanguageKeys.retry)),
                    onPressed: () => context.read<AuthCubit>().logout(context),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is AuthIncompleteProfile) {
          return const FacilityAccountCheck();
        }

        if (state is AuthAuthenticated) {
          return const StorePage();
        }

        return const LoginPage();
      },
    );
  }
}
