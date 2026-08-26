import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/theming/colors.dart';
import '../../../../../../../features/cars_haraj_page/presentation/bloc/harag_cubit/harag_cubit.dart';
import '../../../../../../../features/cars_haraj_page/presentation/ui/page_details_harag/list_view_page_details_harag.dart';

class PageDetailsHarag extends StatelessWidget {
  const PageDetailsHarag({
    super.key,
    required this.harageId,
  });

  final int harageId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HaragCubit()
        ..getHarageDetails(
          harageId: harageId,
        ),
      child:Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: ListViewPageDetailsHarag(
                harageId:harageId ,
              ),
            ),
            )
          ),
        ),
      );
  }}