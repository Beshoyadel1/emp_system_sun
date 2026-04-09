import 'package:flutter/material.dart';
import '../../../../../core/theming/colors.dart';

class NumberIndicator extends StatelessWidget {
  NumberIndicator({super.key});

  final int totalPages = 10;
  final ValueNotifier<int> currentPage = ValueNotifier<int>(1);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ValueListenableBuilder<int>(
        valueListenable: currentPage,
        builder: (context, value, _) {
          return Wrap(
            children: [
              ...List.generate(totalPages, (index) {
                int number = index + 1;
                bool isSelected = number == value;
                if (number > 3 && number < totalPages) {
                  if (number == 5) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        Icons.more_horiz,
                        color: AppColors.greyColor,
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }
                return GestureDetector(
                  onTap: () {
                    currentPage.value = number;
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.orangeColor
                          : AppColors.greyColor,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "$number",
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
