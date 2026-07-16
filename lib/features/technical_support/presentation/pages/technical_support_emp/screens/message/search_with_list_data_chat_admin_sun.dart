import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../../features/internal_services/presentation/pages/internal_orders/custom_widget/text_empty_view_data.dart';
import '../../../../../../../../../features/internal_services/presentation/cubit/order_funcations/order_functions.dart';
import '../../../../../../../../../features/technical_support/presentation/bloc/chat_details_cubit/chat_details_cubit.dart';
import '../../../../../../../../../features/technical_support/presentation/bloc/message_cubit/message_cubit.dart';
import '../../../../../../../../../features/technical_support/presentation/bloc/message_cubit/message_state.dart';
import '../../../../../../../../../features/technical_support/presentation/custom_widget/row_message_support_widget.dart';


class SearchWithListDataChatAdminSun extends StatefulWidget {
  const SearchWithListDataChatAdminSun({super.key});

  @override
  State<SearchWithListDataChatAdminSun> createState() =>
      _SearchWithListDataChatAdminSunState();
}

class _SearchWithListDataChatAdminSunState
    extends State<SearchWithListDataChatAdminSun> {

  final TextEditingController textFormController = TextEditingController();

  @override
  void dispose() {
    textFormController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageCubit, MessageState>(
      builder: (context, state) {

        if (state is MessageLoading) {
          return const SizedBox(
            height: 300,
            child: Center(child: CupertinoActivityIndicator()),
          );
        }

        if (state is MessageError) {
          return SizedBox(
            height: 300,
            child: Center(child: Text(state.message)),
          );
        }

        if (state is MessageSuccess) {

          final messages = state.messages;

          if (state.messages.isEmpty) {
            return const TextEmptyViewData();
          }

          return SizedBox(
            height: 400,
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: messages.length,
                    separatorBuilder: (_, __) =>
                    const SizedBox(height: 10),
                    itemBuilder: (context, index) {

                      final msg = messages[index];

                      return RowMessageSupportWidget(
                        imageBytes: msg.userImage,
                        userName: msg.userName,
                        message: msg.lastMessage?.message ?? "",
                        time: OrderFunctions.formatTime(msg.lastMessage?.date),
                        onTap: (){
                          context.read<ChatDetailsCubit>().loadChat(
                            toUserId: msg.userId ?? 0,
                            toUserType: msg.userType ?? 0,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}