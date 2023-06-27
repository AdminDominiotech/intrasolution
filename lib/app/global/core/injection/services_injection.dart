import 'package:get_it/get_it.dart';

import 'package:mobile_safe2bizapp_core/mobile_safe2bizapp_core.dart';

import 'package:safe2biz/app/modules/auth/features/login/external/api/api.dart';
import 'package:safe2biz/app/modules/auth/features/login/external/local/local.dart';
import 'package:safe2biz/app/modules/auth/features/settings/external/local/local.dart';

import 'package:safe2biz/app/modules/splash/external/local/local.dart';
import 'package:safe2biz/app/global/core/micro_services/dio_micro_services.dart';

final _i = GetIt.instance;

//TODO: INYECCION DE SEVICIOS
class ServicesInjection {
  static List<void> list = [
    // SERVICES
    _i.registerLazySingleton<DioMicroServices>(() => DioMicroServices()),
    _i.registerLazySingleton<LocalSqlite>(() => LocalSqlite()),

    // SERVICES SPLASH
    _i.registerLazySingleton<LocalSqliteApi>(
      () => LocalSqliteApi(sqlite: _i.get<LocalSqlite>()),
    ),

    // SERVICES LOGIN
    _i.registerLazySingleton<LoginApi>(
      () => LoginApi(dioMicroServices: _i.get<DioMicroServices>()),
    ),
    _i.registerLazySingleton<LoginLocal>(
      () => LoginLocal(sqlite: _i.get<LocalSqlite>()),
    ),

    // SERVICES SETTINGS
    _i.registerLazySingleton<SettingsLocal>(
      () => SettingsLocal(sqlite: _i.get<LocalSqlite>()),
    ),
  ];
}
