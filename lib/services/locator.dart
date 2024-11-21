import 'package:get_it/get_it.dart';
import 'package:tt_18/services/config_service.dart';
import 'package:tt_18/services/network_service.dart';

class Locator {
  static Future<void> setup() async {
    GetIt.instance.registerLazySingletonAsync<ConfigService>(()=> ConfigService().init());
    await GetIt.instance.isReady<ConfigService>();
    GetIt.instance.registerSingleton<NetworkService>(NetworkService());
  }
}
