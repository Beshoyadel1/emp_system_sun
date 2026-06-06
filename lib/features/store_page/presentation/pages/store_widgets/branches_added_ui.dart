import 'package:emp_system_sun/features/store_page/presentation/bloc/branch_cubit/branch_cubit.dart';
import 'package:emp_system_sun/features/store_page/presentation/bloc/branch_cubit/branch_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import 'custom_add_button.dart';
import '../../../../../core/theming/assets.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/language/language_constant.dart';

class BranchesAddedUi extends StatelessWidget {
  const BranchesAddedUi({super.key, required this.state});

  final BranchSuccess state;

  @override
  Widget build(BuildContext context) {
    final branches =
    state.branches.where((b) => b.isActive == true).toList();
    if (branches.isEmpty) {
      return Column(
        children: [
          const SizedBox(height: 40),
          const TextInAppWidget(
            text: AppLanguageKeys.noBranchesYet,
            textSize: 18,
          ),
          const SizedBox(height: 20),
          CustomAddButton(
            width: 200,
            text: AppLanguageKeys.addNewBranchKey,
            onTap: () => context.read<BranchCubit>().goToAdd(),
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        ...branches.map((branch) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: CustomContainer(
              boxShadow: [
                BoxShadow(
                  color: AppColors.lightGreyColor.withAlpha(110),
                  blurRadius: 21,
                  spreadRadius: 2,
                  offset: const Offset(0, 6),
                ),
              ],
              border: const Border(),
              isSelected: false,
              onTap: () {},
              borderRadius: BorderRadius.circular(11),

              typeWidget: LayoutBuilder(
                builder: (context, constraints) {
                  final isSmall = constraints.maxWidth < 600;
                  if (isSmall) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 41,
                              width: 41,
                              decoration: BoxDecoration(
                                color: AppColors.orangeColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add_location,
                                  color: AppColors.whiteColor,
                                  size: 22,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextInAppWidget(
                                  text: AppLanguageKeys.branchName,
                                  textSize: 16,
                                  fontWeightIndex:
                                  FontSelectionData.boldFontFamily,
                                ),
                                TextInAppWidget(
                                  text: branch.getBranchName(context),
                                  textSize: 16,
                                  fontWeightIndex:
                                  FontSelectionData.boldFontFamily,
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: _deleteButton(
                                context,
                                branches,
                                branch,
                                isSmall: true,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _editButton(
                                context,
                                branches,
                                branch,
                                isSmall: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  return Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 41,
                            width: 41,
                            decoration: BoxDecoration(
                              color: AppColors.orangeColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add_location,
                                color: AppColors.whiteColor,
                                size: 22,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextInAppWidget(
                                text: AppLanguageKeys.branchName,
                                textSize: 16,
                                fontWeightIndex:
                                FontSelectionData.boldFontFamily,
                              ),
                              TextInAppWidget(
                                text: branch.getBranchName(context),
                                textSize: 16,
                                fontWeightIndex:
                                FontSelectionData.boldFontFamily,
                              ),
                            ],
                          ),
                        ],
                      ),

                      const Spacer(),
                      Row(
                        children: [
                          _deleteButton(context, branches, branch),
                          const SizedBox(width: 10),
                          _editButton(context, branches, branch),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        }),

        CustomAddButton(
          width: 198,
          text: AppLanguageKeys.addNewBranchKey,
          onTap: () => context.read<BranchCubit>().goToAdd(),
        ),
      ],
    );
  }
}

Widget _deleteButton(BuildContext context, List branches, branch,
    {bool isSmall = false}) {
  return CustomContainer(
    isSelected: false,
    onTap: () {
      context.read<BranchCubit>().deleteBranch(branch.branchId!);
    },
    containerColor: AppColors.redColor,
    containerWidth: isSmall ? double.infinity : 162,
    containerHeight: 42,
    typeWidget: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.delete_outline,
          color: AppColors.whiteColor,
          size: 24,
        ),
        SizedBox(width: 6),
        Flexible(
          child:  TextInAppWidget(
            text: AppLanguageKeys.delete,
            textSize: 16,
            textColor: AppColors.whiteColor,
            fontWeightIndex: FontSelectionData.boldFontFamily,
          ),
        ),
      ],
    ),
  );
}

Widget _editButton(BuildContext context, List branches, branch,
    {bool isSmall = false}) {
  return CustomContainer(
    isSelected: false,
    onTap: () {
      context.read<BranchCubit>().edit(branch.branchId!);
    },
    containerColor: AppColors.darkGreyColor,
    containerWidth: isSmall ? double.infinity : 162,
    containerHeight: 42,
    typeWidget: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.edit,
          color: AppColors.whiteColor,
          size: 24,
        ),
        SizedBox(width: 6),
        Flexible(
          child:TextInAppWidget(
            text: AppLanguageKeys.editKey,
            textSize: 16,
            textColor: AppColors.whiteColor,
            fontWeightIndex: FontSelectionData.boldFontFamily,
          ),
        ),
      ],
    ),
  );
}