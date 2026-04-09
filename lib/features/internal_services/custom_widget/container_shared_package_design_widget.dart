import 'package:emp_system_sun/features/internal_services/custom_widget/container_edit_delete_widget.dart';
import 'package:emp_system_sun/features/internal_services/custom_widget/container_package_widget.dart';
import 'package:emp_system_sun/features/internal_services/custom_widget/row_text_correct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../features/internal_services/internal_orders/custom_widget/row_number_coin_widget.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';

class ContainerSharedPackageDesignWidget extends StatelessWidget {
  final String textPackage, price;
  final List<String> items;
  final void Function()? onPressedDelete, onPressedEdit;

  const ContainerSharedPackageDesignWidget({
    super.key,
    required this.textPackage,
    required this.price,
    required this.items,
    this.onPressedDelete,
    this.onPressedEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.greyColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        spacing: 20,
        mainAxisSize: MainAxisSize.min,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 5,
            children: [
              ContainerEditDeleteWidget(
                size: 15,
                onPressed: onPressedEdit,
              ),
              ContainerEditDeleteWidget(
                isDelete: true,
                size: 15,
                onPressed: onPressedDelete,
              )
            ],
          ),
          ContainerPackageWidget(text: textPackage),
          RowNumberCoinWidget(
            numberText: price,
            sizeText: 15,
            imageSrc: AppImageKeys.coin,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: items.map((e) {
              return RowTextCorrect(text: e);
            }).toList(),
          )
        ],
      ),
    );
  }
}