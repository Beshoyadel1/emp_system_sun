import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../core/theming/colors.dart';
import '../../bloc/employee_chat_cubit/employee_chat_cubit.dart';
import '../../bloc/employee_chat_cubit/employee_chat_state.dart';
import '../../../data/model/employee_chat_model.dart';
import 'work_team_member_tile.dart';

class ChatWorkTeamPanel extends StatelessWidget {
  final ValueChanged<GetAllMessagesModel>? onSelectMember;

  const ChatWorkTeamPanel({super.key, this.onSelectMember});

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    return BlocBuilder<EmployeeChatCubit, EmployeeChatState>(
      builder: (context, state) {
        final cubit = context.read<EmployeeChatCubit>();
        final members = state.workTeam;

        return Container(
          decoration: const BoxDecoration(
            color: AppColors.whiteColor,
            border: BorderDirectional(
              start: BorderSide(color: AppColors.cardStroke),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text(
                      isAr ? 'فريق العمل والدعم' : 'Work Team & Support',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.appBlackColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.scaffoldBackground,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.cardStroke),
                      ),
                      child: Text(
                        members.length.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.refresh,
                          color: AppColors.appGrey, size: 20),
                      onPressed: () => cubit.getWorkTeam(),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: AppColors.cardStroke),
              Expanded(
                child: state.isLoadingWorkTeam && members.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.mainColor,
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(12),
                        itemCount: members.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final member = members[index];
                          return WorkTeamMemberTile(
                            member: member,
                            onTap: () {
                              final langCode =
                                  Localizations.localeOf(context).languageCode;
                              final targetUserId =
                                  member.usertype == UserType.adminUser
                                      ? 1
                                      : (member.userid ?? 0);
                              final targetUserType = member.usertype ?? 0;

                              GetAllMessagesModel? targetChat;
                              for (final e in state.allMessages) {
                                final matchesAdmin =
                                    e.tousertype == UserType.adminUser &&
                                        targetUserType == UserType.adminUser;
                                final matchesUser = e.touser == targetUserId &&
                                    e.tousertype == targetUserType;
                                if (matchesAdmin || matchesUser) {
                                  targetChat = e;
                                  break;
                                }
                              }

                              targetChat ??= GetAllMessagesModel(
                                touser: targetUserId,
                                tousertype: targetUserType,
                                userName: member.getLocalizedName(langCode),
                                messages: [],
                                noOldMessages: true,
                                image: member.image,
                              );

                              cubit.selectChat(targetChat);
                              onSelectMember?.call(targetChat);
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
