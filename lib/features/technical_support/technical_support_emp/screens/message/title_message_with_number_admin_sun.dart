import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../features/technical_support/logic/message_cubit/message_cubit.dart';
import '../../../../../features/technical_support/logic/message_cubit/message_state.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/language/language_constant.dart';

class TitleMessageWithNumberAdminSun extends StatelessWidget {
  const TitleMessageWithNumberAdminSun({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20,
      children: [
        const Flexible(
          child: TextInAppWidget(
            text: AppLanguageKeys.membersCount,
            textSize: 15,
            fontWeightIndex: FontSelectionData.regularFontFamily,
            textColor: AppColors.blackColor,
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: const BoxDecoration(
            color: AppColors.greyColor200,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: BlocBuilder<MessageCubit, MessageState>(
            builder: (context, state) {
              if (state is MessageLoading) {
                return const CupertinoActivityIndicator();
              }
              if (state is MessageError) {
                return const SizedBox();
              }
              if (state is MessageSuccess) {
                return TextInAppWidget(
                  text: state.messages.length.toString(),
                  textSize: 12,
                  fontWeightIndex: FontSelectionData.regularFontFamily,
                  textColor: AppColors.blackColor,
                );
              }
              return const SizedBox();
            },
          ),
        )
      ],
    );
  }
}