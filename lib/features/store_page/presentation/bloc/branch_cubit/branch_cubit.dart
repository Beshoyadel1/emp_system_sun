import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emp_system_sun/features/store_page/data/datasource/add_branch_datasource/add_branch_repository.dart';
import 'package:emp_system_sun/features/store_page/data/model/add_branch_model/add_branch_request.dart';
import 'package:emp_system_sun/features/store_page/data/datasource/get_provider_branches_datasource/get_provider_branches_repository.dart';
import 'package:emp_system_sun/features/store_page/data/model/get_provider_branches_model/get_provider_branches_request.dart';
import 'package:emp_system_sun/features/store_page/data/datasource/update_branch_datasource/update_branch_repository.dart';
import 'package:emp_system_sun/features/auth_page/data/datasource/login_datasource/login_repository.dart';
import 'package:emp_system_sun/features/store_page/data/model/get_provider_branches_model/provider_branch_model.dart';
import 'branch_state.dart';

class BranchCubit extends Cubit<BranchState> {
  BranchCubit() : super(BranchInitial());

  List<ProviderBranchModel> branches = [];
  int? myUserId;

  Future<void> _initUser() async {
    if (myUserId != null) return;
    final user = await AuthLocalStorage.getUser();
    myUserId = user!.userid!;
  }

  Future<void> getProviderBranches() async {
    emit(BranchLoading());

    try {
      await _initUser();

      branches = await getProviderBranchesFunction(
        getProviderBranchesRequest:
        GetProviderBranchesRequest(providerId: myUserId!),
      );

      emit(BranchSuccess(branches: branches));
    } catch (e) {
      if (e is DioException) {

        emit(BranchError(
          e.response?.data.toString() ?? e.message ?? "Server error",
        ));
      } else {
        emit(BranchError(e.toString()));
      }
    }
  }

  void goToAdd() {
    final current = state as BranchSuccess;
    emit(current.copyWith(
      isAdding: true,
      editingBranchId: null,
      fromSubmit: false,
    ));
  }

  void edit(int index) {
    final current = state as BranchSuccess;
    emit(current.copyWith(
      isAdding: true,
      editingBranchId: index,
      fromSubmit: false,
    ));
  }

  void back() {
    final current = state as BranchSuccess;
    emit(current.copyWith(
      isAdding: false,
      editingBranchId: null,
      fromSubmit: false,
    ));
  }

  Future<void> addBranch(AddBranchRequest request) async {
    try {
      await _initUser();

      final body = request.toJson(myUserId!);
      final response = await addBranchFunction(body: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is Map<String, dynamic>) {
          final newBranch = ProviderBranchModel.fromJson(response.data);
          branches.add(newBranch);
        }

        emit(BranchSuccess(
          branches: List.from(branches),
          fromSubmit: true,
        ));
      }
    } catch (e) {
      emit(BranchError(e.toString()));
    }
  }

  Future<void> updateBranch(AddBranchRequest request) async {
    try {
      await _initUser();

      final body = request.toJson(myUserId!);
      final response = await updateBranchFunction(body: body);

      if (response.statusCode == 200) {

        if (response.data is Map<String, dynamic>) {
          final updated =
          ProviderBranchModel.fromJson(response.data);

          final index = branches.indexWhere(
                  (e) => e.branchId == updated.branchId);

          if (index != -1) {
            branches[index] = updated;
          }
        }
        else {
          final index = branches.indexWhere(
                  (e) => e.branchId == request.branchId);

          if (index != -1) {
            branches[index] = ProviderBranchModel(
              branchId: request.branchId,
              branchName: request.branchName,
              branchLatinName: request.branchLatinName,
              address: request.address,
              addressText: request.addressText,
              addressLatinText: request.addressLatinText,
              providerId: myUserId,
              isActive: request.isActive,
            );
          }
        }

        emit(BranchSuccess(
          branches: List.from(branches),
          fromSubmit: true,
        ));
      }
    } catch (e) {
      emit(BranchError(e.toString()));
    }
  }
  Future<void> deleteBranch(int branchId) async {
    try {
      await _initUser();

      final request = AddBranchRequest(
        branchId: branchId,
        isActive: false,
      );

      final response = await updateBranchFunction(
        body: request.toJson(myUserId!),
      );

      if (response.statusCode == 200) {
        /// 👇 حدّث الليست محليًا (remove من UI)
        branches.removeWhere((b) => b.branchId == branchId);

        emit(BranchSuccess(
          branches: List.from(branches),
          fromSubmit: true,
        ));
      }
    } catch (e) {
      emit(BranchError(e.toString()));
    }
  }
}