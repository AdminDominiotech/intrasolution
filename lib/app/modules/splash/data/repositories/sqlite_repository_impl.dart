import 'package:safe2biz/app/modules/auth/features/login/data/models/user_model.dart';
import 'package:safe2biz/app/modules/auth/features/login/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:safe2biz/app/modules/splash/data/datasource/sqlite_datasource.dart';
import 'package:safe2biz/app/modules/splash/domain/repositories/sqlite_repository.dart';
import 'package:safe2biz/app/global/core/errors/errors.dart';
import 'package:safe2biz/app/global/core/errors/exceptions.dart';

class SqliteRepositoryImpl implements SqliteRepository {
  SqliteRepositoryImpl({required this.remoteDatasource});
  final SqliteDataSource remoteDatasource;

  @override
  Future<Either<Failure, bool>> login(User user) async {
    try {
      return Right(await remoteDatasource.login(user));
    } on LocalException catch (err) {
      return Left(
        LocalFailure(
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
  Future<Either<Failure, UserModel>> hasSession() async {
    try {
      return Right(await remoteDatasource.hasSession());
    } on LocalException catch (err) {
      return Left(
        LocalFailure(
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
  Future<Either<Failure, bool>> logout() async {
    try {
      return Right(await remoteDatasource.logout());
    } on LocalException catch (err) {
      return Left(
        LocalFailure(
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
