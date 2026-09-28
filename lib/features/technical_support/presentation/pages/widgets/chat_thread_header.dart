import 'package:flutter/material.dart';
import '../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../data/model/employee_chat_model.dart';

class ChatThreadHeader extends StatelessWidget {
  final GetAllMessagesModel chat;
  final bool showBackButton;
  final VoidCallback? onBack;

  const ChatThreadHeader({
    super.key,
    required this.chat,
    this.showBackButton = false,
    this.onBack,
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
        return isAr ? 'الدعم الفني' : 'Technical Support';
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        border: Border(bottom: BorderSide(color: AppColors.cardStroke)),
      ),
      child: Row(
        children: [
          if (showBackButton) ...[
            IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.appBlackColor),
              onPressed: onBack ?? () => Navigator.of(context).maybePop(),
            ),
            const SizedBox(width: 4),
          ],
          _HeaderAvatar(image: chat.image, userType: chat.tousertype),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _getDisplayName(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.appBlackColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _getRoleLabel(context),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderAvatar extends StatelessWidget {
  final dynamic image;
  final int? userType;

  const _HeaderAvatar({this.image, this.userType});

  @override
  Widget build(BuildContext context) {
    if (image != null && image.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.memory(
          image,
          width: 42,
          height: 42,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _HeaderFallback(userType: userType),
        ),
      );
    }
    return _HeaderFallback(userType: userType);
  }
}

class _HeaderFallback extends StatelessWidget {
  final int? userType;

  const _HeaderFallback({this.userType});

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
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: AppColors.mainColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Icon(
          _getIcon(),
          color: AppColors.mainColor,
          size: 22,
        ),
      ),
    );
  }
}
