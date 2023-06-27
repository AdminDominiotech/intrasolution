import 'package:mobile_safe2bizapp_core/mobile_safe2bizapp_core.dart';
import 'package:safe2biz/app/global/core/errors/errors.dart';
import 'package:safe2biz/app/modules/auth/features/login/data/data.dart';
import 'package:safe2biz/app/modules/auth/features/login/domain/entities/acceso.dart';

class LoginLocal implements LoginLocalDatasource {
  LoginLocal({required this.sqlite});
  final LocalSqlite sqlite;

  @override
  Future<List<Acceso>> getAccesosFromLocal() async {
    try {
      final db = await sqlite.database;

      final result = await db.query(LocalSqlite.TABLE_ACCESOS);
      if (result.isNotEmpty) {
        final model = List.from(result)
            .map((item) => AccesoModel.fromJson(item))
            .toList();
        return model;
      } else {
        return [];
      }
    } catch (e, stackTrace) {
      throw AppException(message: stackTrace.toString());
    }
  }

  @override
  Future<bool> saveAccesosToLocal(List<Acceso> accesos) async {
    try {
      final db = await sqlite.database;
      await db.delete(LocalSqlite.TABLE_ACCESOS);

      final batch = db.batch();

      for (final i in accesos) {
        batch.insert(LocalSqlite.TABLE_ACCESOS, {

          'modulos': i.modulos,
        });
      }

      await batch.commit(noResult: true);

      return true;
    } catch (e, stackTrace) {
      throw AppException(message: stackTrace.toString());
    }
  }
}
