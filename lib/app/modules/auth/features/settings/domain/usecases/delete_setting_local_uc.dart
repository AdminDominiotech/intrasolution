import 'package:dartz/dartz.dart';
import 'package:safe2biz/app/global/core/errors/errors.dart';
import 'package:safe2biz/app/modules/auth/features/settings/domain/repositories/repositories.dart';

abstract class DeleteSettigLocalUc<Output, Input> {
  Future<Either<Failure, Output>> call();
}

class DeleteSettigLocalUcImpl implements DeleteSettigLocalUc<bool, dynamic> {
  DeleteSettigLocalUcImpl({
    required SettingsLocalRepository repository,
  }) : _repository = repository;

  final SettingsLocalRepository _repository;

  @override
  Future<Either<Failure, bool>> call() async =>
      await _repository.deleteSettingStorage();
}
