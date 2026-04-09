import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../features/store_page/model/facility_cubit/facility_tab_cubit/facility_tab_cubit.dart';
import '../../../../../../../features/store_page/model/facility_cubit/facility_tab_cubit/facility_tab_state.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/assets.dart';
import '../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../core/theming/text_styles.dart';
import '../../../../../../core/language/language_constant.dart';

class AttachFile extends StatelessWidget {
  const AttachFile({
    super.key,
    required this.fileName,
    required this.fileType,
  });

  final String fileName;
  final String fileType;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FacilityTabCubit, FacilityTabState>(
      builder: (context, state) {
        final cubit = FacilityTabCubit.get(context);
        final bool hasFile = cubit.uploadedFiles.containsKey(fileType);
        final String? name = cubit.uploadedFileNames[fileType];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextInAppWidget(
              text: fileName,
              textSize: 16,
            ),
            CustomContainer(
              isSelected: hasFile,
              onTap: () => cubit.uploadFile(fileType),
              text: AppLanguageKeys.attachFileKey,
              padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 8),
              containerColor: AppColors.darkGreyColor,
              border: const Border(),
            ),
            const SizedBox(height: 8),
            if (hasFile)
              Row(
                spacing: 8,
                children: [
                  const Icon(Icons.insert_drive_file,
                      color: AppColors.darkGreyColor),
                  Flexible(
                    child: Text(
                      name ?? 'Unknown file',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.darkGreyColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => cubit.deleteFile(fileType),
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: AppColors.redColor,
                      child: Image.asset(
                        AppImageKeys.deleteIcon,
                        width: 15,
                        height: 15,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
