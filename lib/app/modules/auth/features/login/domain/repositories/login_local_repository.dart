import 'package:dartz/dartz.dart';
import 'package:safe2biz/app/modules/auth/features/login/domain/entities/entities.dart';
import 'package:safe2biz/app/global/core/errors/errors.dart';

abstract class LoginLocalRepository {
  Future<Either<Failure, List<Acceso>>> getAccesosFromLocal();
  Future<Either<Failure, bool>> saveAccesosToLocal(List<Acceso> accesos);
}
