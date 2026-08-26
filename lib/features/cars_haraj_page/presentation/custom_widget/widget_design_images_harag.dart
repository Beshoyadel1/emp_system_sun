import 'package:flutter/cupertino.dart';
import '../../../../../../../core/pages_widgets/general_widgets/custom_container.dart';
import '../../../../../../../features/cars_haraj_page/data/model/get_all_harage_model/harage_data.dart';

class WidgetDesignImagesHarag extends StatelessWidget {
  const WidgetDesignImagesHarag({
    super.key,
    required this.harage,
  });

  final HarageData harage;

  @override
  Widget build(BuildContext context) {
    if (harage.images.isEmpty) {
      return const SizedBox();
    }

    return CustomContainer(
      isSelected: false,
      containerWidth: double.infinity,
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      typeWidget: Padding(
        padding: const EdgeInsets.all(15),
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: harage.images.map<Widget>((image) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                image,
                width: 100,
                height: 70,
                fit: BoxFit.cover,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}