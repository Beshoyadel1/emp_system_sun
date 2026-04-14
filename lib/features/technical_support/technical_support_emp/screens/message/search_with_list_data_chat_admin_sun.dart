import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../features/technical_support/logic/chat_details_cubit/chat_details_cubit.dart';
import '../../../../../features/internal_services/internal_orders/first_screen_internal_orders/logic/order_funcations/order_functions.dart';
import '../../../../../features/technical_support/custom_widget/row_message_support_widget.dart';
import '../../../../../features/technical_support/logic/message_cubit/message_cubit.dart';
import '../../../../../features/technical_support/logic/message_cubit/message_state.dart';


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

          if (messages.isEmpty) {
            return const SizedBox(
              height: 300,
              child: Center(child: Text("No messages")),
            );
          }

          return SizedBox(
            height: 400,
            child: Column(
              children: [
                // TextFormFieldWidget(
                //   textFormController: textFormController,
                //   fillColor: AppColors.greyColorSearch,
                //   hintText: AppLanguageKeys.searchInMessages,
                //   hintTextSize: 11,
                //   hintTextColor: AppColors.darkColor.withOpacity(0.4),
                //   textSize: 12,
                //   contentPadding: const EdgeInsets.all(5),
                //   focusedBorderRadius: BorderRadius.circular(5),
                //   enabledBorderRadius: BorderRadius.circular(5),
                // ),
                // const SizedBox(height: 20),

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