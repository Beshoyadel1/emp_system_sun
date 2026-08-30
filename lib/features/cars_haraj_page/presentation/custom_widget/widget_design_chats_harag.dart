import 'package:emp_system_sun/features/cars_haraj_page/data/model/get_harage_chat_model/get_harage_chat_model.dart';
import 'package:emp_system_sun/features/cars_haraj_page/presentation/bloc/harag_cubit/harag_state.dart';
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

class WidgetDesignChatsHarag extends StatefulWidget {
  const WidgetDesignChatsHarag({
    super.key,
    required this.harage,
  });

  final HarageData harage;

  @override
  State<WidgetDesignChatsHarag> createState() =>
      _WidgetDesignChatsHaragState();
}

class _WidgetDesignChatsHaragState
    extends State<WidgetDesignChatsHarag> {

  @override
  void initState() {
    super.initState();

    // ============================================================
    // GET CHAT BY HARAGE ID
    // ============================================================

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final harageId = widget.harage.id;

      if (harageId != null) {
        context.read<HaragCubit>().getHarageChat(
          harageId: harageId,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      isSelected: false,
      onTap: () {},

      borderRadius: BorderRadius.circular(12),

      typeWidget: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // ======================================================
            // TITLE
            // ======================================================

            const TextInAppWidget(
              text: AppLanguageKeys.messages,
              textSize: 18,
              fontWeightIndex:
              FontSelectionData.mediumFontFamily,
              textColor:
              AppColors.darkColor,
            ),

            const SizedBox(height: 15),

            // ======================================================
            // CHAT
            // ======================================================

            SizedBox(
              height: 400,

              child: BlocBuilder<HaragCubit, HaragState>(
                builder: (context, state) {
                  final cubit = context.read<HaragCubit>();

                  // ==========================================================
                  // INITIAL LOADING
                  // ==========================================================

                  if (state is GetHarageChatLoading &&
                      cubit.harageChatResponse == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  // ==========================================================
                  // INITIAL ERROR
                  // ==========================================================

                  if (state is GetHarageChatError &&
                      cubit.harageChatResponse == null) {
                    return Center(
                      child: TextInAppWidget(
                        text: state.message,
                        textSize: 14,
                        fontWeightIndex:
                        FontSelectionData.mediumFontFamily,
                        textColor:
                        AppColors.greyColor,
                      ),
                    );
                  }

                  // ==========================================================
                  // CURRENT CHAT
                  // ==========================================================

                  final response =
                      cubit.harageChatResponse;

                  final messages =
                      response?.data?.messages ?? [];

                  final contributors =
                      response?.data?.contributors ?? [];

                  // ==========================================================
                  // EMPTY
                  // ==========================================================

                  if (messages.isEmpty) {
                    return const Center(
                      child: TextInAppWidget(
                        text: AppLanguageKeys.empty,
                        textSize: 14,
                        fontWeightIndex:
                        FontSelectionData.mediumFontFamily,
                        textColor:
                        AppColors.greyColor,
                      ),
                    );
                  }

                  // ==========================================================
                  // CHAT LIST
                  // ==========================================================

                  return ListView.builder(
                    itemCount: messages.length,

                    padding: EdgeInsets.zero,

                    itemBuilder: (context, index) {
                      final message =
                      messages[index];

                      return Padding(
                        padding:
                        const EdgeInsets.only(
                          bottom: 10,
                        ),

                        child: _buildChatItem(
                          context,
                          message,
                          contributors,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CHAT ITEM
  // ============================================================

  Widget _buildChatItem(
      BuildContext context,
      GetHarageChatMessage message,
      List<GetHarageChatContributor> contributors,
      ) {

    final contributor =
    _getChatContributor(
      message,
      contributors,
    );

    final image =
        contributor?.image;

    final userName =
    contributor?.name?.isNotEmpty == true
        ? contributor!.name!
        : '---';

    return InkWell(
      borderRadius:
      BorderRadius.circular(12),

      onTap: () {

        _showSendMessageDialog(
          context,
          message,
          contributor,
        );
      },

      child: Container(
        padding:
        const EdgeInsets.all(12),

        decoration: BoxDecoration(
          color:
          AppColors.whiteColor,

          borderRadius:
          BorderRadius.circular(12),

          border: Border.all(
            color:
            AppColors.greyColor
                .withOpacity(.2),
          ),
        ),

        child: Row(
          children: [

            // ====================================================
            // IMAGE
            // ====================================================

            image != null
                ? CircleAvatar(
              radius: 22,

              backgroundImage:
              MemoryImage(image),
            )
                : const CircleAvatar(
              radius: 22,

              child: Icon(
                Icons.person_outline,
              ),
            ),

            const SizedBox(width: 10),

            // ====================================================
            // NAME + MESSAGE
            // ====================================================

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  // ==================================================
                  // NAME
                  // ==================================================

                  TextInAppWidget(
                    text:
                    userName,

                    textSize: 14,

                    fontWeightIndex:
                    FontSelectionData
                        .mediumFontFamily,

                    textColor:
                    AppColors.darkColor,

                    maxLines: 1,
                  ),

                  const SizedBox(height: 5),

                  // ==================================================
                  // MESSAGE
                  // ==================================================

                  TextInAppWidget(
                    text:
                    message.message ?? '---',

                    textSize: 12,

                    fontWeightIndex:
                    FontSelectionData
                        .regularFontFamily,

                    textColor:
                    AppColors.greyColor,

                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // GET CONTRIBUTOR
  // ============================================================

  GetHarageChatContributor?
  _getChatContributor(
      GetHarageChatMessage message,
      List<GetHarageChatContributor> contributors,
      ) {

    // ==========================================================
    // MESSAGE SENDER
    // ==========================================================

    final sender =
    contributors.where(
          (user) =>
      user.userId ==
          message.fromUser &&
          user.userType ==
              message.fromUserType,
    );

    if (sender.isNotEmpty) {
      return sender.first;
    }

    // ==========================================================
    // MESSAGE RECEIVER
    // ==========================================================

    final receiver =
    contributors.where(
          (user) =>
      user.userId ==
          message.toUser &&
          user.userType ==
              message.toUserType,
    );

    if (receiver.isNotEmpty) {
      return receiver.first;
    }

    return null;
  }

  // ============================================================
  // SEND MESSAGE DIALOG
  // ============================================================

  void _showSendMessageDialog(
      BuildContext context,
      GetHarageChatMessage message,
      GetHarageChatContributor? contributor,
      ) {

    final messageController =
    TextEditingController();

    showDialog(
      context: context,

      builder: (dialogContext) {

        return AlertDialog(

          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(18),
          ),

          // ====================================================
          // TITLE
          // ====================================================

          title:
          const TextInAppWidget(
            text:
            AppLanguageKeys
                .sendUsMessage,

            textSize: 20,

            fontWeightIndex:
            FontSelectionData
                .boldFontFamily,

            textColor:
            AppColors.darkColor,

            isTextCenter: true,
          ),

          // ====================================================
          // MESSAGE INPUT
          // ====================================================

          content: TextField(
            controller:
            messageController,

            maxLines: 4,

            decoration:
            InputDecoration(

              hintText:
              AppLanguageKeys
                  .writeComment,

              hintStyle:
              const TextStyle(
                color:
                AppColors.greyColor,
              ),

              filled: true,

              fillColor:
              AppColors.greyColor
                  .withOpacity(.08),

              contentPadding:
              const EdgeInsets.all(14),

              border:
              OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(12),

                borderSide:
                BorderSide.none,
              ),

              enabledBorder:
              OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(12),

                borderSide:
                BorderSide.none,
              ),

              focusedBorder:
              OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(12),

                borderSide:
                const BorderSide(
                  color:
                  AppColors.orangeColor,
                ),
              ),
            ),
          ),

          // ====================================================
          // ACTIONS
          // ====================================================

          actions: [

            // ==================================================
            // CANCEL
            // ==================================================

            TextButton(
              onPressed: () {

                messageController.dispose();

                Navigator.pop(
                  dialogContext,
                );
              },

              child:
              const TextInAppWidget(
                text:
                AppLanguageKeys
                    .cancel,

                textSize: 14,

                textColor:
                AppColors.greyColor,
              ),
            ),

            // ==================================================
            // SEND
            // ==================================================

            ElevatedButton(

              style:
              ElevatedButton.styleFrom(
                backgroundColor:
                AppColors.orangeColor,

                shape:
                RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(10),
                ),
              ),

              onPressed: () {
                final text =
                messageController.text.trim();

                if (text.isEmpty) {
                  return;
                }

                final harageId =
                    message.harageId ??
                        widget.harage.id ??
                        0;

                if (harageId == 0) {
                  AppSnackBar.showError(
                    'Invalid Harage ID',
                  );
                  return;
                }

                context
                    .read<HaragCubit>()
                    .sendMessage(
                  message: text,
                  harageId: harageId,
                );

                Navigator.pop(
                  dialogContext,
                );

                AppSnackBar.showSuccess(
                  AppLanguageKeys.success,
                );
              },

              child:
              const TextInAppWidget(
                text:
                AppLanguageKeys.send,

                textSize: 14,

                textColor:
                AppColors.whiteColor,
              ),
            ),
          ],
        );
      },
    );
  }
}