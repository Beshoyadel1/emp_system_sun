import 'package:emp_system_sun/features/service_emp_view/presentation/cubit/employee_services_cubit/employee_services_cubit.dart';
import 'package:emp_system_sun/features/technical_support/data/datasource/employee_chat_repository.dart';
import 'package:emp_system_sun/features/technical_support/presentation/bloc/employee_chat_cubit/employee_chat_cubit.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/cubit/app_cubit/app_cubit.dart';
import 'language/language_cubit/language_cubit.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton<LanguageCubit>(() => LanguageCubit());
  getIt.registerLazySingleton<AppCubit>(() => AppCubit());
  getIt.registerLazySingleton<EmployeeServicesCubit>(() => EmployeeServicesCubit());
  getIt.registerLazySingleton<EmployeeChatRepository>(
    () => const EmployeeChatRepository(),
  );
  getIt.registerLazySingleton<EmployeeChatCubit>(
    () => EmployeeChatCubit(chatRepository: getIt<EmployeeChatRepository>()),
  );
}
