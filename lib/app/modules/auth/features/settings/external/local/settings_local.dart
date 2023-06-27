import 'package:mobile_safe2bizapp_core/mobile_safe2bizapp_core.dart';
import 'package:safe2biz/app/global/core/errors/errors.dart';
import 'package:safe2biz/app/modules/auth/features/settings/data/datasource/settings_local_datasource.dart';
import 'package:safe2biz/app/modules/auth/features/settings/domain/entities/setting.dart';
import 'package:safe2biz/app/modules/auth/features/settings/data/models/setting_model.dart';

class SettingsLocal implements SettingsLocalDatasource {
  SettingsLocal({required this.sqlite});
  final LocalSqlite sqlite;

  @override
  Future<bool> deleteSettingStorage() async {
    try {
      final db = await sqlite.database;

      final result = await db.delete(LocalSqlite.TABLE_SETTINGS);

      if (result == 1) {
        return true;
      } else {
        throw const LocalFailure(
          message: 'Error al eliminar los ajustes',
        );
      }
    } catch (e, stackTrace) {
      throw AppException(message: stackTrace.toString());
    }
  }

  @override
  Future<SettingModel> getSettingFromStorage() async {
    try {
      final db = await sqlite.database;

      final result = await db.query(LocalSqlite.TABLE_SETTINGS);

      if (result.isNotEmpty) {
        final setting = List.from(result)
            .map((item) => SettingModel.fromJson(item))
            .toList()
            .first;
        return setting;
      } else {
        return SettingModel.fromJson({});
      }
    } catch (e, stackTrace) {
      throw AppException(message: stackTrace.toString());
    }
  }

  @override
  Future<bool> saveSettingStorage(Setting setting) async {
    try {
      final db = await sqlite.database;

      final result = await db.insert(LocalSqlite.TABLE_SETTINGS,
          {'ip': setting.ip, 'name_company': setting.nameCompany});

      if (result > 0) {
        return true;
      } else {
        throw const LocalFailure(message: 'Error al guardar ajustes');
      }
    } catch (e, stackTrace) {
      throw AppException(message: stackTrace.toString());
    }
  }
}
