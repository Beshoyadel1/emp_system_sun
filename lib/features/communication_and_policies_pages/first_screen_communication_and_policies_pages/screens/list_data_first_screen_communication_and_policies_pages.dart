import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../features/communication_and_policies_pages/first_screen_communication_and_policies_pages/logic/tab_new_cubit/tab_insurance_new_offers_cubit.dart';
import 'communication_and_policies_pages_screen.dart';

class ListDataFirstScreenCommunicationAndPoliciesPages extends StatefulWidget {
  const ListDataFirstScreenCommunicationAndPoliciesPages({super.key});

  @override
  State<ListDataFirstScreenCommunicationAndPoliciesPages> createState() =>
      _ScreenListDataFirstScreenCommunicationAndPoliciesPagesState();
}

class _ScreenListDataFirstScreenCommunicationAndPoliciesPagesState
    extends State<ListDataFirstScreenCommunicationAndPoliciesPages> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TabInsuranceNewOffersCubit(),
      child: CommunicationAndPoliciesPagesScreen(),
    );
  }
}
