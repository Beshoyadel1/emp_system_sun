import 'package:flutter/material.dart';
import '../../../../../../features/auth_page/auth_cubit/auth_cubit.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../../../../../features/store_page/store_widgets/facility_account/tabs/Identity_content.dart';
import '../../../../../../features/store_page/store_widgets/facility_account/tabs/bank_account_content.dart';
import '../../../../../../features/store_page/store_widgets/facility_account/tabs/branches_content.dart';
import '../../../../../../features/store_page/store_widgets/facility_account/tabs/facility_data_content.dart';
import '../../../../../../features/store_page/store_widgets/facility_account/tabs/working_hours_content.dart';

class FacilityModel {
  final String title;
  final Widget content;

  FacilityModel({required this.title, required this.content});
}

final List<FacilityModel> facilityTabs = [
  FacilityModel(
    title: AppLanguageKeys.facilityDataKey,
    content: const FacilityDataContent(),
  ),
  FacilityModel(
      title: AppLanguageKeys.identityKey, content: const IdentityContent()),
  FacilityModel(
      title: AppLanguageKeys.branchesKey, content: const BranchesContent()),
  FacilityModel(
    title: AppLanguageKeys.workingHoursKey,
    content: WorkingHoursContent(),
  ),
  FacilityModel(
      title: AppLanguageKeys.bankAccountKey,
      content: const BankAccountContent()),
];
