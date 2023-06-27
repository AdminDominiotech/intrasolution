import 'package:safe2biz/app/modules/auth/features/login/data/models/models.dart';

abstract class LoginApiDatasource {
  Future<UserModel> login(String user);
}
