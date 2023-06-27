import 'package:dartz/dartz.dart';
import 'package:safe2biz/app/global/core/errors/errors.dart';
import 'package:safe2biz/app/modules/auth/features/settings/domain/entities/entities.dart';

abstract class SettingsLocalRepository {
  Future<Either<Failure, Setting>> getSettingFromStorage();
  Future<Either<Failure, bool>> saveSettingStorage(
    Setting setting,
  );
  Future<Either<Failure, bool>> deleteSettingStorage();
}
