import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../features/accounts_management/list_payment_view/screens/container_list_payment_view.dart';
import '../../../../../core/utilies/map_of_all_app.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/language/language_constant.dart';


class ListPaymentView extends StatelessWidget {
  const ListPaymentView({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: ContainerListPaymentView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
