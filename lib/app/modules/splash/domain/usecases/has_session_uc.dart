import 'package:dartz/dartz.dart';
import 'package:safe2biz/app/modules/auth/features/login/domain/entities/entities.dart';
import 'package:safe2biz/app/modules/splash/domain/repositories/sqlite_repository.dart';
import 'package:safe2biz/app/global/core/errors/errors.dart';

abstract class HasSessionUc<Output, Input> {
  Future<Either<Failure, Output>> call();
}

class HasSessionUcImpl implements HasSessionUc<User, dynamic> {
  HasSessionUcImpl({required SqliteRepository sqliteRepository})
      : _repository = sqliteRepository;

  final SqliteRepository _repository;

  @override
  Future<Either<Failure, User>> call() async => await _repository.hasSession();
}
