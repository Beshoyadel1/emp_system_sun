import 'package:flutter/material.dart';
import 'first_title_in_about_sun.dart';

class AboutSun extends StatelessWidget {
  const AboutSun({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: FirstTitleInAboutSun(),
      ),
    );
  }
}
