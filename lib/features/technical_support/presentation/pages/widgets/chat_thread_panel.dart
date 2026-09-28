import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/theming/colors.dart';
import '../../bloc/employee_chat_cubit/employee_chat_cubit.dart';
import '../../bloc/employee_chat_cubit/employee_chat_state.dart';
import 'chat_compose_bar.dart';
import 'chat_empty_view.dart';
import 'chat_messages_scroll_view.dart';
import 'chat_thread_header.dart';

class ChatThreadPanel extends StatelessWidget {
  final bool showBackButton;
  final VoidCallback? onBack;

  const ChatThreadPanel({
    super.key,
    this.showBackButton = false,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeChatCubit, EmployeeChatState>(
      builder: (context, state) {
        final cubit = context.read<EmployeeChatCubit>();
        final activeChat = state.selectedChat;

        if (activeChat == null) {
          return const Scaffold(
            backgroundColor: AppColors.whiteColor,
            body: ChatEmptyView(),
          );
        }

        return Container(
          color: AppColors.whiteColor,
          child: Column(
            children: [
              ChatThreadHeader(
                chat: activeChat,
                showBackButton: showBackButton,
                onBack: onBack,
              ),
              Expanded(
                child: ChatMessagesScrollView(
                  messages: activeChat.messages ?? [],
                  noOldMessages: activeChat.noOldMessages,
                  isLoadingOlder: state.isLoadingOlder,
                  onLoadOlder: () => cubit.getOlderMessages(),
                  currentUserId: cubit.currentUserId,
                  currentUserType: cubit.currentUserType,
                ),
              ),
              ChatComposeBar(
                isSending: state.isSendingMessage,
                onSend: (text) => cubit.sendMessage(text),
              ),
            ],
          ),
        );
      },
    );
  }
}
