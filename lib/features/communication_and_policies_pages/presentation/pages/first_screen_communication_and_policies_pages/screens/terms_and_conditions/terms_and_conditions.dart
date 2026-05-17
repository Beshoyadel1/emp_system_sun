import 'package:flutter/material.dart';
import 'first_title_in_terms_and_conditions.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: FirstTitleInTermsAndConditions(),
      ),
    );
  }
}
