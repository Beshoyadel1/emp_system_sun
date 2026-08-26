import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../../../../../features/cars_haraj_page/presentation/bloc/harag_cubit/harag_cubit.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../features/cars_haraj_page/data/model/get_all_harage_model/chat_harag_model.dart';
import '../../../../../../../features/cars_haraj_page/data/model/get_all_harage_model/harage_data.dart';

class WidgetDesignChatsHarag extends StatelessWidget {
  const WidgetDesignChatsHarag({
    super.key,
    required this.harage,
  });

  final HarageData harage;

  @override
  Widget build(BuildContext context) {
    final chats = harage.chats;

    return CustomContainer(
      isSelected: false,
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      typeWidget: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextInAppWidget(
              text: AppLanguageKeys.messages,
              textSize: 18,
              fontWeightIndex:
              FontSelectionData.mediumFontFamily,
              textColor: AppColors.darkColor,
            ),

            const SizedBox(height: 15),

            if (chats.isEmpty)
              const TextInAppWidget(
                text: AppLanguageKeys.empty,
                textSize: 14,
                fontWeightIndex:
                FontSelectionData.mediumFontFamily,
                textColor: AppColors.greyColor,
              )
            else
              ...chats.map(
                    (chat) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _buildChatItem(
                    context,
                    chat,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatItem(
      BuildContext context,
      ChatHaragModel chat,
      ) {
    final image =
        chat.fromUserImage ?? chat.toUserImage;

    final userName =
        chat.fromUserName ??
            chat.toUserName ??
            '---';

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        _showSendMessageDialog(
          context,
          chat,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.greyColor.withOpacity(.2),
          ),
        ),
        child: Row(
          children: [
            image != null
                ? CircleAvatar(
              radius: 22,
              backgroundImage: MemoryImage(image),
            )
                : const CircleAvatar(
              radius: 22,
              child: Icon(
                Icons.person_outline,
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  TextInAppWidget(
                    text: userName,
                    textSize: 14,
                    fontWeightIndex:
                    FontSelectionData.mediumFontFamily,
                    textColor: AppColors.darkColor,
                    maxLines: 1,
                  ),

                  const SizedBox(height: 5),

                  TextInAppWidget(
                    text: chat.lastMessage ?? '---',
                    textSize: 12,
                    fontWeightIndex:
                    FontSelectionData.regularFontFamily,
                    textColor: AppColors.greyColor,
                    maxLines: 1,
                  ),
                ],
              ),
            ),

            if ((chat.notViewedCount ?? 0) > 0)
              Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: TextInAppWidget(
                    text: '${chat.notViewedCount}',
                    textSize: 10,
                    fontWeightIndex:
                    FontSelectionData.mediumFontFamily,
                    textColor: AppColors.whiteColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  void _showSendMessageDialog(
      BuildContext context,
      ChatHaragModel chat,
      ) {
    final messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),

          // =====================================================
          // TITLE
          // =====================================================

          title: const TextInAppWidget(
            text: AppLanguageKeys.sendUsMessage,
            textSize: 20,
            fontWeightIndex: FontSelectionData.boldFontFamily,
            textColor: AppColors.darkColor,
            isTextCenter: true,
          ),

          // =====================================================
          // MESSAGE
          // =====================================================

          content: TextField(
            controller: messageController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: AppLanguageKeys.writeComment,
              hintStyle: const TextStyle(
                color: AppColors.greyColor,
              ),
              filled: true,
              fillColor: AppColors.greyColor.withOpacity(.08),
              contentPadding: const EdgeInsets.all(14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.orangeColor,
                ),
              ),
            ),
          ),

          // =====================================================
          // ACTIONS
          // =====================================================

          actions: [
            // CANCEL
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const TextInAppWidget(
                text: AppLanguageKeys.cancel,
                textSize: 14,
                textColor: AppColors.greyColor,
              ),
            ),

            // SEND
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.orangeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                final message =
                messageController.text.trim();

                if (message.isEmpty) {
                  return;
                }

                context.read<HaragCubit>().sendMessage(
                  toUser: chat.toUser ?? chat.fromUser ?? 0,
                  toUserType:
                  chat.toUserType ??
                      chat.fromUserType ??
                      0,
                  message: message,
                  harageId: chat.harageId ?? 0,
                );
                AppSnackBar.showSuccess(AppLanguageKeys.success);
                Navigator.pop(dialogContext);
              },
              child: const TextInAppWidget(
                text: AppLanguageKeys.send,
                textSize: 14,
                textColor: AppColors.whiteColor,
              ),
            ),
          ],
        );
      },
    );
  }
}