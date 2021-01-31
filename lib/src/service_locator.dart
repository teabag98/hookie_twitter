import 'package:get_it/get_it.dart';
import 'package:hookie_twitter/src/network/api_service.dart';
import 'package:hookie_twitter/src/utils/nav_service.dart';
import 'package:hookie_twitter/src/utils/sharedprefsutil.dart';
import 'package:logger/logger.dart';

GetIt sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<Logger>(() => Logger(printer: PrettyPrinter()));

  sl.registerLazySingleton<SharedPrefsUtil>(() => SharedPrefsUtil());

  sl.registerLazySingleton<NavigatorService>(() => NavigatorService());

  sl.registerLazySingleton<ApiService>(() => ApiService());
}
