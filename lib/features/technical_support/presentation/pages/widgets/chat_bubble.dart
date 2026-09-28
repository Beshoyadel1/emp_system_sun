import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../data/model/employee_chat_model.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessageModel message;
  final bool isMe;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  String _formatTime(DateTime? date) {
    if (date == null) return '';
    return DateFormat('HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isMe ? AppColors.mainColor : AppColors.scaffoldBackground,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: Radius.circular(isMe ? 16 : 4),
              bottomRight: Radius.circular(isMe ? 4 : 16),
            ),
            border: isMe ? null : Border.all(color: AppColors.cardStroke),
            boxShadow: [
              BoxShadow(
                color: AppColors.appBlackColor.withValues(alpha: 0.04),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isMe &&
                  message.fromUserName != null &&
                  message.fromUserName!.isNotEmpty) ...[
                Text(
                  message.fromUserName!,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainColor,
                  ),
                ),
                const SizedBox(height: 4),
              ],
              Text(
                message.message,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: isMe ? AppColors.whiteColor : AppColors.appBlackColor,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _formatTime(message.date),
                    style: TextStyle(
                      fontSize: 10,
                      color: isMe
                          ? AppColors.whiteColor.withValues(alpha: 0.75)
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
