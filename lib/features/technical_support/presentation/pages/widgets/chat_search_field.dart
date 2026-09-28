import 'package:flutter/material.dart';
import '../../../../../../core/theming/colors.dart';

class ChatSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const ChatSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    return Container(
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardStroke),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.appGrey, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: isAr ? 'البحث في المحادثات...' : 'Search messages...',
                hintStyle: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          if (controller.text.isNotEmpty)
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: onClear,
                child: const Icon(
                  Icons.close,
                  color: AppColors.appGrey,
                  size: 18,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
