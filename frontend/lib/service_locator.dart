import 'package:get_it/get_it.dart';
import 'package:frontend/src/screens/tabs_page_model.dart';
import 'src/screens/main/home/home_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => TabsPageModel());
  locator.registerFactory(() => HomeModel());
}
