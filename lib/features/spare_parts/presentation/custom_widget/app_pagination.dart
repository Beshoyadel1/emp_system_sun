import 'package:flutter/material.dart';
import 'package:number_pagination/number_pagination.dart';
import '../../../../../../../../core/theming/colors.dart';

class AppPagination extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int page) onPageChanged;

  const AppPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (totalPages <= 1) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: NumberPagination(
          totalPages: totalPages,
          currentPage: currentPage,
          buttonRadius: 25, // circle
          unSelectedButtonColor: AppColors.greyColor,
          selectedButtonColor: AppColors.orangeColor,
          selectedNumberColor: AppColors.whiteColor,
          unSelectedNumberColor: AppColors.whiteColor,
          onPageChanged: onPageChanged,
        ),
      ),
    );
  }
}