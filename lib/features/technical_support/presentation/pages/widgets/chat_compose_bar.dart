import 'package:flutter/material.dart';
import '../../../../../../core/theming/colors.dart';

class ChatComposeBar extends StatefulWidget {
  final bool isSending;
  final ValueChanged<String> onSend;

  const ChatComposeBar({
    super.key,
    required this.isSending,
    required this.onSend,
  });

  @override
  State<ChatComposeBar> createState() => _ChatComposeBarState();
}

class _ChatComposeBarState extends State<ChatComposeBar> {
  late final TextEditingController _controller;
  bool _hasContent = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      final has = _controller.text.trim().isNotEmpty;
      if (has != _hasContent) {
        setState(() {
          _hasContent = has;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty || widget.isSending) return;
    widget.onSend(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        border: Border(top: BorderSide(color: AppColors.cardStroke)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.scaffoldBackground,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.cardStroke),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _controller,
                  textInputAction: TextInputAction.send,
                  minLines: 1,
                  maxLines: 4,
                  onSubmitted: (_) => _submit(),
                  decoration: InputDecoration(
                    hintText: isAr ? 'اكتب رسالتك هنا...' : 'Type a message...',
                    hintStyle: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            MouseRegion(
              cursor: (_hasContent && !widget.isSending)
                  ? SystemMouseCursors.click
                  : SystemMouseCursors.basic,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: (_hasContent && !widget.isSending)
                      ? AppColors.mainColor
                      : AppColors.scaffoldBackground,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.cardStroke),
                ),
                child: IconButton(
                  icon: widget.isSending
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.mainColor,
                          ),
                        )
                      : Icon(
                          Icons.send_rounded,
                          size: 20,
                          color: _hasContent
                              ? AppColors.whiteColor
                              : AppColors.appGrey,
                        ),
                  onPressed:
                      (_hasContent && !widget.isSending) ? _submit : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
