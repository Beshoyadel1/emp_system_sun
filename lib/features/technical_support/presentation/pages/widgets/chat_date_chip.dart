import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/theming/colors.dart';

class ChatDateChip extends StatelessWidget {
  final DateTime date;

  const ChatDateChip({super.key, required this.date});

  String _formatDateSeparator(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final target = DateTime(date.year, date.month, date.day);

    if (target == today) {
      return isAr ? 'اليوم' : 'Today';
    } else if (target == yesterday) {
      return isAr ? 'أمس' : 'Yesterday';
    } else {
      return DateFormat('d MMMM y', isAr ? 'ar' : 'en').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.scaffoldBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardStroke),
        ),
        child: Text(
          _formatDateSeparator(context),
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
