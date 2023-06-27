// Flutter imports:
import 'package:flutter/material.dart';
import 'package:mobile_safe2bizapp_core/mobile_safe2bizapp_core.dart';
import 'package:safe2biz/app/global/core/errors/errors.dart';
import 'package:safe2biz/app/modules/auth/features/settings/data/models/setting_model.dart';
import 'package:safe2biz/app/modules/auth/features/settings/domain/entities/entities.dart';

// Project imports:

class SettingsController {
  SettingsController({
    required LocalSqlite sqlite,
    //   required SaveSettigLocalUcImpl saveSettigLocalUc,
    // required DeleteSettigLocalUcImpl deleteSettigLocalUc})
  })  : _sqlite = sqlite,
        // _deleteSettigLocalUc = deleteSettigLocalUc,
        //   _saveSettigLocalUc = saveSettigLocalUc,
        super();

  final LocalSqlite _sqlite;
  // final DeleteSettigLocalUcImpl _deleteSettigLocalUc;
  // final SaveSettigLocalUcImpl _saveSettigLocalUc;

  final _setting = ValueNotifier<Setting?>(null);

  Setting? get setting => _setting.value;
  String get getIP => _setting.value!.ip;

  Future<void> delete() async {
    try {
      final db = await _sqlite.database;

      await db.delete(LocalSqlite.TABLE_SETTINGS);
    } catch (e, stackTrace) {
      throw AppException(message: stackTrace.toString());
    }
  }

  Future<bool> save(Setting newSetting) async {
    await delete();
    try {
      final db = await _sqlite.database;

      final result = await db.insert(
        LocalSqlite.TABLE_SETTINGS,
        {'ip': newSetting.ip, 'name_company': newSetting.nameCompany},
      );

      if (result > 0) {
        _setting.value = newSetting;
        return true;
      } else {
        throw const LocalFailure(message: 'Error al guardar ajustes');
      }
    } catch (e, stackTrace) {
      throw AppException(message: stackTrace.toString());
    }
  }

  Future<SettingModel?> getSettingFromStorage() async {
    try {
      final db = await _sqlite.database;

      final result = await db.query(LocalSqlite.TABLE_SETTINGS);

      if (result.isNotEmpty) {
        final newSetting = List.from(result)
            .map((item) => SettingModel.fromJson(item))
            .toList()
            .first;
        _setting.value = newSetting;
        return newSetting;
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      throw AppException(message: stackTrace.toString());
    }
  }
}
