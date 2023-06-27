import 'package:dartz/dartz.dart';
import 'package:safe2biz/app/global/core/errors/errors.dart';
import 'package:safe2biz/app/modules/auth/features/settings/domain/entities/entities.dart';
import 'package:safe2biz/app/modules/auth/features/settings/domain/repositories/repositories.dart';

abstract class SaveSettigLocalUc<Output, Input> {
  Future<Either<Failure, Output>> call(Setting setting);
}

class SaveSettigLocalUcImpl implements SaveSettigLocalUc<bool, dynamic> {
  SaveSettigLocalUcImpl({
    required SettingsLocalRepository repository,
  }) : _repository = repository;

  final SettingsLocalRepository _repository;

  @override
  Future<Either<Failure, bool>> call(Setting setting) async =>
      await _repository.saveSettingStorage(setting);
}
