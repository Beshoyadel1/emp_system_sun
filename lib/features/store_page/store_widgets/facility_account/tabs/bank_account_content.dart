import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../../core/pages_widgets/text_form_field_widget.dart';
import '../../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../../core/api_functions/user/create_user_model/create_user_request.dart';
import '../../../../../../core/api_functions/user/create_user_model/provider_details_request.dart';
import '../../../../../../core/api_functions/user/login_model/login_repository.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/text_styles.dart';

import '../../../../../../features/auth_page/auth_cubit/auth_cubit.dart';
import '../../../../../../features/auth_page/auth_cubit/auth_state.dart';


class BankAccountContent extends StatefulWidget {
  const BankAccountContent({super.key});

  @override
  State<BankAccountContent> createState() => _BankAccountContentState();
}

class _BankAccountContentState extends State<BankAccountContent> {
  final beneficiaryController = TextEditingController();
  final ibanController = TextEditingController();

  bool isEditMode = false;
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isLoaded) {
      _loadData();
      isLoaded = true;
    }
  }

  /// ================= LOAD DATA =================
  Future<void> _loadData() async {
    final user = await AuthLocalStorage.getUser();

    if (user != null) {
      beneficiaryController.text =
          user.providerDetails?.name ?? "";

      ibanController.text =
          user.providerDetails?.iban ?? "";

      setState(() {});
    }
  }


  Future<void> _onUpdate() async {
    final user = await AuthLocalStorage.getUser();

    final oldProvider = user?.providerDetails;

    final request = CreateUserRequest(
      userid: user?.userid,
      type: user?.type,
      username: user?.username,
      phone: user?.phone,
      email: user?.email,
      age: user?.age,
      gander: user?.gander,
      image: user?.image,
      providerDetails: ProviderDetailsRequest(
        id: oldProvider?.id,
        provid: oldProvider?.provid,

        name: beneficiaryController.text,
        iban: ibanController.text,

        latinname: oldProvider?.latinname,
        description: oldProvider?.description,
        latindesc: oldProvider?.latindesc,
        cr: oldProvider?.cr,
        vatno: oldProvider?.vatno,
        packageid: oldProvider?.packageid,
        nationaladdress: oldProvider?.nationaladdress,
        subscriptionstartdate: oldProvider?.subscriptionstartdate,
        subscriptionenddate: oldProvider?.subscriptionenddate,
      ),
    );

    context.read<AuthCubit>().updateUser(request);
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile =
        MediaQuery.of(context).size.width < ValuesOfAllApp.mobileWidth;

    return Column(
      spacing: 20,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            SizedBox(
              width: isMobile ? double.infinity : 280,
              child: TextFormFieldWidget(
                textFormController: beneficiaryController,
                text: AppLanguageKeys.beneficiaryNameKey,
                textSize: 16,
                isColumn: true,
                readOnly: !isEditMode,
                textColor: AppColors.darkColor,
                borderColor: AppColors.darkGreyColor,
                fillColor: AppColors.whiteColor,
                textFormHeight: 35,
              ),
            ),
            SizedBox(
              width: isMobile ? double.infinity : 280,
              child: TextFormFieldWidget(
                textFormController: ibanController,
                text: AppLanguageKeys.ibanNumberKey,
                textSize: 16,
                isColumn: true,
                readOnly: !isEditMode,
                textColor: AppColors.darkColor,
                borderColor: AppColors.darkGreyColor,
                fillColor: AppColors.whiteColor,
                textFormHeight: 35,
              ),
            ),
          ],
        ),

        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthUpdateSuccess) {
              setState(() => isEditMode = false);
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
                    text: isEditMode ? AppLanguageKeys.save : AppLanguageKeys.edit,
                    textSize: 13,
                    textColor: AppColors.whiteColor,
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
                      _loadData();
                    },
                    child: const TextInAppWidget(
                      text:  AppLanguageKeys.cancel,
                      textColor: AppColors.whiteColor,
                      textSize: 13,
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
