import 'package:emp_system_sun/features/cars_haraj_page/presentation/custom_widget/button_edit_delete_setting_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../../core/language/language_cubit/language_cubit.dart';
import '../../../../../../../../../core/pages_widgets/general_widgets/show_delete_confirmation_dialog_in_app.dart';
import '../../../../../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../../../../../features/cars_haraj_page/data/model/get_all_harage_model/harage_data.dart';
import '../../../../../../../../../features/cars_haraj_page/presentation/ui/cars_haraj_statistics_page/screens/create_harag_dialog.dart';
import '../../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../../core/theming/fonts.dart';
import '../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../features/cars_haraj_page/data/model/get_car_details_model/get_car_details_model.dart';
import '../../../../../../../features/cars_haraj_page/presentation/bloc/harag_cubit/harag_cubit.dart';
import '../../../../../../../features/cars_haraj_page/presentation/bloc/harag_cubit/harag_state.dart';
import '../../custom_widget/widget_design_chats_harag.dart';
import '../../custom_widget/widget_design_description_harag.dart';
import '../../custom_widget/widget_design_details_data_harag_car.dart';
import '../../custom_widget/widget_design_fuel_consumption_car.dart';
import '../../custom_widget/widget_design_images_harag.dart';
import '../../custom_widget/widget_design_recent_invoices_car.dart';
import '../../custom_widget/widget_design_service_stats_Car.dart';
import '../../../../../../../features/internal_services/presentation/pages/internal_orders/custom_widget/text_empty_view_data.dart';
import '../../../../../../../core/language/language_constant.dart';

class ListViewPageDetailsHarag extends StatelessWidget {
  final int harageId;

  const ListViewPageDetailsHarag({
    super.key,
    required this.harageId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HaragCubit, HaragState>(
      builder: (context, state) {
        final cubit = context.read<HaragCubit>();

        // ==========================================================
        // LOADING
        // ==========================================================

        if (state is HaragDetailsLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: CircularProgressIndicator(),
            ),
          );
        }

        // ==========================================================
        // ERROR
        // ==========================================================

        if (state is HaragDetailsError) {
          return Center(
            child: Text(
              state.message,
            ),
          );
        }

        // ==========================================================
        // GET HARAG DATA
        // ==========================================================

        final harage = cubit.harageDetailsResponse?.data;

        if (harage == null) {
          return const Center(
            child: TextEmptyViewData(),
          );
        }

        // ==========================================================
        // GET CAR DETAILS
        // ==========================================================

        final GetCarDetailsModel? carDetails =
            cubit.carDetailsResponse;

        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            if (width >= 1000) {
              return _buildDesktop(
                context,
                harage,
                carDetails,
              );
            }

            return _buildMobile(
              context,
              harage,
              carDetails,
            );
          },
        );
      },
    );
  }

  // ==============================================================
  // DESKTOP
  // ==============================================================

  Widget _buildDesktop(
      BuildContext context,
      HarageData harage,
      GetCarDetailsModel? carDetails,
      ) {
    final isArabic =
        LanguageCubit.get(context).isAllAppLanguageArabic;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ==========================================================
        // EDIT / DELETE
        // ==========================================================

        Align(
          alignment: isArabic
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: isArabic
                ? WrapAlignment.start
                : WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ButtonEditDeleteSettingWidget(
                onTap: () async {
                  final haragCubit =
                  context.read<HaragCubit>();

                  final result = await showDialog<bool>(
                    context: context,
                    builder: (_) => BlocProvider.value(
                      value: haragCubit,
                      child: CreateHaragDialog(
                        car: harage,
                      ),
                    ),
                  );

                  if (result == true && context.mounted) {
                    await haragCubit.getHarageDetails(
                      harageId: harage.id!,
                    );
                  }
                },
              ),

              ButtonEditDeleteSettingWidget(
                isDelete: true,
                onTap: () async {
                  final haragCubit = context.read<HaragCubit>();

                  final confirmed =
                  await showDeleteConfirmationDialogInApp(context);

                  if (confirmed != true || !context.mounted) {
                    return;
                  }

                  await haragCubit.deleteHarage(
                    harageId: harage.id!,
                  );

                  if (context.mounted) {
                    AppSnackBar.showSuccess(AppLanguageKeys.success);
                    Navigator.pop(context, true);
                  }
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 15),

        // ==========================================================
        // HARAG DETAILS + CHAT
        // ==========================================================

        CustomContainer(
          isSelected: false,
          onTap: () {},
          typeWidget: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    WidgetDesignDetailsDataHaragCar(
                      harage: harage,
                    ),

                    const SizedBox(height: 20),

                    WidgetDesignDescriptionHarag(
                      harage: harage,
                    ),

                    const SizedBox(height: 15),

                    WidgetDesignImagesHarag(
                      harage: harage,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 20),

              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 550,
                  child: WidgetDesignChatsHarag(
                    harage: harage,
                  ),
                ),
              ),
            ],
          ),
        ),

        if (carDetails != null) ...[
          const SizedBox(height: 35),

          _buildCarServicesSection(
            context,
            carDetails,
          ),
        ],
      ],
    );
  }

  // ==============================================================
  // CAR SERVICES
  // ==============================================================

  Widget _buildCarServicesSection(
      BuildContext context,
      GetCarDetailsModel carDetails,
      ) {
    return CustomContainer(
      isSelected: false,
     onTap: (){},
     typeWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const TextInAppWidget(
            text: AppLanguageKeys.previousOrdersAndMaintenance,
            textSize: 20,
            fontWeightIndex: FontSelectionData.boldFontFamily,
            textAlign: TextAlign.right,
          ),

          const SizedBox(
            height: 25,
          ),

          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              if (width < 850) {
                return Column(
                  children: [
                    WidgetDesignFuelConsumptionCar(
                      fuelConsumption:
                      carDetails.fuelConsumption,
                      summary: carDetails.summary,
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    WidgetDesignServiceStatsCar(
                      serviceStats:
                      carDetails.serviceStats,
                      summary:
                      carDetails.summary,
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    WidgetDesignRecentInvoicesCar(
                      invoices:
                      carDetails.recentInvoices,
                    ),
                  ],
                );
              }

              return Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: WidgetDesignRecentInvoicesCar(
                      invoices:
                      carDetails.recentInvoices,
                    ),
                  ),

                  const SizedBox(
                    width: 20,
                  ),

                  Expanded(
                    child: WidgetDesignServiceStatsCar(
                      serviceStats:
                      carDetails.serviceStats,
                      summary:
                      carDetails.summary,
                    ),
                  ),

                  const SizedBox(
                    width: 20,
                  ),

                  Expanded(
                    child: WidgetDesignFuelConsumptionCar(
                      fuelConsumption:
                      carDetails.fuelConsumption,
                      summary:
                      carDetails.summary,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // MOBILE / TABLET
  // ==============================================================

  Widget _buildMobile(
      BuildContext context,
      HarageData harage,
      GetCarDetailsModel? carDetails,
      ) {
    final isArabic =
        LanguageCubit.get(context).isAllAppLanguageArabic;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: isArabic
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: isArabic
                ? WrapAlignment.start
                : WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ButtonEditDeleteSettingWidget(
                onTap: () async {
                  final haragCubit =
                  context.read<HaragCubit>();

                  final result = await showDialog<bool>(
                    context: context,
                    builder: (_) => BlocProvider.value(
                      value: haragCubit,
                      child: CreateHaragDialog(
                        car: harage,
                      ),
                    ),
                  );

                  if (result == true && context.mounted) {
                    await haragCubit.getHarageDetails(
                      harageId: harage.id!,
                    );
                  }
                },
              ),

              ButtonEditDeleteSettingWidget(
                isDelete: true,
                onTap: () async {
                  final haragCubit = context.read<HaragCubit>();

                  final confirmed =
                  await showDeleteConfirmationDialogInApp(context);

                  if (confirmed != true || !context.mounted) {
                    return;
                  }

                  await haragCubit.deleteHarage(
                    harageId: harage.id!,
                  );

                  if (context.mounted) {
                    AppSnackBar.showSuccess(AppLanguageKeys.success);
                    Navigator.pop(context, true);
                  }
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 15),

        WidgetDesignDetailsDataHaragCar(
          harage: harage,
        ),

        const SizedBox(height: 15),

        WidgetDesignDescriptionHarag(
          harage: harage,
        ),

        const SizedBox(height: 15),

        WidgetDesignImagesHarag(
          harage: harage,
        ),

        const SizedBox(height: 15),

        SizedBox(
          height: 450,
          child: WidgetDesignChatsHarag(
            harage: harage,
          ),
        ),

        if (carDetails != null) ...[
          const SizedBox(height: 25),

          _buildCarServicesSection(
            context,
            carDetails,
          ),
        ],
      ],
    );
  }
}