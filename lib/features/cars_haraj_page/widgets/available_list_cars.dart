import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/pages_widgets/general_widgets/navigate_to_page_widget.dart';
import '../../../../../core/theming/colors.dart';
import '../../../../../features/cars_haraj_page/logic/get_all_harage_cubit/get_all_harage_cubit.dart';
import '../../../../../features/cars_haraj_page/logic/get_all_harage_cubit/get_all_harage_state.dart';
import '../../../../../features/cars_haraj_page/ui/details_harag_page/details_harag_page.dart';
import '../../../../../features/cars_haraj_page/widgets/available_cars.dart';

class AvailableListCars extends StatelessWidget {
  const AvailableListCars({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllHarageCubit, GetAllHarageState>(
      builder: (context, state) {

        if (state is GetAllHarageError) {
          return Center(child: Text(state.message));
        }

        List cars = [];

        if (state is GetAllHarageSuccess) {
          cars = state.response.data ?? [];
        }

        return Stack(
          children: [
            Column(
              children: [
                ...List.generate(
                  cars.length,
                      (index) {
                    final car = cars[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 19),
                      child: AvailableCars(
                        id: car.id.toString(),
                        releaseDate: car.releaseDate,
                        carImage: car.car?.carImage,
                        brandImage: car.car?.brandImage,
                        addresstext: car.addressText,
                        isSold: car.isSold ?? false,
                        isNew: car.isNew ?? false,
                        brandName: car.car?.getBrand(context),
                        price: car.price.toString(),

                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            NavigateToPageWidget(
                              DetailsHaragPage(car: car),
                            ),
                          );

                          if (result == true && context.mounted) {
                            context.read<GetAllHarageCubit>()
                                .getAllHarage(page: 1);
                          }
                        },
                      ),
                    );
                  },
                ),
              ],
            ),

            if (state is GetAllHarageLoading)
              Container(
                color: AppColors.blackColor,
                child: const Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
          ],
        );
      },
    );
  }
}