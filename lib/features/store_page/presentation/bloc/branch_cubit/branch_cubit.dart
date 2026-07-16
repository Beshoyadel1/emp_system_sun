import 'package:dio/dio.dart';
import 'package:emp_system_sun/core/theming/auth_local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emp_system_sun/features/store_page/data/datasource/add_branch_datasource/add_branch_repository.dart';
import 'package:emp_system_sun/features/store_page/data/request/add_branch_request/add_branch_request.dart';
import 'package:emp_system_sun/features/store_page/data/datasource/get_provider_branches_datasource/get_provider_branches_repository.dart';
import 'package:emp_system_sun/features/store_page/data/request/get_provider_branches_request/get_provider_branches_request.dart';
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

      branches =
      await getProviderBranchesFunction(

        getProviderBranchesRequest:
        GetProviderBranchesRequest(
          providerId: myUserId!,
        ),
      );

      emit(

        BranchSuccess(
          branches: branches,
        ),
      );

    } catch (e) {

      final error =
      e.toString().replaceAll(
        "Exception: ",
        "",
      );

      /// 👇 لو مفيش فروع
      if (error.contains("غير موجود")) {

        emit(

          BranchSuccess(
            branches: [],
          ),
        );

        return;
      }

      emit(
        BranchError(
          error,
        ),
      );
    }
  }

  void goToAdd() {
    final current = state as BranchSuccess;

    emit(
      current.copyWith(
        isAdding: true,
        editingBranchId: null,
        fromSubmit: false,
      ),
    );
  }

  void edit(int branchId) {
    final current = state as BranchSuccess;

    emit(
      current.copyWith(
        isAdding: true,
        editingBranchId: branchId,
        fromSubmit: false,
      ),
    );
  }

  void back() {
    final current = state as BranchSuccess;

    emit(
      current.copyWith(
        isAdding: false,
        editingBranchId: null,
        fromSubmit: false,
      ),
    );
  }

  Future<void> addBranch(
    AddBranchRequest request,
  ) async {
    try {
      await _initUser();

      final body = request.toJson(myUserId!);

      final response = await addBranchFunction(
        body: body,
      );

      final responseData = response.data;

      final bool success = responseData["success"] ?? false;

      if (!success) {
        throw Exception(
          responseData["message"] ?? "Something went wrong",
        );
      }

      await getProviderBranches();
    } catch (e) {
      emit(
        BranchError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> updateBranch(
    AddBranchRequest request,
  ) async {
    try {
      await _initUser();

      final body = request.toJson(myUserId!);

      final response = await updateBranchFunction(
        body: body,
      );

      final responseData = response.data;

      final bool success = responseData["success"] ?? false;

      if (!success) {
        throw Exception(
          responseData["message"] ?? "Something went wrong",
        );
      }

      await getProviderBranches();
    } catch (e) {
      emit(
        BranchError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> deleteBranch(
    int branchId,
  ) async {
    try {
      await _initUser();

      final request = AddBranchRequest(
        branchId: branchId,
        isActive: false,
      );

      final response = await updateBranchFunction(
        body: request.toJson(myUserId!),
      );

      final responseData = response.data;

      final bool success = responseData["success"] ?? false;

      if (!success) {
        throw Exception(
          responseData["message"] ?? "Delete failed",
        );
      }

      await getProviderBranches();
    } catch (e) {
      emit(
        BranchError(
          e.toString(),
        ),
      );
    }
  }
}
