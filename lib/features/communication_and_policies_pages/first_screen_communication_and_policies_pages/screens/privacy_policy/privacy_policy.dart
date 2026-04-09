import 'package:flutter/material.dart';
import 'first_title_in_privacy_policy.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: FirstTitleInPrivacyPolicy(),
      ),
    );
  }
}
