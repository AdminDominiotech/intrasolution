import 'package:get_it/get_it.dart';

import 'package:safe2biz/app/modules/auth/features/login/external/local/local.dart';

import 'package:safe2biz/app/modules/auth/features/settings/data/implementations/implementations.dart';
import 'package:safe2biz/app/modules/auth/features/settings/domain/repositories/repositories.dart';
import 'package:safe2biz/app/modules/auth/features/settings/external/local/local.dart';

import 'package:safe2biz/app/modules/auth/features/login/data/data.dart';
import 'package:safe2biz/app/modules/auth/features/login/domain/repositories/repositories.dart';
import 'package:safe2biz/app/modules/auth/features/login/external/api/api.dart';

import 'package:safe2biz/app/modules/splash/data/repositories/repositories.dart';
import 'package:safe2biz/app/modules/splash/domain/repositories/repositories.dart';
import 'package:safe2biz/app/modules/splash/external/local/local.dart';

final _i = GetIt.instance;

//TODO: INYECCION DE REPOSITORIOS
class RepositoriesInjection {
  static List<void> list = [
    // REPOSITORIES SPLASH
    _i.registerLazySingleton<SqliteRepository>(
      () => SqliteRepositoryImpl(remoteDatasource: _i.get<LocalSqliteApi>()),
    ),

    // REPOSITORIES LOGIN
    _i.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(remoteDatasource: _i.get<LoginApi>()),
    ),
    _i.registerLazySingleton<LoginLocalRepository>(
      () => LoginLocalRepositoryImpl(localDatasource: _i.get<LoginLocal>()),
    ),

    // REPOSITORIES SETTINGS
    _i.registerLazySingleton<SettingsLocalRepository>(
      () => SettingsLocalRepositoryImpl(
        localDatasource: _i.get<SettingsLocal>(),
      ),
    ),
  ];
}
