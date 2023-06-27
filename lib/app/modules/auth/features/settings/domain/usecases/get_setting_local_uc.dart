import 'package:dartz/dartz.dart';
import 'package:safe2biz/app/global/core/errors/errors.dart';
import 'package:safe2biz/app/modules/auth/features/settings/domain/entities/entities.dart';
import 'package:safe2biz/app/modules/auth/features/settings/domain/repositories/repositories.dart';

abstract class GetSettigLocalUc<Output, Input> {
  Future<Either<Failure, Output>> call();
}

class GetSettigLocalUcImpl implements GetSettigLocalUc<Setting, dynamic> {
  GetSettigLocalUcImpl({
    required SettingsLocalRepository repository,
  }) : _repository = repository;

  final SettingsLocalRepository _repository;

  @override
  Future<Either<Failure, Setting>> call() async =>
      await _repository.getSettingFromStorage();
}
