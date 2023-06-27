import 'package:dartz/dartz.dart';
import 'package:safe2biz/app/modules/auth/features/login/domain/entities/entities.dart';
import 'package:safe2biz/app/modules/auth/features/login/domain/repositories/repositories.dart';
import 'package:safe2biz/app/global/core/errors/errors.dart';

abstract class GetAccesosLocalUc<Output, Input> {
  Future<Either<Failure, Output>> call();
}

class GetAccesosLocalUcImpl
    implements GetAccesosLocalUc<List<Acceso>, dynamic> {
  GetAccesosLocalUcImpl({required LoginLocalRepository local}) : _local = local;

  final LoginLocalRepository _local;

  @override
  Future<Either<Failure, List<Acceso>>> call() async =>
      await _local.getAccesosFromLocal();
}
