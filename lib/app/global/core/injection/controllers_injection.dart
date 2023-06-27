import 'package:get_it/get_it.dart';
import 'package:mobile_safe2bizapp_core/mobile_safe2bizapp_core.dart';
import 'package:safe2biz/app/global/controllers/controllers.dart';
import 'package:safe2biz/app/global/controllers/settings_controller.dart';

final _i = GetIt.instance;

//TODO: INYECCION DE CONTROLLERS
class ControllersInjection {
  static List<void> list = [
    // AUTH
    _i.registerLazySingleton<AuthController>(
      () => AuthController(sqlite: _i.get<LocalSqlite>()),
    ),
    //APP
    _i.registerLazySingleton<AppController>(
      () => AppController(),
    ),
    //SETTINGS
    _i.registerLazySingleton<SettingsController>(
      () => SettingsController(
        sqlite: _i.get<LocalSqlite>(),
      ),
    ),
  ];
}
