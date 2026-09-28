import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/theming/colors.dart';
import '../../bloc/employee_chat_cubit/employee_chat_cubit.dart';
import '../../bloc/employee_chat_cubit/employee_chat_state.dart';
import '../../../data/model/employee_chat_model.dart';
import 'chat_conversation_tile.dart';
import 'chat_search_field.dart';

class ChatConversationsPanel extends StatefulWidget {
  final ValueChanged<GetAllMessagesModel>? onSelectChat;

  const ChatConversationsPanel({super.key, this.onSelectChat});

  @override
  State<ChatConversationsPanel> createState() => _ChatConversationsPanelState();
}

class _ChatConversationsPanelState extends State<ChatConversationsPanel> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    return BlocBuilder<EmployeeChatCubit, EmployeeChatState>(
      builder: (context, state) {
        final cubit = context.read<EmployeeChatCubit>();
        final conversations = state.searchQuery.isNotEmpty
            ? state.filteredMessages
            : state.allMessages;

        return Container(
          decoration: const BoxDecoration(
            color: AppColors.whiteColor,
            border: BorderDirectional(
              end: BorderSide(color: AppColors.cardStroke),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          isAr ? 'المحادثات' : 'Messages',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.appBlackColor,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.refresh,
                              color: AppColors.appGrey, size: 20),
                          tooltip: isAr ? 'إعادة التحميل' : 'Reload',
                          onPressed: () => cubit.getAllMessages(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ChatSearchField(
                      controller: _searchController,
                      onChanged: (val) => cubit.searchMessages(val),
                      onClear: () {
                        _searchController.clear();
                        cubit.searchMessages('');
                      },
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: AppColors.cardStroke),
              Expanded(
                child: state.isLoadingMessages && state.allMessages.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.mainColor,
                        ),
                      )
                    : conversations.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.chat_bubble_outline,
                                    size: 48,
                                    color: AppColors.lightGreyColor,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    isAr
                                        ? 'لا توجد محادثات نشطة'
                                        : 'No active conversations',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.all(12),
                            itemCount: conversations.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final chat = conversations[index];
                              final isSelected =
                                  state.selectedChat?.touser == chat.touser &&
                                      state.selectedChat?.tousertype ==
                                          chat.tousertype;

                              return ChatConversationTile(
                                chat: chat,
                                isSelected: isSelected,
                                currentUserId: cubit.currentUserId,
                                currentUserType: cubit.currentUserType,
                                onTap: () {
                                  cubit.selectChat(chat);
                                  widget.onSelectChat?.call(chat);
                                },
                              );
                            },
                          ),
              ),
            ],
          ),
        );
      },
    );
  }
}
