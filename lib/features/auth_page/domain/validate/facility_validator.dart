import 'package:emp_system_sun/core/language/language_constant.dart';
import 'package:emp_system_sun/features/auth_page/data/model/create_user_model/create_user_request.dart';
import 'package:emp_system_sun/features/store_page/presentation/bloc/branch_cubit/branch_cubit.dart';
import 'package:emp_system_sun/features/store_page/presentation/bloc/work_time_cubit/work_time_cubit.dart';


class FacilityValidationResult {
  final bool isValid;
  final List<String> missingFields;

  FacilityValidationResult({
    required this.isValid,
    required this.missingFields,
  });
}

class FacilityValidator {
  static FacilityValidationResult validate({
    required CreateUserRequest user,
    required BranchCubit branchCubit,
    required UpdateWorkTimeCubit workTimeCubit,
  }) {
    final p = user.employeeDetails?.employeeDetails;

    List<String> missing = [];

    bool isValid(String? value) {
      return value != null &&
          value.trim().isNotEmpty &&
          value.trim() != "null";
    }

    /// 🔴 Basic data
    if (!isValid(p?.jobname)) missing.add(AppLanguageKeys.facilityName);
    if (!isValid(p?.joblatinname)) missing.add(AppLanguageKeys.facilityNameEn);
    // if (!isValid(p?.cr)) missing.add(AppLanguageKeys.commercialRecordKey);
    // if (!isValid(p?.vatno)) missing.add(AppLanguageKeys.taxNumber);
    // if (!isValid(p?.nationaladdress)) missing.add(AppLanguageKeys.nationality);
    if (!isValid(user.phone)) missing.add(AppLanguageKeys.phoneNumber);
    if (!isValid(user.email)) missing.add(AppLanguageKeys.email);

    if (!isValid(user.image?.toString())) missing.add(AppLanguageKeys.ownerIdKey);

    /// 🔴 Branch
    // print("BRANCHES TYPE => ${branchCubit.branches.runtimeType}");
    // print("BRANCHES => ${branchCubit.branches}");
    //
    // if (branchCubit.branches.isEmpty) {
    //   missing.add(AppLanguageKeys.addAtLeastOneBranch);
    // }
    //
    // /// 🔴 Work Time
    // print("WORK TIMES TYPE => ${workTimeCubit.workTimes.runtimeType}");
    // print("WORK TIMES => ${workTimeCubit.workTimes}");
    //
    // if (workTimeCubit.workTimes.isEmpty) {
    //   missing.add(AppLanguageKeys.addAtLeastOneWorkingHours);
    // }

    return FacilityValidationResult(
      isValid: missing.isEmpty,
      missingFields: missing,
    );
  }
}