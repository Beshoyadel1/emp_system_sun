import 'package:flutter/cupertino.dart';

class CustomRowListOfDataViewOfPricePerCategory extends StatelessWidget {
  final String text1, text2, imagePath1, imagePath2;
  final String? text3, imagePath3;
  final bool? isMobile;

  const CustomRowListOfDataViewOfPricePerCategory(
      {super.key,
      required this.text1,
      required this.imagePath1,
      required this.text2,
      required this.imagePath2,
      this.text3,
      this.imagePath3,
      this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return isMobile!
        ? Row(
            spacing: 5,
            children: [
              // CarImageTextInSettingWidget(imagePath: imagePath1, text: text1),
              // CarImageTextInSettingWidget(imagePath: imagePath2, text: text2),
            ],
          )
        : Row(
            spacing: 5,
            children: [
              // CarImageTextInSettingWidget(imagePath: imagePath1, text: text1),
              // CarImageTextInSettingWidget(imagePath: imagePath2, text: text2),
              // CarImageTextInSettingWidget(imagePath: imagePath3!, text: text3!),
            ],
          );
  }
}
