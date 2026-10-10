import 'package:emp_system_sun/features/store_page/presentation/bloc/facility_cubit/facility_tab_cubit/facility_tab_cubit.dart';
import 'package:emp_system_sun/features/store_page/presentation/pages/store_widgets/facility_account/tabs/facility_data_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/pages_widgets/general_widgets/custom_container.dart';

class FacilityAccount extends StatefulWidget {
  const FacilityAccount({super.key});

  @override
  State<FacilityAccount> createState() => _FacilityAccountState();
}

class _FacilityAccountState extends State<FacilityAccount> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FacilityTabCubit(),
      child: NavigatorPopHandler<Object?>(
        onPopWithResult: (_) => _navigatorKey.currentState?.maybePop(),
        child: Navigator(
          key: _navigatorKey,
          onGenerateRoute: (_) => MaterialPageRoute<void>(
            builder: (_) => const _FacilityAccountContent(),
          ),
        ),
      ),
    );
  }
}

class _FacilityAccountContent extends StatelessWidget {
  const _FacilityAccountContent();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomContainer(
              containerWidth: double.infinity,
              isSelected: false,
              typeWidget: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [FacilityDataContent()],
              ),
              onTap: () {},
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
