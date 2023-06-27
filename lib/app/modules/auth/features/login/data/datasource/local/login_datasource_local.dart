import 'package:safe2biz/app/modules/auth/features/login/domain/entities/entities.dart';

abstract class LoginLocalDatasource {
  Future<List<Acceso>> getAccesosFromLocal();
  //Todo Ok
  Future<bool> saveAccesosToLocal(List<Acceso> accesos);
}
