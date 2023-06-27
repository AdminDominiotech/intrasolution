import 'package:dartz/dartz.dart';
import 'package:safe2biz/app/modules/auth/features/login/domain/entities/entities.dart';
import 'package:safe2biz/app/modules/auth/features/login/domain/repositories/repositories.dart';
import 'package:safe2biz/app/global/core/errors/errors.dart';

abstract class SaveAccesosLocalUc<Output, Input> {
  Future<Either<Failure, Output>> call(List<Acceso> accesos);
}

class SaveAccesosLocalUcImpl implements SaveAccesosLocalUc<bool, dynamic> {
  SaveAccesosLocalUcImpl({required LoginLocalRepository local})
      : _local = local;

  final LoginLocalRepository _local;

  @override
  Future<Either<Failure, bool>> call(List<Acceso> accesos) async =>
      await _local.saveAccesosToLocal(accesos);
}
