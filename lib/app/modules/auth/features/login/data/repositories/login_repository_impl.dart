import 'package:dartz/dartz.dart';
import 'package:safe2biz/app/modules/auth/features/login/data/data.dart';
import 'package:safe2biz/app/modules/auth/features/login/domain/repositories/login_repository.dart';
import 'package:safe2biz/app/global/core/errors/errors.dart';
import 'package:safe2biz/app/global/core/errors/exceptions.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl({required this.remoteDatasource});
  final LoginApiDatasource remoteDatasource;

  @override
  Future<Either<Failure, UserModel>> loginCheck(
    String user,
  ) async {
    try {
      return Right(await remoteDatasource.login(
        user,
      ));
    } on ServerException catch (err) {
      return Left(
        ServerFailure(
          message: err.toString(),
        ),
      );
    } catch (error) {
      return Left(
        AppException(
          message: error.toString(),
        ),
      );
    }
  }
}
