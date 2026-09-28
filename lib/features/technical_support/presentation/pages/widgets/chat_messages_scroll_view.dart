import 'package:flutter/material.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../data/model/employee_chat_model.dart';
import 'chat_bubble.dart';
import 'chat_date_chip.dart';

class ChatMessagesScrollView extends StatefulWidget {
  final List<ChatMessageModel> messages;
  final bool noOldMessages;
  final bool isLoadingOlder;
  final VoidCallback onLoadOlder;
  final int currentUserId;
  final int currentUserType;

  const ChatMessagesScrollView({
    super.key,
    required this.messages,
    required this.noOldMessages,
    required this.isLoadingOlder,
    required this.onLoadOlder,
    required this.currentUserId,
    required this.currentUserType,
  });

  @override
  State<ChatMessagesScrollView> createState() => _ChatMessagesScrollViewState();
}

class _ChatMessagesScrollViewState extends State<ChatMessagesScrollView> {
  late final ScrollController _scrollController;
  int _lastMessageCount = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _lastMessageCount = widget.messages.length;
    _scrollToBottomPostFrame();
  }

  @override
  void didUpdateWidget(covariant ChatMessagesScrollView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.messages.length > _lastMessageCount) {
      _lastMessageCount = widget.messages.length;
      _scrollToBottomPostFrame();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottomPostFrame() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  List<dynamic> _buildGroupedItems() {
    final grouped = <dynamic>[];
    DateTime? lastDate;

    for (final msg in widget.messages) {
      final msgDate = msg.date;
      if (msgDate != null) {
        if (lastDate == null ||
            msgDate.year != lastDate.year ||
            msgDate.month != lastDate.month ||
            msgDate.day != lastDate.day) {
          grouped.add(msgDate);
          lastDate = msgDate;
        }
      }
      grouped.add(msg);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    if (widget.messages.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            isAr
                ? 'لا توجد رسائل سابقة في هذه المحادثة'
                : 'No messages in this chat yet',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    final items = _buildGroupedItems();

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: items.length + (widget.noOldMessages ? 0 : 1),
      itemBuilder: (context, index) {
        if (!widget.noOldMessages && index == 0) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: widget.isLoadingOlder
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.mainColor,
                      ),
                    )
                  : TextButton.icon(
                      icon: const Icon(Icons.history,
                          size: 16, color: AppColors.mainColor),
                      label: Text(
                        isAr ? 'تحميل الرسائل السابقة' : 'Load older messages',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: widget.onLoadOlder,
                    ),
            ),
          );
        }

        final itemIndex = widget.noOldMessages ? index : index - 1;
        final item = items[itemIndex];

        if (item is DateTime) {
          return ChatDateChip(date: item);
        } else if (item is ChatMessageModel) {
          final isMe = item.isOutgoing(
            widget.currentUserId,
            widget.currentUserType,
          );
          return ChatBubble(message: item, isMe: isMe);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
