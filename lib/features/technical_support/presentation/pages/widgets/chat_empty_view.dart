import 'package:flutter/material.dart';
import '../../../../../../core/theming/colors.dart';

class ChatEmptyView extends StatelessWidget {
  const ChatEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.mainColor.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 40,
                  color: AppColors.mainColor,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              isAr
                  ? 'اختر محادثة لبدء المراسلة'
                  : 'Select a conversation to start chatting',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.appBlackColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isAr
                  ? 'يمكنك التواصل مع العملاء، إدارة النظام، وفريق العمل هنا'
                  : 'You can communicate with customers, system administration, and your team here',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
