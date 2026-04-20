import 'package:flutter/material.dart';
import '../../../../../../core/language/language.dart';
import '../../../../../../core/language/language_constant.dart';
import '../../logic/loading_dashboard/loading_dashboard_cubit.dart';
import '../../../../../../core/utilies/map_of_all_app.dart';
import '../../../custom_widget/container_with_image_container_and_two_text_widget.dart';
import '../../../../../../core/theming/assets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/loading_dashboard/loading_dashboard_state.dart';

class FirstRowWithTwoContainerImageAndTwoText extends StatelessWidget {
  const FirstRowWithTwoContainerImageAndTwoText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternalOrdersCubit, InternalOrdersState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final isArabic =
                Localizations.localeOf(context).languageCode == 'ar';

            const minItemWidth = 220.0;

            int itemsPerRow =
            (constraints.maxWidth / minItemWidth).floor();

            if (itemsPerRow == 0) itemsPerRow = 1;

            final itemWidth =
                (constraints.maxWidth / itemsPerRow) - 10;

            return Wrap(
              spacing: 10,
              runSpacing: 10,
              children: state.services.map((service) {
                final title = isArabic
                    ? (service.serviceName ?? '')
                    : (service.serviceLatinName ?? '');

                return SizedBox(
                  width: itemWidth,
                  child: ContainerWithImageContainerAndTwoTextWidget(
                    imagePath: service.image,
                    title: title,
                    subTitle:
                    '${service.orderCount ?? 0} ${AppLocalizations.of(context).translate(AppLanguageKeys.order)}',
                  ),
                );
              }).toList(),
            );
          },
        );
      },
    );
  }
}