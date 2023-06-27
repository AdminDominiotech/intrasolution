import 'package:mobile_safe2bizapp_core/mobile_safe2bizapp_core.dart';
import 'package:safe2biz/app/modules/auth/features/login/data/models/user_model.dart';
import 'package:safe2biz/app/modules/auth/features/login/domain/entities/entities.dart';
import 'package:safe2biz/app/modules/splash/data/datasource/sqlite_datasource.dart';
import 'package:safe2biz/app/global/core/errors/errors.dart';

class LocalSqliteApi implements SqliteDataSource {
  LocalSqliteApi({required this.sqlite});
  final LocalSqlite sqlite;

  @override
  Future<UserModel> hasSession() async {
    try {
      final db = await sqlite.database;

      final respUser = await db.query('user');
      if (respUser.isNotEmpty) {
        return UserModel.fromJson(respUser.last);
      } else {
        throw const LocalFailure(message: 'Usuario no logeado');
      }
    } catch (e, stackTrace) {
      throw AppException(message: stackTrace.toString());
    }
  }

  @override
  Future<bool> login(User user) async {
    try {
      final db = await sqlite.database;
      await db.delete('user');
      final results1 = await db.insert('user', {
        'id': 1,
        'SC_USER_ID': user.uuid,
        'USER_LOGIN': user.userLogin,
        'nombre_empleado': user.name,
        'ENTERPRISE': user.enterprise,
      });

      if (results1 == 1) {
        return true;
      } else {
        throw const LocalFailure(message: 'Error al guardar su sesión');
      }
    } catch (e, stackTrace) {
      throw AppException(message: stackTrace.toString());
    }
  }

  @override
  Future<bool> logout() async {
    try {
      final db = await sqlite.database;
      await db.delete('user');
      return true;
    } catch (e, stackTrace) {
      throw AppException(message: stackTrace.toString());
    }
  }
}
