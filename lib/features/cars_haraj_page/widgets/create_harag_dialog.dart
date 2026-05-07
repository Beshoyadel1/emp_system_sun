import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/api_functions/harage/update_harage_model/update_harage_request.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/pages_widgets/text_form_field_widget.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../features/cars_haraj_page/logic/update_harage_cubit/update_harage_cubit.dart';
import '../../../../../features/cars_haraj_page/logic/update_harage_cubit/update_harage_state.dart';

class CreateHaragDialog extends StatefulWidget {
  const CreateHaragDialog({super.key});

  @override
  State<CreateHaragDialog> createState() => _CreateHaragDialogState();
}

class _CreateHaragDialogState extends State<CreateHaragDialog> {
  final _formKey = GlobalKey<FormState>();

  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final costController = TextEditingController();
  final kilometersController = TextEditingController();
  final addressController = TextEditingController();

  final releaseDateController = TextEditingController();
  final transmissionTypeController = TextEditingController();
  final fuelTypeController = TextEditingController();

  bool isNew = false;
  bool isSold = false;

  @override
  void dispose() {
    descriptionController.dispose();
    priceController.dispose();
    costController.dispose();
    kilometersController.dispose();
    addressController.dispose();
    releaseDateController.dispose();
    transmissionTypeController.dispose();
    fuelTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateHarageCubit, UpdateHarageState>(
      listener: (context, state) {
        if (state is UpdateHarageSuccess) {
          Navigator.pop(context, true);
        }
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: const TextInAppWidget(
          text: AppLanguageKeys.create,
          textSize: 20,
          textColor: AppColors.orangeColor,
          isTextCenter: true,
        ),
        content: SizedBox(
          width: 480,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 15,
                children: [
                  _field(AppLanguageKeys.description, descriptionController),
                  _field(AppLanguageKeys.address, addressController),

                  Row(
                    spacing: 5,
                    children: [
                      Expanded(child: _field(AppLanguageKeys.price, priceController, isDouble: true)),
                      Expanded(child: _field(AppLanguageKeys.cost, costController, isDouble: true)),
                    ],
                  ),

                  _field(AppLanguageKeys.mileage, kilometersController, isInt: true),

                  _switch(AppLanguageKeys.isNew, isNew, (v) => setState(() => isNew = v)),
                  _switch(AppLanguageKeys.isSold, isSold, (v) => setState(() => isSold = v)),

                  _field(AppLanguageKeys.releaseDate, releaseDateController),
                  _field(AppLanguageKeys.transmissionType, transmissionTypeController, isInt: true),
                  _field(AppLanguageKeys.fuelType, fuelTypeController, isInt: true),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const TextInAppWidget(text: AppLanguageKeys.cancel,textSize: 15,),
          ),
          BlocBuilder<UpdateHarageCubit, UpdateHarageState>(
            builder: (context, state) {
              final isLoading = state is UpdateHarageLoading;

              return ElevatedButton(
                onPressed: isLoading ? null : _submit,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const TextInAppWidget(text: AppLanguageKeys.create,textSize: 15,),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _field(String title, TextEditingController controller,
      {bool isDouble = false, bool isInt = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(title),
        TextFormFieldWidget(
          textFormController: controller,
          isDigitDot: isDouble,
          isDigit: isInt,
          fillColor: AppColors.transparent,
          borderColor: AppColors.darkColor.withOpacity(0.2),
          hintTextSize: 12,
          hintTextColor: AppColors.orangeColor,
          textSize: 15,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _switch(String title, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _title(title),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }

  Widget _title(String text) {
    return TextInAppWidget(
      text: text,
      textSize: 13,
      textColor: AppColors.darkColor.withOpacity(0.6),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<UpdateHarageCubit>().createHarage(
      request: UpdateHarageRequest(
        description: descriptionController.text,
        addressText: addressController.text,
        price: double.tryParse(priceController.text),
        cost: double.tryParse(costController.text),
        kilometers: int.tryParse(kilometersController.text),
        isNew: isNew,
        isSold: isSold,
        releaseDate: releaseDateController.text,
        transmissionType: int.tryParse(transmissionTypeController.text),
        fuelType: int.tryParse(fuelTypeController.text),
      ),
    );
  }
}