import 'package:flutter/material.dart';
import '../../../../../../features/internal_services/internal_services_statistics/Internal_services_page/widgets/create_new_order.dart';
import '../../../../../../features/internal_services/internal_services_statistics/Internal_services_page/widgets/processing_request.dart';
import '../../../../../../features/internal_services/internal_services_statistics/Internal_services_page/widgets/waiting_payment.dart';
import '../../../../../../core/language/language_constant.dart';

class NewOrderStepsModel {
  final String title, date;
  final Widget content;
  final bool isActive;

  NewOrderStepsModel(
      {required this.date,
      required this.isActive,
      required this.title,
      required this.content});
}

final List<NewOrderStepsModel> steps = [
  NewOrderStepsModel(
      title: AppLanguageKeys.createNewOrderKey,
      content: const CreateNewOrder(
        isProcessingRequest: false,
      ),
      isActive: true,
      date: ''),
  NewOrderStepsModel(
      title: AppLanguageKeys.orderInProgressKey,
      content: const ProcessingRequest(),
      isActive: false,
      date: ''),
  NewOrderStepsModel(
      title: AppLanguageKeys.waitingForPaymentKey,
      content: const ProcessingRequest(),
      isActive: false,
      date: ''),
  NewOrderStepsModel(
      title: AppLanguageKeys.serviceDeliveredKey,
      content: const WaitingPayment(),
      isActive: false,
      date: ''),
];
