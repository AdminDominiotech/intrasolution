import 'package:dartz/dartz.dart';
import 'package:safe2biz/app/modules/auth/features/login/domain/entities/entities.dart';
import 'package:safe2biz/app/modules/auth/features/login/domain/repositories/repositories.dart';
import 'package:safe2biz/app/global/core/errors/errors.dart';

abstract class LoginCheckUc<Output, Input> {
  Future<Either<Failure, Output>> call(
    String user,
  );
}

class LoginCheckUcImpl implements LoginCheckUc<User, dynamic> {
  LoginCheckUcImpl({required LoginRepository loginRepository})
      : _repository = loginRepository;

  final LoginRepository _repository;

  @override
  Future<Either<Failure, User>> call(
    String user,
  ) async =>
      await _repository.loginCheck(
        user,
      );
}
