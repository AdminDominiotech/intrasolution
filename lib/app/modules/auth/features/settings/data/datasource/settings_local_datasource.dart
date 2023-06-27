import 'package:safe2biz/app/modules/auth/features/settings/data/models/setting_model.dart';
import 'package:safe2biz/app/modules/auth/features/settings/domain/entities/entities.dart';

abstract class SettingsLocalDatasource {
  Future<SettingModel> getSettingFromStorage();
  Future<bool> saveSettingStorage(Setting setting);
  Future<bool> deleteSettingStorage();
}
