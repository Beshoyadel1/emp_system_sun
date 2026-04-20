import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../features/cars_haraj_page/logic/update_harage_cubit/update_harage_state.dart';
import '../../../../../core/api_functions/harage/get_all_harage_model/harage_data.dart';
import '../../../../../core/api_functions/harage/update_harage_model/update_harage_request.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/pages_widgets/text_form_field_widget.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../features/cars_haraj_page/logic/update_harage_cubit/update_harage_cubit.dart';

class EditHaragDialog extends StatefulWidget {
  final HarageData car;

  const EditHaragDialog({super.key, required this.car});

  @override
  State<EditHaragDialog> createState() => _EditHaragDialogState();
}

class _EditHaragDialogState extends State<EditHaragDialog> {
  final _formKey = GlobalKey<FormState>();

  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final kilometersController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();

    /// 🔹 Prefill data
    descriptionController.text = widget.car.description ?? "";
    priceController.text = widget.car.price?.toString() ?? "";
    kilometersController.text = widget.car.kilometers?.toString() ?? "";
    addressController.text = widget.car.addressText ?? "";
  }

  @override
  void dispose() {
    descriptionController.dispose();
    priceController.dispose();
    kilometersController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateHarageCubit, UpdateHarageState>(
      listener: (context, state) {
        if (state is UpdateHarageSuccess) {
          Navigator.pop(context);
          Navigator.pop(context, true);
        }
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        title: Column(
          children: [
            const TextInAppWidget(
              text: AppLanguageKeys.edit,
              textSize: 20,
              fontWeightIndex: FontSelectionData.boldFontFamily,
              textColor: AppColors.orangeColor,
              isTextCenter: true,
            ),
            const SizedBox(height: 8),
            Divider(color: AppColors.darkColor.withOpacity(0.1)),
          ],
        ),

        content: SizedBox(
          width: 480,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title(AppLanguageKeys.description),
                  TextFormFieldWidget(
                    textFormController: descriptionController,
                    isValidator: true,
                  ),

                  const SizedBox(height: 14),

                  _title(AppLanguageKeys.address),
                  TextFormFieldWidget(
                    textFormController: addressController,
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _title(AppLanguageKeys.price),
                            TextFormFieldWidget(
                              textFormController: priceController,
                              isDigitDot: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _title(AppLanguageKeys.mileage),
                            TextFormFieldWidget(
                              textFormController: kilometersController,
                              isDigitDot: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const TextInAppWidget(
              text: AppLanguageKeys.cancel,
              textSize: 14,
            ),
          ),

          BlocBuilder<UpdateHarageCubit, UpdateHarageState>(
            builder: (context, state) {
              final isLoading = state is UpdateHarageLoading;

              return ElevatedButton(
                onPressed: isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orangeColor,
                ),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const TextInAppWidget(
                  textSize: 14,
                  text: AppLanguageKeys.edit,
                  textColor: AppColors.whiteColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _title(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: TextInAppWidget(
        text: text,
        textSize: 13,
        textColor: AppColors.darkColor.withOpacity(0.6),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<UpdateHarageCubit>().updateHarage(
      request: UpdateHarageRequest(
        id: widget.car.id,
        description: descriptionController.text,
        addressText: addressController.text,
        price: double.tryParse(priceController.text),
        kilometers: int.tryParse(kilometersController.text),
      ),
    );
  }
}