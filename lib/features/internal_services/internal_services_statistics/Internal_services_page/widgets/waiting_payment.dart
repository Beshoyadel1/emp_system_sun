import 'package:flutter/material.dart';

import 'create_new_order.dart';

class WaitingPayment extends StatelessWidget {
  const WaitingPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return const CreateNewOrder(
        isProcessingRequest: false, isWaitingPayment: true);
  }
}
