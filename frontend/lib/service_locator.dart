import 'package:frontend/src/screens/auth/login_user/login_user_model.dart';
import 'package:frontend/src/screens/auth/register_user/register_user_model.dart';
import 'package:frontend/src/screens/main/preview_order/preview_order_model.dart';
import 'package:get_it/get_it.dart';
import 'package:frontend/src/screens/tabs_page_model.dart';
import 'src/screens/main/home/home_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => TabsPageModel());
  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => LoginUserModel());
  locator.registerFactory(() => RegisterUserModel());
  locator.registerFactory(() => PreviewOrderModel());
}
