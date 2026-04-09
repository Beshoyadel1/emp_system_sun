import 'package:get_it/get_it.dart';
import '../../../../core/cubit/app_cubit/app_cubit.dart';

import 'language/language_cubit/language_cubit.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton<LanguageCubit>(() => LanguageCubit());
  getIt.registerLazySingleton<AppCubit>(() => AppCubit());
}
