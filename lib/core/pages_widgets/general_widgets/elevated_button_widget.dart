import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final ButtonStyle? style;
  final Widget child;

  const ElevatedButtonWidget({
    super.key,
    required this.onPressed,
    this.style,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: child,
    );
  }
}

/*

class ElevatedButtonWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final PageController controller;
  final VoidCallback onNext;
  final void Function(BuildContext) navigateToPage;
  final String text;

  const ElevatedButtonWidget ({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.controller,
    required this.onNext,
    required this.navigateToPage,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = currentPage == totalPages - 1;

    return ElevatedButton(
      onPressed: () {
        if (isLastPage) {
          navigateToPage(context);
        } else {
          onNext();
          controller.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        }
      },
      style: isLastPage
          ? ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding:
        const EdgeInsets.symmetric(horizontal: 25, vertical: 6),
        backgroundColor: AppColors.orangeColor,
        foregroundColor: AppColors.whiteColor,
      )
          : ElevatedButton.styleFrom(
        shape: const CircleBorder(
          side: BorderSide(color: AppColors.orangeColor, width: 8),
        ),
        padding: const EdgeInsets.all(18),
        backgroundColor: AppColors.whiteColor,
        foregroundColor: AppColors.orangeColor,
      ),
      child: isLastPage
          ?     TextInAppWidget(
        text: text,
        textSize: 16,
        fontWeightIndex: FontSelectionData.boldFontFamily,
        textColor: AppColors.whiteColor,
      )
          : const Icon(Icons.arrow_forward_ios),
    );
  }
}

 */
