import 'package:flutter/material.dart';
import 'widgets/chat_thread_panel.dart';

class MobileChatPage extends StatelessWidget {
  const MobileChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChatThreadPanel(
          showBackButton: true,
          onBack: () => Navigator.of(context).maybePop(),
        ),
      ),
    );
  }
}
