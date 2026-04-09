import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../features/technical_support/technical_support_emp/screens/chat/screens/message/text_direction_technical_support_admin_sun.dart';

class ChatListDesignInTechnicalSupportAdminSun extends StatelessWidget {
  const ChatListDesignInTechnicalSupportAdminSun({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(10.0),
        itemCount: messages.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final message = messages[index];

          return TextDirectionTechnicalSupportAdminSun(
            textMessage: message.text,
            isSender: message.isSender,
            isSeen: message.isSeen,
          );
        },
      ),
    );
  }
}

const List<MessageModel> messages = [
  MessageModel(text: 'هلا والله ,وينك', isSender: true, isSeen: true),
  MessageModel(text: 'جاي في الطريق'),
  MessageModel(text: 'منتظرك', isSender: true, isSeen: true),
  MessageModel(text: 'دقيقتين فقط'),
  MessageModel(text: 'حياك الله', isSender: true),
  MessageModel(text: 'جاي في الطريق'),
  MessageModel(text: 'منتظرك', isSender: true, isSeen: true),
  MessageModel(text: 'دقيقتين فقط'),
  MessageModel(text: 'حياك الله', isSender: true),
];
class MessageModel {
  final String text;
  final bool isSender;
  final bool isSeen;

  const MessageModel({
    required this.text,
    this.isSender = false,
    this.isSeen = false,
  });
}