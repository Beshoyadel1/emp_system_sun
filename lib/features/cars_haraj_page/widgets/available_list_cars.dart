import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../features/cars_haraj_page/logic/get_all_harage_cubit/get_all_harage_cubit.dart';
import '../../../../../features/cars_haraj_page/logic/get_all_harage_cubit/get_all_harage_state.dart';
import '../../../../../features/cars_haraj_page/widgets/available_cars.dart';

class AvailableListCars extends StatelessWidget {
  const AvailableListCars({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllHarageCubit, GetAllHarageState>(
      builder: (context, state) {

        if (state is GetAllHarageLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }

        if (state is GetAllHarageError) {
          return Center(child: Text(state.message));
        }

        if (state is GetAllHarageSuccess) {
          final cars = state.response.data ?? [];

          return Column(
            children: [
              ...List.generate(
                cars.length,
                    (index) {
                  final car = cars[index];

                  final isEnglish =
                      Localizations.localeOf(context).languageCode == 'en';

                  final brandNameTitle = isEnglish
                      ? (car.car?.brandLatinName ?? "")
                      : (car.car?.brandName ?? "");

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 19),
                    child: AvailableCars(
                      id: car.id.toString(),
                      releaseDate: car.releaseDate,
                      carImage: car.car?.carImage,
                      brandImage: car.car?.brandImage,
                      description: car.description,
                      isSold: car.isSold ?? false,
                      isNew: car.isNew ?? false,
                      brandName: brandNameTitle,
                      price: car.price.toString(),
                      onTap: () {},
                    ),
                  );
                },
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}