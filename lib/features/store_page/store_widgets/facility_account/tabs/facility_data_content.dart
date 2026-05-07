import 'dart:convert';

import 'package:emp_system_sun/core/api_functions/user/create_user_model/employee_details_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../../features/auth_page/login_page/login_widgets/user_text_field_widget.dart';
import '../../../../../../features/internal_services/internal_orders/first_screen_internal_orders/logic/order_funcations/order_functions.dart';
import '../../../../../../core/api_functions/user/create_user_model/create_user_request.dart';
import '../../../../../../core/api_functions/user/create_user_model/provider_details_request.dart';
import '../../../../../../core/api_functions/user/login_model/login_repository.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/text_styles.dart';
import '../../../../../../features/auth_page/auth_cubit/auth_cubit.dart';
import '../../../../../../features/auth_page/auth_cubit/auth_state.dart';
import '../../../../../../features/store_page/model/facility_cubit/facility_tab_cubit/facility_tab_cubit.dart';
import '../../general_widgets_in_store/attach_file.dart';

class FacilityDataContent extends StatefulWidget {
  const FacilityDataContent({super.key});

  @override
  State<FacilityDataContent> createState() => _FacilityDataContentState();
}

class _FacilityDataContentState extends State<FacilityDataContent> {
  final facilityNameController = TextEditingController();
  final facilityNameEnController = TextEditingController();
  final vatNoController = TextEditingController();
  final crController = TextEditingController();
  final nationalAddressController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();
  final ageController = TextEditingController();
  final dateController = TextEditingController();

  bool isEditMode = false;
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isLoaded) {
      _loadUser();
      isLoaded = true;
    }
  }

  T? safe<T>(T? value) {
    if (value == null) return null;
    if (value is String && value.trim().isEmpty) return null;
    return value;
  }

  Future<void> _loadUser() async {
    final user = await AuthLocalStorage.getUser();

    if (user != null) {
      facilityNameController.text = user.providerDetails?.name ?? "";
      facilityNameEnController.text = user.providerDetails?.latinname ?? "";

      crController.text = user.providerDetails?.cr ?? "";
      vatNoController.text = user.providerDetails?.vatno ?? "";

      nationalAddressController.text =
          user.providerDetails?.nationaladdress ?? "";
      phoneController.text = user.phone ?? "";
      emailController.text = user.email ?? "";
      ageController.text = user.age?.toString() ?? "";
      genderController.text = user.gander?.toString() ?? "";
      dateController.text =
          OrderFunctions.formatDateFromDateTime(user.joinDate);

      setState(() {});
    }
  }
  void _onUpdate() async {

    final user = await AuthLocalStorage.getUser();

    final facilityCubit = context.read<FacilityTabCubit>();

    final oldProvider = user?.providerDetails;

    final oldEmployee = user?.employeeDetails;

    final request = CreateUserRequest(

      userid: user?.userid ?? 0,

      username: user?.username,

      type: user?.type,

      phone: safe(phoneController.text),

      email: safe(emailController.text),

      age: ageController.text.isNotEmpty
          ? int.tryParse(ageController.text)
          : null,

      gander: genderController.text.isNotEmpty
          ? int.tryParse(genderController.text)
          : null,

      image:
      facilityCubit.images['image'] ??
          user?.image,

      providerDetails: ProviderDetailsRequest(

        id: oldProvider?.id,

        provid: oldProvider?.provid,

        name:
        safe(facilityNameController.text),

        latinname:
        safe(facilityNameEnController.text),

        cr:
        safe(crController.text),

        vatno:
        safe(vatNoController.text),

        nationaladdress:
        safe(nationalAddressController.text),

        crimage:
        facilityCubit.images['crimage'] ??
            oldProvider?.crimage,

        vatnoimage:
        facilityCubit.images['vatnoimage'] ??
            oldProvider?.vatnoimage,
      ),

      employeeDetails: EmployeeDetailsRequest(
        id: oldEmployee?.id,
        provid: oldEmployee?.provid,
      ),
    );

    debugPrint("========== REQUEST ==========");
    debugPrint(jsonEncode(request.toJson()));

    context.read<AuthCubit>().updateUser(request);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            UserTextFieldWidget(
              controller: facilityNameController,
              text: AppLanguageKeys.facilityName,
              type: UserFieldType.name,
              readOnly: !isEditMode,
              width: 250,
            ),
            UserTextFieldWidget(
              controller: facilityNameEnController,
              text: AppLanguageKeys.facilityNameEn,
              type: UserFieldType.name,
              readOnly: !isEditMode,
              width: 250,
            ),
            UserTextFieldWidget(
              controller: crController,
              text: AppLanguageKeys.commercialRecordKey,
              readOnly: !isEditMode,
              width: 250,
            ),
            UserTextFieldWidget(
              controller: vatNoController,
              text: AppLanguageKeys.taxNumber,
              readOnly: !isEditMode,
              width: 250,
            ),
            UserTextFieldWidget(
              controller: nationalAddressController,
              text: AppLanguageKeys.shortAddress,
              readOnly: !isEditMode,
              width: 250,
            ),
            UserTextFieldWidget(
              controller: phoneController,
              text: AppLanguageKeys.phoneNumber,
              type: UserFieldType.phone,
              readOnly: !isEditMode,
              width: 250,
            ),
            UserTextFieldWidget(
              controller: emailController,
              text: AppLanguageKeys.email,
              type: UserFieldType.email,
              readOnly: !isEditMode,
              width: 250,
            ),
            UserTextFieldWidget(
              controller: ageController,
              text: AppLanguageKeys.age,
              readOnly: !isEditMode,
              width: 250,
            ),
            UserTextFieldWidget(
              controller: dateController,
              text: AppLanguageKeys.joiningDate,
              readOnly: true,
              width: 250,
            ),
            UserTextFieldWidget(
              controller: genderController,
              text: AppLanguageKeys.gender,
              type: UserFieldType.gender,
              readOnly: !isEditMode,
              width: 250,
            ),
          ],
        ),

        const SizedBox(height: 20),

        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            // AttachImage(
            //   title: AppLanguageKeys.commercialRecordKey,
            //   type: 'crimage',
            //   isEditMode: isEditMode,
            // ),
            // AttachImage(
            //   title: AppLanguageKeys.taxNumber,
            //   type: 'vatnoimage',
            //   isEditMode: isEditMode,
            // ),
            AttachImage(
              title: AppLanguageKeys.ownerIdKey,
              type: 'image',
              isEditMode: isEditMode,
            ),
          ],
        ),

        const SizedBox(height: 20),

        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthUpdateSuccess) {
              setState(() => isEditMode = false);

              _loadUser();

              AppSnackBar.showSuccess(AppLanguageKeys.success);
            }

            if (state is AuthUpdateError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthUpdateLoading;

            return Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orangeColor,
                  ),
                  onPressed: isLoading
                      ? null
                      : () {
                          if (!isEditMode) {
                            setState(() => isEditMode = true);
                          } else {
                            _onUpdate();
                          }
                        },
                  child: isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : TextInAppWidget(
                          text: isEditMode
                              ? AppLanguageKeys.save
                              : AppLanguageKeys.edit,
                          textColor: AppColors.whiteColor,
                          textSize: 13,
                        ),
                ),
                const SizedBox(width: 10),
                if (isEditMode)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orangeColor,
                    ),
                    onPressed: () {
                      setState(() => isEditMode = false);
                      _loadUser();
                    },
                    child: const TextInAppWidget(
                      text: AppLanguageKeys.cancel,
                      textSize: 13,
                      textColor: AppColors.whiteColor,
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
