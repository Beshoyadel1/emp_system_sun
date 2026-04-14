import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/logic/order_funcations/order_functions.dart';
import '../../../../../../../features/technical_support/logic/chat_details_cubit/chat_details_cubit.dart';
import '../../../../../../../features/technical_support/logic/chat_details_cubit/chat_details_state.dart';
import '../../../../../../../features/technical_support/technical_support_emp/screens/chat/screens/message/text_direction_technical_support_admin_sun.dart';

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

            final chat = state.chats.isNotEmpty
                ? state.chats.first
                : null;

            final messages = chat?.messages ?? [];

            final myId = cubit.myUserId ?? 0;

            return ListView.separated(
              padding: const EdgeInsets.all(10.0),
              itemCount: messages.length,
              separatorBuilder: (_, __) =>
              const SizedBox(height: 8),
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
            child: Text("اختر محادثة"),
          );
        },
      ),
    );
  }
}