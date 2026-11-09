import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/employee_chat_cubit/employee_chat_cubit.dart';
import '../bloc/employee_chat_cubit/employee_chat_state.dart';
import 'widgets/chat_thread_panel.dart';

class MobileChatPage extends StatefulWidget {
  const MobileChatPage({super.key});
  @override
  State<MobileChatPage> createState() => _MobileChatPageState();
}

class _MobileChatPageState extends State<MobileChatPage> {
  late final EmployeeChatCubit _chat;
  late final int _selectionVersion;
  @override
  void initState() {
    super.initState();
    _chat = context.read<EmployeeChatCubit>();
    _selectionVersion = _chat.selectionVersion;
  }

  @override
  void dispose() {
    if (_chat.selectionVersion == _selectionVersion) {
      _chat.clearSelectedChat();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EmployeeChatCubit, EmployeeChatState>(
      listenWhen: (previous, current) =>
          previous.selectedChat != null && current.selectedChat == null,
      listener: (context, state) {
        if (ModalRoute.of(context)?.isCurrent == true) {
          Navigator.of(context).maybePop();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: ChatThreadPanel(
            showBackButton: true,
            onBack: () => Navigator.of(context).maybePop(),
          ),
        ),
      ),
    );
  }
}
