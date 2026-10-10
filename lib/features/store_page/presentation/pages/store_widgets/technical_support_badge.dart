import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/setup_git_it.dart';
import '../../../../technical_support/presentation/bloc/employee_chat_cubit/employee_chat_cubit.dart';
import '../../../../technical_support/presentation/bloc/employee_chat_cubit/employee_chat_state.dart';

class TechnicalSupportBadge extends StatelessWidget {
  const TechnicalSupportBadge({super.key});
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<EmployeeChatCubit, EmployeeChatState>(
        bloc: getIt<EmployeeChatCubit>(),
        builder: (context, state) {
          final count = getIt<EmployeeChatCubit>().totalUnreadCount;
          if (count == 0) return const SizedBox.shrink();
          return Badge(label: Text(count > 99 ? '99+' : '$count'));
        },
      );
}
