import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../../core/pages_widgets/general_widgets/snakbar.dart';
import '../../../../../../../../../core/theming/image_compressor.dart';
import '../../../../../../../../../features/cars_haraj_page/data/model/get_all_harage_model/harage_data.dart';
import '../../../../../../../../../core/api/dio_function/api_constants.dart';
import '../../../../../../../../../core/language/language_constant.dart';
import '../../../../../../../../../core/pages_widgets/text_form_field_widget.dart';
import '../../../../../../../../../core/theming/colors.dart';
import '../../../../../../../../../core/theming/text_styles.dart';
import '../../../../../../../../../features/cars_haraj_page/presentation/bloc/harag_cubit/harag_cubit.dart';
import '../../../../../../../../../features/cars_haraj_page/presentation/bloc/harag_cubit/harag_state.dart';
import '../../../../../../../../../features/cars_haraj_page/data/request/create_update_harage_request/create_update_harage_request.dart';

class CreateHaragDialog extends StatefulWidget {
  final HarageData? car;

  const CreateHaragDialog({
    super.key,
    this.car,
  });

  bool get isEdit => car != null;

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

  int? selectedFuelTypeId;

  bool isNew = false;

  bool addCar = true;

  int? selectedBrandId;
  int? selectedModelId;

  List<Uint8List> existingImages = [];

  List<Uint8List> selectedImages = [];

  @override
  void initState() {
    super.initState();

    _initializeData();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final cubit = context.read<HaragCubit>();

      cubit.getCarBrands();

      if (selectedBrandId != null) {
        cubit.getCarModels(
          brandId: selectedBrandId!,
        );
      }
    });
  }

  void _initializeData() {
    final car = widget.car;

    // =========================
    // CREATE
    // =========================

    if (car == null) {
      addCar = true;
      return;
    }

    // =========================
    // EDIT
    // =========================

    descriptionController.text = car.description ?? '';

    priceController.text = car.price?.toString() ?? '';

    costController.text = car.cost?.toString() ?? '';

    kilometersController.text = car.kilometers?.toString() ?? '';

    addressController.text = car.addressText ?? '';

    releaseDateController.text = car.releaseDate ?? '';

    transmissionTypeController.text = car.transmissionType?.toString() ?? '';

    selectedFuelTypeId = car.fuelType;

    isNew = car.isNew ?? false;

    selectedBrandId = car.carbrandid;

    selectedModelId = car.carmodelid;

    // Edit:
    // show car selection only if both exist.
    addCar = selectedBrandId != null && selectedModelId != null;

    existingImages = List<Uint8List>.from(
      car.images,
    );
  }

  @override
  void dispose() {
    descriptionController.dispose();
    priceController.dispose();
    costController.dispose();
    kilometersController.dispose();
    addressController.dispose();
    releaseDateController.dispose();
    transmissionTypeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HaragCubit, HaragState>(
      listener: (context, state) {
        if (state is CreateHarageSuccess) {
          AppSnackBar.showSuccess(
            AppLanguageKeys.success,
          );

          Navigator.pop(context, true);
          return;
        }

        if (state is UpdateHarageSuccess) {
          AppSnackBar.showSuccess(
            AppLanguageKeys.success,
          );

          Navigator.pop(context, true);
          return;
        }

        if (state is CreateHarageError) {
          AppSnackBar.showError(
            state.message,
          );
        }

        if (state is UpdateHarageError) {
          AppSnackBar.showError(
            state.message,
          );
        }
      },
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),

        title: TextInAppWidget(
          text: widget.isEdit ? AppLanguageKeys.edit : AppLanguageKeys.create,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15,
                children: [
                  _switch(
                    AppLanguageKeys.addNewCarKey,
                    addCar,
                    (value) {
                      setState(() {
                        addCar = value;

                        if (!value) {
                          selectedBrandId = null;
                          selectedModelId = null;
                        }
                      });
                    },
                  ),
                  if (addCar) ...[
                    _title(
                      AppLanguageKeys.selectCarBrand,
                    ),
                    BlocBuilder<HaragCubit, HaragState>(
                      buildWhen: (previous, current) {
                        return current is HaragBrandsLoading ||
                            current is HaragBrandsSuccess ||
                            current is HaragBrandsError;
                      },
                      builder: (context, state) {
                        if (state is HaragBrandsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is HaragBrandsError) {
                          return const SizedBox();
                        }

                        if (state is HaragBrandsSuccess) {
                          if (state.brands.isEmpty) {
                            return const SizedBox();
                          }
                          final brandExists = state.brands.any(
                            (brand) => brand.id == selectedBrandId,
                          );

                          final dropdownValue =
                              brandExists ? selectedBrandId : null;
                          return _dropdown<int>(
                            value: dropdownValue,
                            hint: AppLanguageKeys.selectItem,
                            items: state.brands
                                .where((brand) => brand.id != null)
                                .map(
                                  (brand) => DropdownMenuItem<int>(
                                    value: brand.id!,
                                    child: TextInAppWidget(
                                      text: brand.getName(context),
                                      textSize: 15,
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }

                              setState(() {
                                selectedBrandId = value;

                                // Brand changed => old model is invalid
                                selectedModelId = null;
                              });

                              context.read<HaragCubit>().getCarModels(
                                    brandId: value,
                                  );
                            },
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                    BlocBuilder<HaragCubit, HaragState>(
                      buildWhen: (previous, current) {
                        return current is HaragModelsLoading ||
                            current is HaragModelsSuccess ||
                            current is HaragModelsError;
                      },
                      builder: (context, state) {
                        if (selectedBrandId == null) {
                          return const SizedBox();
                        }

                        if (state is HaragModelsLoading) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        if (state is HaragModelsError) {
                          return const SizedBox();
                        }

                        if (state is HaragModelsSuccess) {
                          if (state.models.isEmpty) {
                            return const SizedBox();
                          }
                          final modelExists = state.models.any(
                            (model) => model.id == selectedModelId,
                          );

                          final dropdownValue =
                              modelExists ? selectedModelId : null;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _title(
                                AppLanguageKeys.selectCarModel,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              _dropdown<int>(
                                value: dropdownValue,
                                hint: AppLanguageKeys.selectItem,
                                items: state.models
                                    .where((model) => model.id != null)
                                    .map(
                                      (model) => DropdownMenuItem<int>(
                                    value: model.id!,
                                    child: TextInAppWidget(
                                      text: model.name ?? '',
                                      textSize: 15,
                                    ),
                                  ),
                                )
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedModelId = value;
                                  });
                                },
                              ),
                            ],
                          );
                        }

                        return const SizedBox();
                      },
                    ),
                  ],
                  _field(
                    AppLanguageKeys.description,
                    descriptionController,
                  ),
                  _field(
                    AppLanguageKeys.address,
                    addressController,
                  ),

                  Row(
                    spacing: 5,
                    children: [
                      Expanded(
                        child: _field(
                          AppLanguageKeys.price,
                          priceController,
                          isDouble: true,
                        ),
                      ),
                      Expanded(
                        child: _field(
                          AppLanguageKeys.cost,
                          costController,
                          isDouble: true,
                        ),
                      ),
                    ],
                  ),

                  // ==================================================
                  // MILEAGE
                  // ==================================================

                  _field(
                    AppLanguageKeys.mileage,
                    kilometersController,
                    isInt: true,
                  ),

                  // ==================================================
                  // IS NEW
                  // ==================================================

                  _switch(
                    AppLanguageKeys.isNew,
                    isNew,
                    (value) {
                      setState(() {
                        isNew = value;
                      });
                    },
                  ),

                  // ==================================================
                  // RELEASE DATE
                  // ==================================================

                  _field(
                    AppLanguageKeys.releaseDate,
                    releaseDateController,
                    isInt: true,
                  ),

                  // ==================================================
                  // TRANSMISSION TYPE
                  // ==================================================

                  _field(
                    AppLanguageKeys.transmissionType,
                    transmissionTypeController,
                    isInt: true,
                  ),

                  // ==================================================
                  // FUEL TYPE
                  // ==================================================

                  _title(
                    AppLanguageKeys.fuelType,
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.darkColor.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: selectedFuelTypeId,
                        isExpanded: true,
                        hint: const TextInAppWidget(
                          text: AppLanguageKeys.selectItem,
                          textSize: 15,
                        ),
                        items: FuelTypes.all.map(
                          (fuel) {
                            return DropdownMenuItem<int>(
                              value: fuel.id,
                              child: TextInAppWidget(
                                text: fuel.name,
                                textSize: 15,
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedFuelTypeId = value;
                          });
                        },
                      ),
                    ),
                  ),

                  // ==================================================
                  // IMAGES
                  // ==================================================

                  _imagesSection(),
                ],
              ),
            ),
          ),
        ),

        // ========================================================
        // ACTIONS
        // ========================================================

        actions: [
          // ======================================================
          // CANCEL
          // ======================================================

          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const TextInAppWidget(
              text: AppLanguageKeys.cancel,
              textSize: 15,
            ),
          ),

          // ======================================================
          // CREATE / UPDATE
          // ======================================================

          BlocBuilder<HaragCubit, HaragState>(
            builder: (context, state) {
              final isLoading = widget.isEdit
                  ? state is UpdateHarageLoading
                  : state is CreateHarageLoading;

              return ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    AppColors.orangeColor,
                  ),
                ),
                onPressed: isLoading ? null : _submit,
                child: isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(),
                      )
                    : TextInAppWidget(
                        text: widget.isEdit
                            ? AppLanguageKeys.edit
                            : AppLanguageKeys.create,
                        textSize: 15,
                        textColor: AppColors.whiteColor,
                      ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PICK IMAGES
  // ============================================================

  Future<void> _pickImages() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
        withData: true,
      );

      if (result == null || result.files.isEmpty) {
        return;
      }

      final List<Uint8List> compressedImages = [];

      for (final file in result.files) {
        final bytes = file.bytes;

        if (bytes == null) {
          continue;
        }

        final compressed = await ImageCompressor.compressImage(
          bytes,
          minWidth: 400,
          minHeight: 400,
          quality: 60,
        );

        if (compressed != null) {
          compressedImages.add(compressed);
        }
      }

      if (!mounted) return;

      setState(() {
        selectedImages.addAll(
          compressedImages,
        );
      });
    } catch (e) {
      if (!mounted) return;

      AppSnackBar.showError(
        e.toString().replaceFirst(
              'Exception: ',
              '',
            ),
      );
    }
  }

  // ============================================================
  // IMAGES SECTION
  // ============================================================

  Widget _imagesSection() {
    final totalImages = existingImages.length + selectedImages.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(
          AppLanguageKeys.uploadImage,
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _pickImages,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.darkColor.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_photo_alternate_outlined,
                ),
                SizedBox(width: 8),
                TextInAppWidget(
                  text: AppLanguageKeys.selectItem,
                  textSize: 14,
                ),
              ],
            ),
          ),
        ),
        if (totalImages > 0) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              // ==================================================
              // EXISTING IMAGES
              // ==================================================

              ...List.generate(
                existingImages.length,
                (index) {
                  return _imageItem(
                    image: existingImages[index],
                    onRemove: () => _removeExistingImage(
                      index,
                    ),
                  );
                },
              ),

              // ==================================================
              // NEW IMAGES
              // ==================================================

              ...List.generate(
                selectedImages.length,
                (index) {
                  return _imageItem(
                    image: selectedImages[index],
                    onRemove: () => _removeNewImage(
                      index,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ],
    );
  }

  // ============================================================
  // REMOVE EXISTING IMAGE
  // ============================================================

  void _removeExistingImage(int index) {
    if (index < 0 || index >= existingImages.length) {
      return;
    }

    setState(() {
      existingImages.removeAt(index);
    });
  }

  // ============================================================
  // REMOVE NEW IMAGE
  // ============================================================

  void _removeNewImage(int index) {
    if (index < 0 || index >= selectedImages.length) {
      return;
    }

    setState(() {
      selectedImages.removeAt(index);
    });
  }

  // ============================================================
  // IMAGE ITEM
  // ============================================================

  Widget _imageItem({
    required Uint8List image,
    required VoidCallback onRemove,
  }) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.memory(
            image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: InkWell(
            onTap: onRemove,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // DROPDOWN
  // ============================================================

  Widget _dropdown<T>({
    required T? value,
    required String hint,
    required List<DropdownMenuItem<T>> items,
    required ValueChanged<T?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.darkColor.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          hint: TextInAppWidget(
            text: hint,
            textSize: 15,
          ),
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================

  Widget _field(
    String title,
    TextEditingController controller, {
    bool isDouble = false,
    bool isInt = false,
  }) {
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

  // ============================================================
  // SWITCH
  // ============================================================

  Widget _switch(
    String title,
    bool value,
    Function(bool) onChanged,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _title(title),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  // ============================================================
  // TITLE
  // ============================================================

  Widget _title(String text) {
    return TextInAppWidget(
      text: text,
      textSize: 13,
      textColor: AppColors.darkColor.withOpacity(0.6),
    );
  }

  // ============================================================
  // SUBMIT
  // ============================================================

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // =========================
    // FUEL TYPE
    // =========================

    if (selectedFuelTypeId == null) {
      AppSnackBar.showError(
        AppLanguageKeys.selectItem,
      );
      return;
    }

    // =========================
    // BRAND / MODEL
    // =========================

    if (addCar) {
      if (selectedBrandId == null) {
        AppSnackBar.showError(
          AppLanguageKeys.selectCarBrand,
        );
        return;
      }

      if (selectedModelId == null) {
        AppSnackBar.showError(
          AppLanguageKeys.selectCarModel,
        );
        return;
      }
    }

    // =========================
    // PARSE
    // =========================

    final int? releaseDate = int.tryParse(
      releaseDateController.text.trim(),
    );

    final int? transmissionType = int.tryParse(
      transmissionTypeController.text.trim(),
    );

    final int? kilometers = int.tryParse(
      kilometersController.text.trim(),
    );

    final double? price = double.tryParse(
      priceController.text.trim(),
    );

    final double? cost = double.tryParse(
      costController.text.trim(),
    );

    // =========================
    // IMAGES
    // =========================

    final List<Uint8List> images = [
      ...existingImages,
      ...selectedImages,
    ];

    final request = CreateUpdateHarageRequest(
      id: widget.isEdit ? widget.car?.id : null,
      carId: widget.isEdit ? widget.car?.carid : null,
      carBrandId: addCar ? selectedBrandId : null,
      carModelId: addCar ? selectedModelId : null,
      isNew: isNew,
      releaseDate: releaseDate,
      transmissionType: transmissionType,
      fuelType: selectedFuelTypeId,
      kilometers: kilometers,
      description: descriptionController.text.trim(),
      addressText: addressController.text.trim(),
      price: price,
      cost: cost,
      branchId: widget.isEdit ? widget.car?.branchId : 1,
      images: images,
    );

    // =========================
    // SEND
    // =========================

    final cubit = context.read<HaragCubit>();

    if (widget.isEdit) {
      cubit.updateHarage(
        request: request,
      );
    } else {
      cubit.createHarage(
        request: request,
      );
    }
  }
}
