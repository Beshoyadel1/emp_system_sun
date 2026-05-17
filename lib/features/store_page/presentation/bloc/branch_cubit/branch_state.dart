import 'package:emp_system_sun/features/store_page/data/model/get_provider_branches_model/provider_branch_model.dart';

abstract class BranchState {}

class BranchInitial extends BranchState {}

class BranchLoading extends BranchState {}

class BranchSuccess extends BranchState {
  final List<ProviderBranchModel> branches;
  final bool isAdding;
  final int? editingBranchId;
  final bool fromSubmit;

  BranchSuccess({
    required this.branches,
    this.isAdding = false,
    this.editingBranchId,
    this.fromSubmit = false,
  });

  BranchSuccess copyWith({
    List<ProviderBranchModel>? branches,
    bool? isAdding,
    int? editingBranchId,
    bool? fromSubmit,
  }) {
    return BranchSuccess(
      branches: branches ?? this.branches,
      isAdding: isAdding ?? this.isAdding,
      editingBranchId: editingBranchId,
      fromSubmit: fromSubmit ?? false,
    );
  }
}

class BranchError extends BranchState {
  final String message;
  BranchError(this.message);
}

class BranchOperationSuccess extends BranchState {
  final String message;
  BranchOperationSuccess(this.message);
}