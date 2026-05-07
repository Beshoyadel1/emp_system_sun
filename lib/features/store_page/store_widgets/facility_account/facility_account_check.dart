import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/pages_widgets/general_widgets/navigate_to_page_widget.dart';
import '../../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../../features/auth_page/auth_cubit/auth_cubit.dart';
import '../../../../../../features/auth_page/auth_cubit/auth_state.dart';
import '../../../../../../features/auth_page/login_page/login_page.dart';
import '../../../../../../features/store_page/store_page.dart';
import '../../../../../../features/store_page/store_widgets/car_model_widget/widgets/tabs_widget.dart';
import '../../../../../../features/store_page/store_widgets/navigator_button.dart';
import '../../../../../../../features/store_page/model/facility_model/facility_model.dart';
import '../../../../../../../features/store_page/model/facility_cubit/facility_tab_cubit/facility_tab_cubit.dart';
import '../../../../../../../features/store_page/model/facility_cubit/facility_tab_cubit/facility_tab_state.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/fonts.dart';
import '../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../core/theming/text_styles.dart';
import '../../../../../../core/language/language_constant.dart';

class FacilityAccountCheck extends StatelessWidget {
  const FacilityAccountCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: BlocProvider(
        create: (context) => FacilityTabCubit(),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthIncompleteProfile) {
              AppSnackBar.showError(
                state.missing.first,
              );
            }

            if (state is AuthUpdateError) {
              AppSnackBar.showError(state.error);
            }
          },
          builder: (context, authState) {
            return BlocBuilder<FacilityTabCubit, FacilityTabState>(
              buildWhen: (previous, current) =>
              current is ChangeIndexState,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomContainer(
                          containerWidth: double.infinity,
                          isSelected: false,
                          border: const Border(
                            top: BorderSide(color: AppColors.lightGreyColor),
                            left: BorderSide(color: AppColors.lightGreyColor),
                            right: BorderSide(color: AppColors.lightGreyColor),
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          typeWidget: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextInAppWidget(
                                text: AppLanguageKeys.continueFacilityDataKey,
                                textSize: 22,
                                fontWeightIndex:
                                FontSelectionData.mediumFontFamily,
                              ),
                              const SizedBox(height: 10),
                              const TabsWidget(),
                              const SizedBox(height: 30),

                              facilityTabs[
                              context
                                  .read<FacilityTabCubit>()
                                  .selectedIndex]
                                  .content,

                              const SizedBox(height: 40),

                              Row(
                                children: [
                                  Expanded(
                                    child: CustomContainer(
                                      isSelected: false,
                                      onTap: () {
                                        print("🔘 CHECK BUTTON CLICKED");
                                          context.read<AuthCubit>().reCheckFacility();
                                      },
                                      containerColor:
                                      AppColors.orangeColor,
                                      containerHeight: 45,
                                      typeWidget: const Center(
                                        child: TextInAppWidget(
                                          text: AppLanguageKeys.next,
                                          textSize: 16,
                                          textColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  Expanded(
                                    child: CustomContainer(
                                      isSelected: false,
                                      onTap: () {
                                        print("🚪 LOGOUT CLICKED");

                                        context
                                            .read<AuthCubit>()
                                            .logout();
                                      },
                                      containerColor:
                                      AppColors.redColor,
                                      containerHeight: 45,
                                      typeWidget: const Center(
                                        child: TextInAppWidget(
                                          text: AppLanguageKeys.logout,
                                          textSize: 16,
                                          textColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 40),
                            ],
                          ),
                          onTap: () {},
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}