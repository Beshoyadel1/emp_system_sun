import 'package:flutter/material.dart';
import '../../../../../../../core/language/language_constant.dart';
import '../../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../features/cars_haraj_page/data/model/get_car_details_model/get_car_details_model.dart';

class WidgetDesignRecentInvoicesCar extends StatelessWidget {
  final List<RecentInvoiceModel> invoices;

  const WidgetDesignRecentInvoicesCar({
    super.key,
    required this.invoices,
  });

  @override
  Widget build(BuildContext context) {
    return  CustomContainer(
      onTap: (){},
      isSelected: false,
      typeWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const TextInAppWidget(
            text: AppLanguageKeys.carInvoiceDetails,
            textSize: 17,
            fontWeightIndex:
            FontSelectionData.boldFontFamily,
            textColor: AppColors.blackColor,
            textAlign: TextAlign.right,
          ),

          const SizedBox(height: 20),

          if (invoices.isEmpty)
            const Padding(
              padding: EdgeInsets.all(30),
              child: Center(
                child: TextInAppWidget(
                  text: AppLanguageKeys.empty,
                  textSize: 14,
                  fontWeightIndex:
                  FontSelectionData.mediumFontFamily,
                  textColor: AppColors.greyColor,
                ),
              ),
            )
          else
            ...invoices.map(
                  (invoice) => _InvoiceItem(
                invoice: invoice,
              ),
            ),
        ],
      ),
    );
  }
}

class _InvoiceItem extends StatelessWidget {
  final RecentInvoiceModel invoice;

  const _InvoiceItem({
    required this.invoice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              TextInAppWidget(
                text: invoice.id != null
                    ? '#${invoice.id}'
                    : '-',
                textSize: 13,
                fontWeightIndex:
                FontSelectionData.mediumFontFamily,
                textColor: AppColors.blackColor,
              ),

              TextInAppWidget(
                text: _formatDate(invoice.date),
                textSize: 12,
                fontWeightIndex:
                FontSelectionData.regularFontFamily,
                textColor: AppColors.greyColor,
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextInAppWidget(
                  text: invoice.categoryName ?? '-',
                  textSize: 13,
                  fontWeightIndex:
                  FontSelectionData.regularFontFamily,
                  textColor: AppColors.blackColor,
                  textAlign: TextAlign.right,
                ),
              ),

              const SizedBox(width: 10),

              TextInAppWidget(
                text:
                '${invoice.amount?.toStringAsFixed(2) ?? '0.00'} ر.س',
                textSize: 13,
                fontWeightIndex:
                FontSelectionData.boldFontFamily,
                textColor: AppColors.orangeColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return '-';
    }

    return '${date.day}/${date.month}/${date.year}';
  }
}