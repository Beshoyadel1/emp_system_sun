import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../features/communication_and_policies_pages/first_screen_communication_and_policies_pages/logic/tab_new_cubit/tab_insurance_new_offers_cubit.dart';
import '../../../../../../features/communication_and_policies_pages/first_screen_communication_and_policies_pages/logic/tab_new_cubit/tab_insurance_new_offers_state.dart';
import 'terms_and_conditions/terms_and_conditions.dart';
import 'about_sun/about_sun.dart';
import 'privacy_policy/privacy_policy.dart';
import '../../custom_widget/tab_communication_and_policies_widget.dart';
import 'contact_us/contact_us.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/language/language_constant.dart';

class CommunicationAndPoliciesPagesScreen extends StatefulWidget {
  const CommunicationAndPoliciesPagesScreen({super.key});

  @override
  State<CommunicationAndPoliciesPagesScreen> createState() =>
      _CommunicationAndPoliciesPagesScreenState();
}

class _CommunicationAndPoliciesPagesScreenState
    extends State<CommunicationAndPoliciesPagesScreen> {
  late TabInsuranceNewOffersCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<TabInsuranceNewOffersCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabInsuranceNewOffersCubit, TabInsuranceNewOffersState>(
      buildWhen: (previous, current) => current is TabInsuranceChangedState,
      builder: (context, state) {
        return DefaultTabController(
          length: eventsNameList.length,
          child: Column(
            children: [
              TabBar(
                onTap: (index) {
                  cubit.changeTab(index);
                },
                tabAlignment: TabAlignment.start,
                labelPadding: EdgeInsets.zero,
                indicatorColor: AppColors.transparent,
                dividerColor: AppColors.transparent,
                isScrollable: true,
                tabs: eventsNameList.map((eventsName) {
                  final index = eventsNameList.indexOf(eventsName);
                  return TabCommunicationAndPoliciesWidget(
                    isSelected: cubit.currentIndex == index,
                    text: eventsName,
                  );
                }).toList(),
              ),
              Expanded(
                child: TabBarView(
                  children: widgetInsuranceOffers,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

final List<Widget> widgetInsuranceOffers = const [
  ContactUs(),
  AboutSun(),
  PrivacyPolicy(),
  TermsAndConditions(),
];
final List<String> eventsNameList = [
  AppLanguageKeys.contactUs,
  AppLanguageKeys.aboutSun,
  AppLanguageKeys.privacyPolicy,
  AppLanguageKeys.termsAndConditions,
];
