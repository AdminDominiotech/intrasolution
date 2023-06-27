import 'package:safe2biz/app/modules/auth/features/login/data/models/user_model.dart';
import 'package:safe2biz/app/modules/auth/features/login/domain/entities/entities.dart';

abstract class SqliteDataSource {
  Future<UserModel> hasSession();
  Future<bool> login(User user);
  Future<bool> logout();
}
