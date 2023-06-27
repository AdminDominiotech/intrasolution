import 'package:dartz/dartz.dart';
import 'package:safe2biz/app/global/core/errors/errors.dart';
import 'package:safe2biz/app/global/core/errors/exceptions.dart';
import 'package:safe2biz/app/modules/auth/features/settings/data/datasource/settings_local_datasource.dart';
import 'package:safe2biz/app/modules/auth/features/settings/domain/entities/entities.dart';
import 'package:safe2biz/app/modules/auth/features/settings/domain/repositories/i_settings.dart';

class SettingsLocalRepositoryImpl implements SettingsLocalRepository {
  SettingsLocalRepositoryImpl({required this.localDatasource});
  final SettingsLocalDatasource localDatasource;

  @override
  Future<Either<Failure, bool>> deleteSettingStorage() async {
    try {
      return Right(await localDatasource.deleteSettingStorage());
    } on ServerException catch (err) {
      return Left(
        ServerFailure(
          message: err.toString(),
        ),
      );
    } catch (error) {
      return const Left(
        AppException(),
      );
    }
  }

  @override
  Future<Either<Failure, Setting>> getSettingFromStorage() async {
    try {
      return Right(await localDatasource.getSettingFromStorage());
    } on ServerException catch (err) {
      return Left(
        ServerFailure(
          message: err.toString(),
        ),
      );
    } catch (error) {
      return const Left(
        AppException(),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> saveSettingStorage(Setting setting) async {
    try {
      return Right(await localDatasource.saveSettingStorage(setting));
    } on ServerException catch (err) {
      return Left(
        ServerFailure(
          message: err.toString(),
        ),
      );
    } catch (error) {
      return const Left(
        AppException(),
      );
    }
  }
}
