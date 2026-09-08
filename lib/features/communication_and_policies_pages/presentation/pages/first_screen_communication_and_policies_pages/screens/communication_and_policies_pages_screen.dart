import 'package:emp_system_sun/core/language/language_constant.dart';
import 'package:emp_system_sun/core/theming/colors.dart';
import 'package:emp_system_sun/core/theming/fonts.dart';
import 'package:emp_system_sun/core/theming/text_styles.dart';
import 'package:emp_system_sun/features/communication_and_policies_pages/presentation/cubit/tab_new_cubit/tab_insurance_new_offers_cubit.dart';
import 'package:emp_system_sun/features/communication_and_policies_pages/presentation/cubit/tab_new_cubit/tab_insurance_new_offers_state.dart';
import 'package:emp_system_sun/features/communication_and_policies_pages/presentation/custom_widget/tab_communication_and_policies_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunicationAndPoliciesPagesScreen extends StatelessWidget {
  const CommunicationAndPoliciesPagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabInsuranceNewOffersCubit, TabInsuranceNewOffersState>(
      builder: (context, state) {
        final cubit = context.read<TabInsuranceNewOffersCubit>();

        if (state is PagesAboutLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is PagesAboutErrorState) {
          return _PagesAboutError(
            message: state.message,
            onRetry: cubit.loadPages,
          );
        }

        if (cubit.pages.isEmpty) {
          return const Center(
            child: TextInAppWidget(
              text: AppLanguageKeys.empty,
              textSize: 15,
              textColor: AppColors.greyColor,
            ),
          );
        }

        final locale = Localizations.localeOf(context);
        final isArabic = locale.languageCode.toLowerCase() == 'ar';
        final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
        final selectedPage = cubit.pages[cubit.currentIndex];

        return Directionality(
          textDirection: textDirection,
          child: Column(
            crossAxisAlignment:
                isArabic ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  textDirection: textDirection,
                  spacing: 0,
                  runSpacing: 0,
                  children: [
                    for (var index = 0; index < cubit.pages.length; index++)
                      InkWell(
                        key: ValueKey(
                          'about-page-tab-${cubit.pages[index].id}',
                        ),
                        borderRadius: BorderRadius.circular(25),
                        onTap: () => cubit.changeTab(index),
                        child: TabCommunicationAndPoliciesWidget(
                          isSelected: cubit.currentIndex == index,
                          text: cubit.pages[index].localizedTitle(locale),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Align(
                  alignment: isArabic ? Alignment.topRight : Alignment.topLeft,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(8),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: isArabic
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          _LocalizedPageText(
                            text: selectedPage.localizedTitle(locale),
                            isArabic: isArabic,
                            textSize: 18,
                            fontWeightIndex: FontSelectionData.mediumFontFamily,
                          ),
                          const SizedBox(height: 20),
                          _LocalizedPageText(
                            text: selectedPage.localizedContent(locale),
                            isArabic: isArabic,
                            textSize: 14,
                            fontWeightIndex:
                                FontSelectionData.regularFontFamily,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LocalizedPageText extends StatelessWidget {
  const _LocalizedPageText({
    required this.text,
    required this.isArabic,
    required this.textSize,
    required this.fontWeightIndex,
  });

  final String text;
  final bool isArabic;
  final double textSize;
  final int fontWeightIndex;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
      child: Text(
        text,
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        style: TextStyle(
          color: AppColors.blackColor,
          fontFamily: fontSelection(),
          fontSize: textSize,
          fontWeight: fontWeightSelection(fontWeightIndex: fontWeightIndex),
        ),
      ),
    );
  }
}

class _PagesAboutError extends StatelessWidget {
  const _PagesAboutError({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextInAppWidget(
            text:
                message.isEmpty ? AppLanguageKeys.somethingWentWrong : message,
            textSize: 14,
            textColor: AppColors.redColor,
            isTextCenter: true,
          ),
          const SizedBox(height: 12),
          IconButton(
            tooltip:
                MaterialLocalizations.of(context).refreshIndicatorSemanticLabel,
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
