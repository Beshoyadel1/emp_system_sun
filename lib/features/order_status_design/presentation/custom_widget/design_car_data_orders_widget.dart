import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../core/language/language_constant.dart';
import '../../../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../../../core/theming/colors.dart';
import '../../../../../../../../core/theming/fonts.dart';
import '../../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../../features/internal_services/data/model/get_provider_orders_model/order_details_model.dart';

class DesignCarDataOrdersWidget extends StatelessWidget {
  final String? brandName;
  final String? totalPriceCar;
  final String? plateNo;

  final List<ProvService>? provServices;

  final bool isArabic;

  const DesignCarDataOrdersWidget({
    super.key,
    this.brandName,
    this.totalPriceCar,
    this.plateNo,
    this.provServices,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    final services = provServices ?? [];

    return CustomContainer(
      onTap: () {},
      isSelected: true,
      borderRadius: BorderRadius.circular(5),
      border: Border.all(
        color: AppColors.orangeColor.withOpacity(0.4),
      ),
      typeWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= CAR HEADER =================

          LayoutBuilder(
            builder: (context, constraints) {
              final bool isMobile = constraints.maxWidth < 430;

              final leftWidget = Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomContainer(
                    onTap: () {},
                    isSelected: true,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: AppColors.orangeColor.withOpacity(0.4),
                    ),
                    typeWidget: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        CupertinoIcons.car_fill,
                        color: AppColors.orangeColor,
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Flexible(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        TextInAppWidget(
                          text: brandName ?? '',
                          textSize: 16,
                          fontWeightIndex:
                          FontSelectionData.boldFontFamily,
                          textColor:
                          AppColors.blackColor,
                        ),

                        const SizedBox(height: 5),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const TextInAppWidget(
                              text: AppLanguageKeys.dubaiPlate,
                              textSize: 12,
                              fontWeightIndex:
                              FontSelectionData
                                  .mediumFontFamily,
                              textColor:
                              AppColors.greyColor,
                            ),

                            TextInAppWidget(
                              text: plateNo ?? '',
                              textSize: 12,
                              fontWeightIndex:
                              FontSelectionData
                                  .mediumFontFamily,
                              textColor:
                              AppColors.greyColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );

              final rightWidget = Column(
                crossAxisAlignment: isMobile
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  const TextInAppWidget(
                    text: AppLanguageKeys.totalVehicle,
                    textSize: 12,
                    fontWeightIndex:
                    FontSelectionData.mediumFontFamily,
                    textColor: AppColors.greyColor,
                  ),

                  const SizedBox(height: 5),

                  Row(
                    spacing: 5,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextInAppWidget(
                        text: totalPriceCar ?? '0',
                        textSize: 16,
                        fontWeightIndex:
                        FontSelectionData.mediumFontFamily,
                        textColor:
                        AppColors.orangeColor,
                      ),

                      const TextInAppWidget(
                        text: AppLanguageKeys.dirham,
                        textSize: 16,
                        fontWeightIndex:
                        FontSelectionData.mediumFontFamily,
                        textColor:
                        AppColors.orangeColor,
                      ),
                    ],
                  ),
                ],
              );

              if (!isMobile) {
                return Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Expanded(child: leftWidget),
                    const SizedBox(width: 20),
                    rightWidget,
                  ],
                );
              }

              return Wrap(
                spacing: 20,
                runSpacing: 15,
                children: [
                  leftWidget,
                  rightWidget,
                ],
              );
            },
          ),

          const SizedBox(height: 10),

          Divider(
            color:
            AppColors.orangeColor.withOpacity(0.3),
          ),

          // ================= TABLE HEADER =================

          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 500) {
                return const Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    TextInAppWidget(
                      text: AppLanguageKeys.services,
                      textSize: 13,
                      fontWeightIndex:
                      FontSelectionData.mediumFontFamily,
                      textColor: AppColors.greyColor,
                    ),
                    TextInAppWidget(
                      text: AppLanguageKeys.price,
                      textSize: 13,
                      fontWeightIndex:
                      FontSelectionData.mediumFontFamily,
                      textColor: AppColors.greyColor,
                    ),
                  ],
                );
              }

              return const Wrap(
                spacing: 20,
                runSpacing: 10,
                children: [
                  TextInAppWidget(
                    text: AppLanguageKeys.services,
                    textSize: 13,
                    fontWeightIndex:
                    FontSelectionData.mediumFontFamily,
                    textColor: AppColors.greyColor,
                  ),
                  TextInAppWidget(
                    text: AppLanguageKeys.price,
                    textSize: 13,
                    fontWeightIndex:
                    FontSelectionData.mediumFontFamily,
                    textColor: AppColors.greyColor,
                  ),
                ],
              );
            },
          ),

          Divider(
            color:
            AppColors.orangeColor.withOpacity(0.3),
          ),

          // ================= SERVICES =================

          SizedBox(
            height: services.length > 4 ? 200 : null,
            child: ListView.separated(
              shrinkWrap: true,
              physics: services.length > 4
                  ? const AlwaysScrollableScrollPhysics()
                  : const NeverScrollableScrollPhysics(),

              itemCount: services.length,

              separatorBuilder: (_, __) =>
              const SizedBox(height: 20),

              itemBuilder: (context, index) {
                final service = services[index];

                final String serviceName = isArabic
                    ? service.name ?? ''
                    : service.latinname ?? '';

                final String price =
                    service.price?.toString() ?? '0';

                final String tax =
                    service.taxpercentage?.toString() ?? '0';

                final String total =
                    service.totalprice?.toString() ?? '0';

                return LayoutBuilder(
                  builder: (context, constraints) {
                    final bool isMobile =
                        constraints.maxWidth < 500;

                    final serviceWidget = Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        TextInAppWidget(
                          text: serviceName,
                          textSize: 14,
                          fontWeightIndex:
                          FontSelectionData
                              .mediumFontFamily,
                          textColor:
                          AppColors.greyColor,
                        ),

                        const SizedBox(height: 3),

                        Row(
                          spacing: 5,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const TextInAppWidget(
                              text:AppLanguageKeys.taxes,
                              textSize: 12,
                              fontWeightIndex:
                              FontSelectionData
                                  .mediumFontFamily,
                              textColor:
                              AppColors.orangeColor,
                            ),

                            TextInAppWidget(
                              text: '$tax%',
                              textSize: 12,
                              fontWeightIndex:
                              FontSelectionData
                                  .mediumFontFamily,
                              textColor:
                              AppColors.orangeColor,
                            ),

                            const SizedBox(width: 10),

                            const TextInAppWidget(
                              text: AppLanguageKeys.price,
                              textSize: 12,
                              fontWeightIndex:
                              FontSelectionData
                                  .mediumFontFamily,
                              textColor:
                              AppColors.orangeColor,
                            ),

                            TextInAppWidget(
                              text: price,
                              textSize: 12,
                              fontWeightIndex:
                              FontSelectionData
                                  .mediumFontFamily,
                              textColor:
                              AppColors.orangeColor,
                            ),
                          ],
                        ),
                      ],
                    );

                    final priceWidget = Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextInAppWidget(
                          text: total,
                          textSize: 16,
                          fontWeightIndex:
                          FontSelectionData
                              .mediumFontFamily,
                          textColor:
                          AppColors.blackColor,
                        ),

                        const SizedBox(width: 3),

                        const TextInAppWidget(
                          text:
                          AppLanguageKeys.dirham,
                          textSize: 16,
                          fontWeightIndex:
                          FontSelectionData
                              .mediumFontFamily,
                          textColor:
                          AppColors.blackColor,
                        ),
                      ],
                    );

                    if (!isMobile) {
                      return Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: serviceWidget,
                          ),
                          const SizedBox(width: 20),
                          priceWidget,
                        ],
                      );
                    }

                    return Wrap(
                      spacing: 20,
                      runSpacing: 10,
                      children: [
                        serviceWidget,
                        priceWidget,
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}