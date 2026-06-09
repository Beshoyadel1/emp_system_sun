import 'package:emp_system_sun/features/auth_page/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:emp_system_sun/features/auth_page/presentation/bloc/auth_cubit/auth_state.dart';
import 'package:emp_system_sun/features/auth_page/presentation/pages/login_page/login_page.dart';
import 'package:emp_system_sun/features/store_page/presentation/pages/store_widgets/facility_account/facility_account_check.dart';
import 'package:flutter/cupertino.dart';
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
      builder: (context, state) {

        print("AUTH STATE => $state");

        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is AuthIncompleteProfile ||
            state is AuthUpdateLoading ||
            state is AuthUpdateSuccess ||
            state is AuthUpdateError) {
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