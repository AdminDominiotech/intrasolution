import 'package:dartz/dartz.dart';
import 'package:safe2biz/app/modules/auth/features/login/domain/entities/entities.dart';
import 'package:safe2biz/app/global/core/errors/errors.dart';

abstract class SqliteRepository {
  Future<Either<Failure, bool>> login(User user);
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, User>> hasSession();
}
