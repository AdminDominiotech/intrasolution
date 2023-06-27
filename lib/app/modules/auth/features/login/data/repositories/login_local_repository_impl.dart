import 'package:dartz/dartz.dart';
import 'package:safe2biz/app/modules/auth/features/login/data/data.dart';
import 'package:safe2biz/app/global/core/errors/errors.dart';
import 'package:safe2biz/app/global/core/errors/exceptions.dart';
import 'package:safe2biz/app/modules/auth/features/login/domain/entities/acceso.dart';
import 'package:safe2biz/app/modules/auth/features/login/domain/repositories/repositories.dart';

class LoginLocalRepositoryImpl implements LoginLocalRepository {
  LoginLocalRepositoryImpl({required this.localDatasource});
  final LoginLocalDatasource localDatasource;

  @override
  Future<Either<Failure, List<Acceso>>> getAccesosFromLocal() async {
    try {
      return Right(await localDatasource.getAccesosFromLocal());
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

  @override
  Future<Either<Failure, bool>> saveAccesosToLocal(List<Acceso> accesos) async {
    try {
      return Right(
        await localDatasource.saveAccesosToLocal(
          accesos,
        ),
      );
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
