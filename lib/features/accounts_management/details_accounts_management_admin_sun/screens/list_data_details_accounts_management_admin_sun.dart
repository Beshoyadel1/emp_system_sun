import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../features/accounts_management/details_accounts_management_admin_sun/screens/invoice_related_services/invoice_related_services.dart';
import '../../../../../features/accounts_management/details_accounts_management_admin_sun/screens/number_of_transaction_only/number_of_transaction_only.dart';


class ListDataDetailsAccountsManagementAdminSun extends StatelessWidget {
  const ListDataDetailsAccountsManagementAdminSun({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 30,
      children: [
        NumberOfTransactionOnly(),
        InvoiceRelatedServices()
      ],
    );
  }
}