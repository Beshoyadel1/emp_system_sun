import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/store_page/store_widgets/facility_account/facility_account_check.dart';
import '../../../../features/auth_page/auth_cubit/auth_cubit.dart';
import '../../../../features/auth_page/auth_cubit/auth_state.dart';
import '../../../../features/auth_page/login_page/login_page.dart';
import '../../../../features/store_page/store_page.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {

        print("AUTH STATE => $state");

        if (state is AuthInitial) {
          context.read<AuthCubit>().init();
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AuthLoading || state is AuthLoginLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        /// 🔥 1. الأول check incomplete
        if (state is AuthIncompleteProfile) {
          return const FacilityAccountCheck();
        }

        /// 🔥 2. بعد كده authenticated فقط
        if (state is AuthAuthenticated) {
          return const StorePage();
        }

        /// 🔥 3. تجاهل update states (مهم جداً)
        if (state is AuthUpdateLoading || state is AuthUpdateSuccess) {
          return const FacilityAccountCheck(); // 👈 خليك في نفس الصفحة
        }

        return const LoginPage();
      },
    );
  }
}