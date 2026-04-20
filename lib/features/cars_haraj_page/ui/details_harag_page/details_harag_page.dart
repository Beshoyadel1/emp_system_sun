import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/api_functions/harage/get_all_harage_model/harage_data.dart';
import '../../../../../core/language/language_constant.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/fonts.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../features/cars_haraj_page/logic/delete_harage_cubit/delete_harage_cubit.dart';
import '../../../../../features/cars_haraj_page/logic/update_harage_cubit/update_harage_cubit.dart';
import '../../../../../features/cars_haraj_page/ui/details_harag_page/widgets/available_cars_details.dart';
import '../../../../../features/cars_haraj_page/ui/details_harag_page/widgets/car_specifications.dart';
import '../../../../../features/cars_haraj_page/ui/details_harag_page/widgets/delete_dialog.dart';
import '../../../../../features/cars_haraj_page/ui/details_harag_page/widgets/edit_harag_dialog.dart';

class DetailsHaragPage extends StatelessWidget {
  final HarageData car;

  const DetailsHaragPage({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColors.scaffoldColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 10,
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const TextInAppWidget(
                  text:AppLanguageKeys.viewAllOrderDetails,
                  textSize: 18,
                  fontWeightIndex: FontSelectionData.regularFontFamily,
                  textColor:AppColors.blackColor,
                ),
                // Wrap(
                //   spacing: 10,
                //   runSpacing: 10,
                //   alignment: WrapAlignment.end,
                //   crossAxisAlignment: WrapCrossAlignment.center,
                //   children: [
                //     ButtonEditDeleteSettingWidget(
                //       onTap: () {
                //         showDialog(
                //           context: context,
                //           builder: (_) => BlocProvider(
                //             create: (_) => UpdateHarageCubit(),
                //             child: EditHaragDialog(car: car),
                //           ),
                //         );
                //       },
                //     ),
                //     ButtonEditDeleteSettingWidget(
                //       isDelete: true,
                //       onTap: () {
                //         showDialog(
                //           context: context,
                //           builder: (_) => BlocProvider(
                //             create: (_) => DeleteHarageCubit(),
                //             child: DeleteDialog(carId: car.id!),
                //           ),
                //         );
                //       },
                //     ),
                //   ],
                // ),
              ],
            ),
            AvailableCarsDetails(
              id: car.id.toString(),
              releaseDate: car.releaseDate,
              carImage: car.car?.carImage,
              brandImage: car.car?.brandImage,
              addresstext: car.addressText,
              isSold: car.isSold ?? false,
              isNew: car.isNew ?? false,
              brandName: car.car?.getBrand(context),
              price: car.price.toString(),
              kilometers: car.kilometers.toString(),
              userName: car.user?.getName(context),
            ),
            CarSpecifications(
              carDetails: car.description.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
