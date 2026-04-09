import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../core/language/language.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../features/accounts_management/list_payment_view/screens/all_payment_list/all_payment_list.dart';
import '../../../../core/theming/fonts.dart';

class ListDataContainerListPaymentView extends StatelessWidget {
  const ListDataContainerListPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                text: AppLocalizations.of(context)
                    .translate(AppLanguageKeys.allPayments),
              ),
              Tab(
                text: AppLocalizations.of(context)
                    .translate(AppLanguageKeys.cardPayments),
              ),
              Tab(
                text: AppLocalizations.of(context)
                    .translate(AppLanguageKeys.cashOnDeliveryPayments),
              ),
            ],
          ),
          const Expanded(
            child: TabBarView(
              children: [
                AllPaymentList(),
                AllPaymentList(),
                AllPaymentList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
