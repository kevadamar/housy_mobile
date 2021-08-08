import 'package:dev_mobile/utils/location_utils.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
void setupLocator() async {
  //* Register as singleton

  await locator.registerSingleton(LocationUtils());
}
