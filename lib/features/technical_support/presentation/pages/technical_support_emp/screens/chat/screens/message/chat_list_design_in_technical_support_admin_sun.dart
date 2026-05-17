import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emp_system_sun/core/language/language_constant.dart';
import 'package:emp_system_sun/core/theming/text_styles.dart';
import 'package:emp_system_sun/features/internal_services/presentation/cubit/order_funcations/order_functions.dart';
import 'package:emp_system_sun/features/technical_support/presentation/bloc/chat_details_cubit/chat_details_cubit.dart';
import 'package:emp_system_sun/features/technical_support/presentation/bloc/chat_details_cubit/chat_details_state.dart';
import 'package:emp_system_sun/features/technical_support/presentation/pages/technical_support_emp/screens/chat/screens/message/text_direction_technical_support_admin_sun.dart';

class ChatListDesignInTechnicalSupportAdminSun extends StatelessWidget {
  const ChatListDesignInTechnicalSupportAdminSun({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ChatDetailsCubit, ChatDetailsState>(
        builder: (context, state) {
          if (state is ChatDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ChatDetailsError) {
            return Center(child: Text(state.message));
          }

          if (state is ChatDetailsSuccess) {
            final cubit = context.read<ChatDetailsCubit>();

            final chat = state.chats.isNotEmpty ? state.chats.first : null;

            final messages = chat?.messages ?? [];

            final myId = cubit.myUserId ?? 0;

            return ListView.separated(
              padding: const EdgeInsets.all(10.0),
              itemCount: messages.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isSender = msg.fromUser == myId;
                return TextDirectionTechnicalSupportAdminSun(
                  textMessage: msg.message,
                  isSender: isSender,
                  //isSeen: msg.viewed,
                  timeMessage: OrderFunctions.formatTime(msg.date),
                );
              },
            );
          }

          return const Center(
            child: TextInAppWidget(
              text: AppLanguageKeys.selectConversation,
              textSize: 14,
            ),
          );
        },
      ),
    );
  }
}
