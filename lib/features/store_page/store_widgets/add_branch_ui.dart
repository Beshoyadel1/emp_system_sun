import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/api_functions/branch/get_provider_branches_model/provider_branch_model.dart';
import '../../../../../core/api_functions/branch/add_branch_model/add_branch_request.dart';
import '../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../features/store_page/logic/branch_cubit/branch_cubit.dart';
import '../../../../../features/store_page/logic/branch_cubit/branch_state.dart';
import '../../../../../features/store_page/model/location_cubit/location_cubit.dart';
import '../../../../../features/store_page/model/location_cubit/location_state.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/pages_widgets/text_form_field_widget.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/language/language_constant.dart';
import 'square_map_widget.dart';


class AddBranchUI extends StatefulWidget {
  const AddBranchUI({super.key});

  @override
  State<AddBranchUI> createState() => _AddBranchUIState();
}

class _AddBranchUIState extends State<AddBranchUI> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final latinController = TextEditingController();
  final addressTextController = TextEditingController();
  final addressLatinController = TextEditingController();
  final addressController = TextEditingController();

  bool isInit = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BranchCubit, BranchState>(
      listener: (context, state) {
        if (state is BranchSuccess && state.fromSubmit) {
          AppSnackBar.showSuccess(AppLanguageKeys.success);

          nameController.clear();
          latinController.clear();
          addressTextController.clear();
          addressLatinController.clear();
          addressController.clear();

          isInit = false;
        }

        if (state is BranchError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },

      builder: (context, state) {
        final isLoading = state is BranchLoading;
        final successState = state is BranchSuccess ? state : null;

        final editingId = successState?.editingBranchId;
        final branches = successState?.branches ?? [];

        ProviderBranchModel? branch;

        if (editingId != null) {
          branch = branches.firstWhere(
                (e) => e.branchId == editingId,
            orElse: () => ProviderBranchModel(),
          );
        }

        if (branch != null && editingId != null && !isInit) {
          nameController.text = branch.branchName ?? '';
          latinController.text = branch.branchLatinName ?? '';
          addressTextController.text = branch.addressText ?? '';
          addressLatinController.text = branch.addressLatinText ?? '';
          addressController.text = branch.address ?? '';

          isInit = true;
        }

        return Form(
          key: _formKey,
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextInAppWidget(
                text: editingId != null
                    ? AppLanguageKeys.editKey
                    : AppLanguageKeys.addMainBranchKey,
                textSize: 20,
              ),

              /// Branch Name
              TextFormFieldWidget(
                textFormController: nameController,
                text: AppLanguageKeys.branchName,
                hintText: AppLanguageKeys.branchName,
                isColumn: true,
                textSize: 16,
                textColor: AppColors.darkColor,
                borderColor: AppColors.darkGreyColor,
                fillColor: AppColors.whiteColor,
                textFormHeight: 35,
                validator: (value) =>
                value == null || value.isEmpty
                    ? AppLanguageKeys.enterYourData
                    : null,
              ),

              /// Latin Name
              TextFormFieldWidget(
                textFormController: latinController,
                text: AppLanguageKeys.branchLatinName,
                hintText: AppLanguageKeys.branchLatinName,
                isColumn: true,
                textSize: 16,
                textColor: AppColors.darkColor,
                borderColor: AppColors.darkGreyColor,
                fillColor: AppColors.whiteColor,
                textFormHeight: 35,
                validator: (value) =>
                value == null || value.isEmpty
                    ? AppLanguageKeys.enterYourData
                    : null,
              ),

              /// Address Text
              TextFormFieldWidget(
                textFormController: addressTextController,
                text: AppLanguageKeys.addressText,
                hintText: AppLanguageKeys.addressText,
                isColumn: true,
                textSize: 16,
                textColor: AppColors.darkColor,
                borderColor: AppColors.darkGreyColor,
                fillColor: AppColors.whiteColor,
                textFormHeight: 35,
                validator: (value) =>
                value == null || value.isEmpty
                    ? AppLanguageKeys.enterYourData
                    : null,
              ),

              /// Address Latin
              TextFormFieldWidget(
                textFormController: addressLatinController,
                text: AppLanguageKeys.addressLatinText,
                hintText: AppLanguageKeys.addressLatinText,
                isColumn: true,
                textSize: 16,
                textColor: AppColors.darkColor,
                borderColor: AppColors.darkGreyColor,
                fillColor: AppColors.whiteColor,
                textFormHeight: 35,
                validator: (value) =>
                value == null || value.isEmpty
                    ? AppLanguageKeys.enterYourData
                    : null,
              ),

              /// Address
              TextFormFieldWidget(
                textFormController: addressController,
                text: AppLanguageKeys.branchAddressKey,
                isColumn: true,
                textColor: AppColors.darkGreyColor,
                fillColor: AppColors.whiteColor,
                textSize: 16,
                hintText: AppLanguageKeys.addressDetailsKey,
                textFormHeight: 35,
                borderColor: AppColors.lightGreyColor,
                validator: (value) =>
                value == null || value.isEmpty
                    ? AppLanguageKeys.enterYourData
                    : null,
                onChanged: (value) {
                  if (value.trim().isNotEmpty) {
                    context
                        .read<LocationCubit>()
                        .searchLocation(value.trim());
                  }
                },
              ),

              const TextInAppWidget(
                text: AppLanguageKeys.confirmBranchLocationKey,
                textSize: 18,
              ),

              SizedBox(
                height: 370,
                width: 408,
                child: SquareMapWidget(),
              ),

              /// Buttons
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  CustomContainer(
                    isSelected: false,
                    onTap: isLoading
                        ? null
                        : () {
                      if (!_formKey.currentState!.validate()) {
                        AppSnackBar.showError(
                            AppLanguageKeys.enterYourData);
                        return;
                      }

                      final locationState =
                          context.read<LocationCubit>().state;

                      if (locationState is! LocationLoaded) {
                        AppSnackBar.showError(
                            AppLanguageKeys.enterYourData);
                        return;
                      }

                      /// ✅ EDIT
                      if (editingId != null && branch != null) {
                        final request = AddBranchRequest(
                          branchId: branch.branchId,
                          branchName: nameController.text,
                          branchLatinName: latinController.text,
                          address:
                          "${locationState.latLng.latitude},${locationState.latLng.longitude}",
                          addressText:
                          addressTextController.text,
                          addressLatinText:
                          addressLatinController.text,
                          isActive: branch.isActive ?? true,
                        );

                        context
                            .read<BranchCubit>()
                            .updateBranch(request);
                      }

                      /// ✅ ADD
                      else {
                        final request = AddBranchRequest(
                          branchName: nameController.text,
                          branchLatinName: latinController.text,
                          address:
                          "${locationState.latLng.latitude},${locationState.latLng.longitude}",
                          addressText:
                          addressTextController.text,
                          addressLatinText:
                          addressLatinController.text,
                          isActive: true,
                        );

                        context
                            .read<BranchCubit>()
                            .addBranch(request);
                      }
                    },
                    typeWidget: isLoading
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                        : TextInAppWidget(
                      text: editingId != null
                          ? AppLanguageKeys.editKey
                          : AppLanguageKeys.saveKey,
                      textSize: 16,
                      textColor: AppColors.whiteColor,
                    ),
                    containerColor: AppColors.orangeColor,
                  ),

                  CustomContainer(
                    isSelected: false,
                    onTap: () {
                      isInit = false;
                      context.read<BranchCubit>().back();
                    },
                    text: AppLanguageKeys.cancel,
                    containerColor: AppColors.blackColor,
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}