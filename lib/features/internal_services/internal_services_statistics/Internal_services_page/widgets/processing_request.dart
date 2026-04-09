import 'package:flutter/material.dart';
import '../../../../../core/language/language_constant.dart';
import 'create_new_order.dart';

class ProcessingRequest extends StatelessWidget {
  const ProcessingRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return const CreateNewOrder(
        textButton: AppLanguageKeys.orderCompletionKey,
        isProcessingRequest: true);
  }
}
