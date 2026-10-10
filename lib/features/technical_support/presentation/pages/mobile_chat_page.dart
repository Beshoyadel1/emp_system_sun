import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/employee_chat_cubit/employee_chat_cubit.dart';
import 'widgets/chat_thread_panel.dart';

class MobileChatPage extends StatefulWidget {
  const MobileChatPage({super.key});
  @override
  State<MobileChatPage> createState() => _MobileChatPageState();
}

class _MobileChatPageState extends State<MobileChatPage> {
  late final EmployeeChatCubit _chat;
  int? _userId, _userType;
  @override
  void initState() {
    super.initState();
    _chat = context.read<EmployeeChatCubit>();
    _userId = _chat.state.selectedChat?.touser;
    _userType = _chat.state.selectedChat?.tousertype;
  }

  @override
  void dispose() {
    if (_chat.state.selectedChat?.touser == _userId &&
        _chat.state.selectedChat?.tousertype == _userType) {
      _chat.clearSelectedChat();
    }
    super.dispose();
  }

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
