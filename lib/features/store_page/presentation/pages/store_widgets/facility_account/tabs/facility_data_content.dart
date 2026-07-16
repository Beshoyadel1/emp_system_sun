import 'dart:convert';

import 'package:emp_system_sun/core/theming/auth_local_storage.dart';
import 'package:emp_system_sun/features/auth_page/data/datasource/login_datasource/login_repository.dart';
import 'package:emp_system_sun/features/auth_page/data/model/create_user_model/create_user_request.dart';
import 'package:emp_system_sun/features/auth_page/data/model/create_user_model/employee_details_request.dart';
import 'package:emp_system_sun/features/auth_page/data/model/create_user_model/employee_wrapper_request.dart';
import 'package:emp_system_sun/features/auth_page/data/model/create_user_model/provider_details_request.dart';
import 'package:emp_system_sun/features/auth_page/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:emp_system_sun/features/auth_page/presentation/bloc/auth_cubit/auth_state.dart';
import 'package:emp_system_sun/features/auth_page/presentation/pages/login_page/login_widgets/user_text_field_widget.dart';
import 'package:emp_system_sun/features/internal_services/presentation/cubit/order_funcations/order_functions.dart';
import 'package:emp_system_sun/features/store_page/presentation/bloc/facility_cubit/facility_tab_cubit/facility_tab_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emp_system_sun/core/pages_widgets/general_widgets/snakbar.dart';
import 'package:emp_system_sun/core/language/language_constant.dart';
import 'package:emp_system_sun/core/theming/colors.dart';
import 'package:emp_system_sun/core/theming/text_styles.dart';
import '../../general_widgets_in_store/attach_file.dart';

class FacilityDataContent extends StatefulWidget {
  const FacilityDataContent({super.key});

  @override
  State<FacilityDataContent> createState() => _FacilityDataContentState();
}

class _FacilityDataContentState extends State<FacilityDataContent> {
  final jobNameController = TextEditingController();
  final jobLatinNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();
  final ageController = TextEditingController();
  final dateController = TextEditingController();
  final idController = TextEditingController();

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
      jobNameController.text = user.employeeDetails?.employeeDetails?.jobname ?? "";
      jobLatinNameController.text = user.employeeDetails?.employeeDetails?.joblatinname ?? "";
      phoneController.text = user.phone ?? "";
      emailController.text = user.email ?? "";
      ageController.text = user.age?.toString() ?? "";
      genderController.text = user.gander?.toString() ?? "";
      dateController.text = OrderFunctions.formatDateFromDateTime(user.joinDate);
      idController.text=user.userid.toString();
      setState(() {});
    }
  }
  void _onUpdate() async {

    final user = await AuthLocalStorage.getUser();
    final facilityCubit =
    context.read<FacilityTabCubit>();

    final oldEmployee =
        user?.employeeDetails?.employeeDetails;

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

      employeeDetails: EmployeeWrapperRequest(

        employeeDetails:
        EmployeeDetailsRequest(

          id: oldEmployee?.id,

          provid: oldEmployee?.provid,

          jobname: safe(jobNameController.text),

          joblatinname:
          safe(jobLatinNameController.text),

          branchid:
          oldEmployee?.branchid,
        ),
        serviceIds:
        user?.employeeDetails
            ?.serviceIds ??
            [],
      ),
    );

    // debugPrint(
    //     "========== REQUEST ==========");

    // debugPrint(
    //     jsonEncode(request.toJson()));

    context
        .read<AuthCubit>()
        .updateUser(request);
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
              controller: idController,
              text: AppLanguageKeys.identity,
              type: UserFieldType.name,
              readOnly:true,
              width: 250,
            ),
            UserTextFieldWidget(
              controller: jobNameController,
              text: AppLanguageKeys.jobName,
              type: UserFieldType.name,
              readOnly: !isEditMode,
              width: 250,
            ),
            UserTextFieldWidget(
              controller: jobLatinNameController,
              text: AppLanguageKeys.jobLatinName,
              type: UserFieldType.name,
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

              print("✅ UPDATE SUCCESS");

              setState(() => isEditMode = false);

              _loadUser();

              AppSnackBar.showSuccess(
                AppLanguageKeys.success,
              );
            }

            if (state is AuthUpdateError) {

              print("❌ UPDATE ERROR => ${state.error}");

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
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
