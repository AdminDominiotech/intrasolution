import 'package:get_it/get_it.dart';

import 'package:safe2biz/app/modules/auth/features/login/domain/repositories/repositories.dart';
import 'package:safe2biz/app/modules/auth/features/login/domain/usecases/usecases.dart';
import 'package:safe2biz/app/modules/auth/features/settings/domain/repositories/repositories.dart';
import 'package:safe2biz/app/modules/auth/features/settings/domain/usecases/usecases.dart';


final _i = GetIt.instance;

//TODO: INYECCION DE CASOS DE USOS
class UseCasesInjection {
  static List<void> list = [
    // USECASES
    // SPLASH
    // _i.registerLazySingleton<LocalLoginUcImpl>(
    //   () => LocalLoginUcImpl(sqliteRepository: _i.get<SqliteRepository>()),
    // ),
    // _i.registerLazySingleton<HasSessionUcImpl>(
    //   () => HasSessionUcImpl(sqliteRepository: _i.get<SqliteRepository>()),
    // ),
    // _i.registerLazySingleton<LocalLogoutUcImpl>(
    //   () => LocalLogoutUcImpl(sqliteRepository: _i.get<SqliteRepository>()),
    // ),

    // LOGIN
    _i.registerLazySingleton<LoginCheckUcImpl>(
      () => LoginCheckUcImpl(loginRepository: _i.get<LoginRepository>()),
    ),
    _i.registerLazySingleton<GetAccesosLocalUcImpl>(
      () => GetAccesosLocalUcImpl(local: _i.get<LoginLocalRepository>()),
    ),
    _i.registerLazySingleton<SaveAccesosLocalUcImpl>(
      () => SaveAccesosLocalUcImpl(local: _i.get<LoginLocalRepository>()),
    ),



    // SETTINGS
    _i.registerLazySingleton<SaveSettigLocalUcImpl>(
      () => SaveSettigLocalUcImpl(
        repository: _i.get<SettingsLocalRepository>(),
      ),
    ),
    _i.registerLazySingleton<GetSettigLocalUcImpl>(
      () => GetSettigLocalUcImpl(
        repository: _i.get<SettingsLocalRepository>(),
      ),
    ),
    _i.registerLazySingleton<DeleteSettigLocalUcImpl>(
      () => DeleteSettigLocalUcImpl(
        repository: _i.get<SettingsLocalRepository>(),
      ),
    ),
  ];
}
