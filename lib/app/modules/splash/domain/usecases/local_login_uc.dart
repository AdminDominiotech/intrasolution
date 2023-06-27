// import 'package:dartz/dartz.dart';
// import 'package:safe2biz/app/modules/auth/features/login/domain/entities/entities.dart';
// import 'package:safe2biz/app/modules/splash/domain/repositories/sqlite_repository.dart';
// import 'package:safe2biz/app/global/core/errors/errors.dart';

// abstract class LocalLoginUc<Output, Input> {
//   Future<Either<Failure, Output>> call(
//     User user,
//   );
// }

// class LocalLoginUcImpl implements LocalLoginUc<bool, dynamic> {
//   LocalLoginUcImpl({required SqliteRepository sqliteRepository})
//       : _repository = sqliteRepository;

//   final SqliteRepository _repository;

//   @override
//   Future<Either<Failure, bool>> call(
//     User user,
//   ) async =>
//       await _repository.login(user);
// }
