import 'package:flutter/material.dart';
import '../../../../../../../features/cars_haraj_page/presentation/custom_widget/text_with_harage_container_status.dart';
import '../../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../features/cars_haraj_page/data/model/get_all_harage_model/harage_data.dart';


class WidgetDesignDetailsDataHaragCar extends StatelessWidget {
  const WidgetDesignDetailsDataHaragCar({
    super.key,
    required this.harage,
  });

  final HarageData harage;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      containerWidth: double.infinity,
      isSelected: false,
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      typeWidget: Padding(
        padding: const EdgeInsets.all(25),
        child: Wrap(
          spacing: 30,
          runSpacing: 25,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [

            // ==========================================
            // CAR IMAGE
            // ==========================================

            SizedBox(
              width: 150,
              child: Column(
                children: [

                  _buildCarImage(),

                  const SizedBox(height: 10),

                  _buildStatus(),
                ],
              ),
            ),

            // ==========================================
            // CAR INFORMATION
            // ==========================================

            SizedBox(
              width: 600,
              child: Wrap(
                spacing: 45,
                runSpacing: 25,
                children: [

                  _buildInfoItem(
                    AppLanguageKeys.identity,
                    '#${harage.id ?? '-'}',
                  ),

                  _buildInfoItem(
                    AppLanguageKeys.releaseDate,
                    harage.releaseDate ?? '-',
                  ),

                  _buildInfoItem(
                    AppLanguageKeys.kilometers,
                    '${harage.kilometers ?? 0} KM',
                  ),

                  _buildInfoItem(
                    AppLanguageKeys.price,
                    '${harage.price ?? 0}',
                  ),

                  _buildInfoItem(
                    AppLanguageKeys.transmissionType,
                    '${harage.transmissionType ?? '-'}',
                  ),

                  _buildInfoItem(
                    AppLanguageKeys.fuelType,
                    _getFuelTypeName(harage.fuelType),
                  ),

                  _buildInfoItem(
                    AppLanguageKeys.comment,
                    harage.currentStatus?.notes ?? AppLanguageKeys.noComment,
                  ),

                  TextWithHarageContainerStatus(
                    text: AppLanguageKeys.orderStatus,
                    status:harage.currentStatus?.status,
                  ),
                ],
              ),
            ),

            // ==========================================
            // USER
            // ==========================================
            _buildInfoItem(
              AppLanguageKeys.carStatus,
              harage.isSold == true
                  ? AppLanguageKeys.sold
                  : AppLanguageKeys.notSold,
            ),

            if (harage.isSold == true)
              _buildInfoItem(
                AppLanguageKeys.sellDate,
                harage.sellDate ?? '-',
              ),
            if (harage.user != null)
              _buildUser(context),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CAR IMAGE
  // ============================================================

  Widget _buildCarImage() {
    if (harage.car?.carImage == null) {
      return Container(
        width: 140,
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.greyColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.directions_car_outlined,
          size: 35,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.memory(
        harage.car!.carImage!,
        width: 140,
        height: 80,
        fit: BoxFit.cover,
      ),
    );
  }

  // ============================================================
  // STATUS
  // ============================================================

  Widget _buildStatus() {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      alignment: WrapAlignment.center,
      children: [

        _buildStatusBadge(
          text: harage.isNew == true
              ? AppLanguageKeys.newCar
              : AppLanguageKeys.usedCar,
          color: harage.isNew == true
              ? Colors.green
              : Colors.orange,
        ),

        _buildStatusBadge(
          text: harage.isSold == true
              ? AppLanguageKeys.sold
              : AppLanguageKeys.notSold,
          color: harage.isSold == true
              ? Colors.red
              : Colors.green,
        ),
      ],
    );
  }

  Widget _buildStatusBadge({
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextInAppWidget(
        text: text,
        textSize: 10,
        fontWeightIndex:
        FontSelectionData.mediumFontFamily,
        textColor: color,
      ),
    );
  }

  // ============================================================
  // INFO
  // ============================================================

  Widget _buildInfoItem(
      String title,
      String value,
      ) {
    return SizedBox(
      width: 130,
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          TextInAppWidget(
            text: title,
            textSize: 12,
            fontWeightIndex:
            FontSelectionData.mediumFontFamily,
            textColor:
            AppColors.greyColor,
            maxLines: 1,
          ),

          const SizedBox(height: 6),

          TextInAppWidget(
            text: value,
            textSize: 14,
            fontWeightIndex:
            FontSelectionData.mediumFontFamily,
            textColor:
            AppColors.darkColor,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // USER
  // ============================================================

  Widget _buildUser(BuildContext context) {
    return  Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [

        if (harage.user?.image != null)
          CircleAvatar(
            radius: 22,
            backgroundImage:
            MemoryImage(
              harage.user!.image!,
            ),
          ),

        if (harage.user?.image != null)
          const SizedBox(width: 10),

        TextInAppWidget(
          text: harage.user!.getName(context),
          textSize: 15,
          fontWeightIndex:
          FontSelectionData.mediumFontFamily,
          textColor:
          AppColors.blackColor,
        ),
      ],
    );
  }
  String _getFuelTypeName(dynamic fuelType) {
    if (fuelType == null) {
      return '-';
    }

    final int? fuelTypeId = int.tryParse(
      fuelType.toString(),
    );

    if (fuelTypeId == null) {
      return '-';
    }

    final FuelTypeModel? fuel = FuelTypes.all.cast<FuelTypeModel?>().firstWhere(
          (item) => item!.id == fuelTypeId,
      orElse: () => null,
    );

    return fuel?.name ?? '-';
  }
}