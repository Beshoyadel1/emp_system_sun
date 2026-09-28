import 'package:flutter/material.dart';
import '../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../data/model/employee_chat_model.dart';

class WorkTeamMemberTile extends StatelessWidget {
  final WorkTeamMemberModel member;
  final VoidCallback onTap;

  const WorkTeamMemberTile({
    super.key,
    required this.member,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;
    final name = member.getLocalizedName(langCode);
    final job = member.getLocalizedJobName(langCode);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.cardStroke),
          ),
          child: Row(
            children: [
              _MemberAvatar(image: member.image, userType: member.usertype),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.appBlackColor,
                      ),
                    ),
                    if (job.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        job,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(
                Icons.chat_outlined,
                color: AppColors.mainColor,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MemberAvatar extends StatelessWidget {
  final dynamic image;
  final int? userType;

  const _MemberAvatar({this.image, this.userType});

  @override
  Widget build(BuildContext context) {
    if (image != null && image.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.memory(
          image,
          width: 40,
          height: 40,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _Fallback(userType: userType),
        ),
      );
    }
    return _Fallback(userType: userType);
  }
}

class _Fallback extends StatelessWidget {
  final int? userType;

  const _Fallback({this.userType});

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
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.mainColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Icon(
          _getIcon(),
          color: AppColors.mainColor,
          size: 20,
        ),
      ),
    );
  }
}
