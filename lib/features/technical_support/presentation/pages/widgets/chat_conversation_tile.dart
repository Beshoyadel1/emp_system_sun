import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../data/model/employee_chat_model.dart';

class ChatConversationTile extends StatelessWidget {
  final GetAllMessagesModel chat;
  final bool isSelected;
  final int currentUserId;
  final int currentUserType;
  final VoidCallback onTap;

  const ChatConversationTile({
    super.key,
    required this.chat,
    required this.isSelected,
    required this.currentUserId,
    required this.currentUserType,
    required this.onTap,
  });

  String _getDisplayName(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    if (chat.tousertype == UserType.adminUser) {
      return isAr ? 'إدارة النظام' : 'System Management';
    }
    if (chat.userName != null && chat.userName!.trim().isNotEmpty) {
      return chat.userName!;
    }
    return isAr ? 'محادثة' : 'Conversation';
  }

  String _getRoleLabel(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    switch (chat.tousertype) {
      case UserType.adminUser:
        return isAr ? 'الدعم الفني' : 'Support';
      case UserType.providerUser:
        return isAr ? 'مزود خدمة' : 'Provider';
      case UserType.driverUser:
        return isAr ? 'سائق' : 'Driver';
      case UserType.appUser:
        return isAr ? 'عميل' : 'Customer';
      case UserType.companyUser:
        return isAr ? 'شركة' : 'Company';
      case UserType.employeeUser:
        return isAr ? 'زميل عمل' : 'Colleague';
      default:
        return isAr ? 'مستخدم' : 'User';
    }
  }

  String _formatTime(DateTime? date) {
    if (date == null) return '';
    return DateFormat('HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final unread = chat.unViewedMessagesCount;
    final lastMsg = chat.lastMessage;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.mainColor.withValues(alpha: 0.08)
                : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.mainColor : AppColors.cardStroke,
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          child: Row(
            children: [
              _ChatAvatar(image: chat.image, userType: chat.tousertype),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _getDisplayName(context),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.appBlackColor,
                            ),
                          ),
                        ),
                        if (lastMsg?.date != null)
                          Text(
                            _formatTime(lastMsg!.date),
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.scaffoldBackground,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            _getRoleLabel(context),
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            lastMsg?.message ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: unread > 0
                                  ? AppColors.appBlackColor
                                  : AppColors.textSecondary,
                              fontWeight: unread > 0
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                        if (unread > 0) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.errorRedColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              unread > 99 ? '99+' : unread.toString(),
                              style: const TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatAvatar extends StatelessWidget {
  final dynamic image;
  final int? userType;

  const _ChatAvatar({this.image, this.userType});

  @override
  Widget build(BuildContext context) {
    if (image != null && image.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.memory(
          image,
          width: 44,
          height: 44,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _FallbackAvatar(userType: userType),
        ),
      );
    }
    return _FallbackAvatar(userType: userType);
  }
}

class _FallbackAvatar extends StatelessWidget {
  final int? userType;

  const _FallbackAvatar({this.userType});

  IconData _getIcon() {
    switch (userType) {
      case UserType.adminUser:
        return Icons.support_agent;
      case UserType.providerUser:
        return Icons.storefront;
      case UserType.driverUser:
        return Icons.directions_car;
      case UserType.companyUser:
        return Icons.business;
      case UserType.employeeUser:
        return Icons.badge;
      default:
        return Icons.person;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.mainColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Icon(
          _getIcon(),
          color: AppColors.mainColor,
          size: 24,
        ),
      ),
    );
  }
}
