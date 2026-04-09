import 'package:flutter/cupertino.dart';
import '../../../../../../../features/store_page/model/car_model/car_model.dart';
import '../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import 'car_category_list.dart';
import 'car_name_list.dart';

class CustomCardCar extends StatelessWidget {
  const CustomCardCar({
    super.key,
    required this.heightSizeBox,
    required this.typeModel,
    required this.heightContainer,
    required this.widthContainer,
    required this.heightImage,
    required this.widthImage,
    this.selectedCarName,
    this.scrollDirection,
  });

  final double heightSizeBox;
  final List<CarModel> typeModel;
  final double heightContainer;
  final double widthContainer;
  final double heightImage;
  final double widthImage;
  final String? selectedCarName;
  final Axis? scrollDirection;

  static String normalize(String input) {
    return input.toUpperCase().replaceAll(
          RegExp(r'[^A-Z0-9\u0621-\u064A]'),
          '',
        );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveDirection = scrollDirection ??
        (selectedCarName != null && selectedCarName!.isNotEmpty
            ? Axis.vertical
            : Axis.horizontal);
    return SizedBox(
      height: typeModel == CarNameList
          ? heightSizeBox
          : typeModel == CarCategoryList
              ? (selectedCarName != null && selectedCarName!.isNotEmpty
                  ? 382
                  : heightSizeBox)
              : heightSizeBox,
      child: ListView.builder(
        scrollDirection: effectiveDirection,
        itemCount: typeModel.length,
        itemBuilder: (context, index) {
          final car = typeModel[index];

          final query = selectedCarName?.trim() ?? '';
          final carName = car.name;
          final normalizedCarName = normalize(carName);
          final queryWords = query
              .split(" ")
              .map((word) => normalize(word))
              .where((word) => word.isNotEmpty)
              .toList();
          final isSelected = queryWords.any(
            (word) => normalizedCarName.contains(word),
          );

          return Padding(
            padding: EdgeInsets.zero,
            child: effectiveDirection == Axis.vertical
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      height: 65,
                      width: 368,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(19),
                        border: isSelected
                            ? Border.all(
                                color: AppColors.orangeColor,
                                width: 1,
                              )
                            : Border.all(
                                color: AppColors.whiteColor,
                                width: 1,
                              ),
                      ),
                      child: Center(
                        child: Row(
                          spacing: 18,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              car.Image,
                              width: widthImage,
                              height: heightImage,
                            ),
                            TextInAppWidget(
                              text: car.name,
                              textSize: 12,
                              fontWeightIndex:
                                  FontSelectionData.mediumFontFamily,
                              textColor: AppColors.darkColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Container(
                      height: heightContainer,
                      width: widthContainer,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(19),
                        border: isSelected
                            ? Border.all(
                                color: AppColors.orangeColor,
                                width: 1,
                              )
                            : Border.all(
                                color: AppColors.whiteColor,
                                width: 1,
                              ),
                      ),
                      child: Center(
                        child: Column(
                          spacing: 8,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              car.Image,
                              width: widthImage,
                              height: heightImage,
                            ),
                            TextInAppWidget(
                              text: car.name,
                              textSize: 12,
                              fontWeightIndex:
                                  FontSelectionData.mediumFontFamily,
                              textColor: AppColors.darkColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
