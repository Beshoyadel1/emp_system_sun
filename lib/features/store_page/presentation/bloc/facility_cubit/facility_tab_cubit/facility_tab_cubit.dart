import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:emp_system_sun/core/theming/image_compressor.dart';
import 'package:emp_system_sun/features/store_page/data/model/branch_model/branch_model_dashboard.dart';
import 'package:emp_system_sun/features/store_page/data/model/facility_model/facility_model.dart';
import 'facility_tab_state.dart';

class FacilityTabCubit extends Cubit<FacilityTabState> {
  FacilityTabCubit() : super(FacilityDataState());

  static FacilityTabCubit get(BuildContext context) => BlocProvider.of(context);

  final ImagePicker _picker = ImagePicker();

  Uint8List? identityImage;
  String? identityBase64;

  final Map<String, Uint8List> images = {};

  Future<void> uploadIdentityImage() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;

    final bytes = await file.readAsBytes();

    final compressed = await ImageCompressor.compressImage(bytes);

    identityImage = compressed;
    identityBase64 = base64Encode(compressed!);

    emit(IdentityUploadedState());
  }

  void deleteIdentityImage() {
    identityImage = null;
    identityBase64 = null;
    emit(IdentityDeletedState());
  }

  /// ================= Upload by type =================
  Future<void> uploadImage(String type) async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file == null) return;

    final bytes = await file.readAsBytes();

    final compressed = await ImageCompressor.compressImage(bytes);

    images[type] = compressed!;

    emit(IdentityUploadedState());
  }

  Set<String> deletedImages = {};

  void deleteImage(String type) {
    images.remove(type);
    deletedImages.add(type);
    emit(IdentityDeletedState());
  }

  late Timer timer;
  int remainingTime = 0;

  int selectedIndex = 0;

  void selectTab(int index) {
    selectedIndex = index;
    emit(ChangeIndexState());
  }

  void nextTab() {
    if (selectedIndex < facilityTabs.length - 1) {
      selectedIndex++;
      emit(ChangeIndexState());
    }
  }

  void previousTab() {
    if (selectedIndex > 0) {
      selectedIndex--;
      emit(ChangeIndexState());
    }
  }

  ////////// Working hours //////
  Set<int> selectedDays = {};

  void selectDay(int index) {
    if (selectedDays.contains(index)) {
      selectedDays.remove(index);
    } else {
      selectedDays.add(index);
    }

    emit(WorkingHoursDaySelectedState(Set.from(selectedDays)));
  }

  /////////// Branches ///////////
  final List<BranchModelDashboard> branches = [];
  int? editingIndex;
  bool isAddingBranch = true;

  void addBranch(BranchModelDashboard branch) {
    branches.add(branch);
    isAddingBranch = false;
    emit(ChangeIndexState());
  }

  void editBranch(int index) {
    editingIndex = index;
    isAddingBranch = true;
    emit(ChangeIndexState());
  }

  void updateBranch(BranchModelDashboard updatedBranch) {
    branches[editingIndex!] = updatedBranch;
    editingIndex = null;
    isAddingBranch = false;
    emit(ChangeIndexState());
  }

  void goToAddBranches() {
    editingIndex = null;
    isAddingBranch = true;
    emit(ChangeIndexState());
  }

  //////////////image//////////////

  Uint8List? image;
  String? base64;

  // Future<void> uploadImage() async {
  //   try {
  //     final result = await FilePicker.platform.pickFiles(
  //       type: FileType.image,
  //       withData: true,
  //     );
  //     if (result != null && result.files.single.bytes != null) {
  //       final bytes = result.files.single.bytes!;
  //       image = bytes;
  //       base64 = base64Encode(bytes);
  //       emit(IdentityUploadedState());
  //     }
  //   } catch (e) {
  //     debugPrint('Error picking identity image: $e');
  //   }
  // }

  // void deleteImage() {
  //   image = null;
  //   base64 = null;
  //   emit(IdentityDeletedState());
  // }

  // void editImage() async {
  //   await uploadImage();
  // }

  /////////////file//////////

  final Map<String, Uint8List> uploadedFiles = {};
  final Map<String, String> uploadedFileNames = {};

  Future<void> uploadFile(String type) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        withData: true,
      );
      if (result != null && result.files.single.bytes != null) {
        final file = result.files.single;
        uploadedFiles[type] = file.bytes!;
        uploadedFileNames[type] = file.name;
        emit(IdentityUploadedState());
      }
    } catch (e) {
      debugPrint('Error picking file: $e');
    }
  }

  void deleteFile(String type) {
    uploadedFiles.remove(type);
    uploadedFileNames.remove(type);
    emit(IdentityDeletedState());
  }
}
