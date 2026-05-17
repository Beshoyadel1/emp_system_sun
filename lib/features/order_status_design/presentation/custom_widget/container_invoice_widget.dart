import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/theming/colors.dart';


class ContainerInvoiceWidget extends StatelessWidget {
  final bool? isFinished;
  final String priceInsuranceInstallment,priceTaxes,priceTotal;
  final String? textTimeFinishPay;
  final String? selectedImage;

  const ContainerInvoiceWidget({
    this.selectedImage,
    this.textTimeFinishPay,
    this.isFinished=false,
    required this.priceInsuranceInstallment,
    required this.priceTaxes,
    required this.priceTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.all(10),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        border: Border.all(
            color: AppColors.greyColor.withOpacity(0.3)
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkColor.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextInAppWidget(
            text: AppLanguageKeys.invoice,
            textSize: 12,
            fontWeightIndex: FontSelectionData.regularFontFamily,
            textColor: AppColors.darkColor,
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextInAppWidget(
                      text: AppLanguageKeys.insuranceInstallment,
                      textSize: 10,
                      fontWeightIndex: FontSelectionData.regularFontFamily,
                      textColor: AppColors.darkColor,
                    ),
                    Row(
                      children: [
                        TextInAppWidget(
                          text: priceInsuranceInstallment,
                          textSize: 10,
                          fontWeightIndex: FontSelectionData.regularFontFamily,
                          textColor: AppColors.darkColor,
                        ),
                        SizedBox(width: 5,),
                        Image.asset(AppImageKeys.coin,color: AppColors.darkColor,width: 11,)
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextInAppWidget(
                      text: AppLanguageKeys.taxes,
                      textSize: 10,
                      fontWeightIndex: FontSelectionData.regularFontFamily,
                      textColor: AppColors.darkColor,
                    ),
                    Row(
                      children: [
                        TextInAppWidget(
                          text: priceTaxes,
                          textSize: 10,
                          fontWeightIndex: FontSelectionData.regularFontFamily,
                          textColor: AppColors.darkColor,
                        ),
                        SizedBox(width: 5,),
                        Image.asset(AppImageKeys.coin,color: AppColors.darkColor,width: 11,)
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Divider(
                  thickness: 1,
                  color:AppColors.greyColor,
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextInAppWidget(
                      text: AppLanguageKeys.total,
                      textSize: 12,
                      fontWeightIndex: FontSelectionData.regularFontFamily,
                      textColor: AppColors.darkColor,
                    ),
                    Row(
                      children: [
                        TextInAppWidget(
                          text: priceTotal,
                          textSize: 14,
                          fontWeightIndex: FontSelectionData.mediumFontFamily,
                          textColor: AppColors.orangeColor,
                        ),
                        SizedBox(width: 5,),
                        Image.asset(AppImageKeys.coin,color: AppColors.orangeColor,width: 13,)
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                if (isFinished! && selectedImage != null) Column(
                  children: [
                    Divider(
                      thickness: 1,
                      color: AppColors.greyColor,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            TextInAppWidget(
                              text: AppLanguageKeys.paidBy,
                              textSize: 10,
                              fontWeightIndex: FontSelectionData.regularFontFamily,
                              textColor: AppColors.darkColor,
                            ),
                            SizedBox(width: 5,),
                            Image.asset(selectedImage!,width: 50,)
                          ],
                        ),
                        TextInAppWidget(
                          text: textTimeFinishPay!,
                          textSize: 10,
                          fontWeightIndex: FontSelectionData.mediumFontFamily,
                          textColor: AppColors.orangeColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
