import 'package:safe2biz/app/modules/auth/features/login/data/datasource/datasource.dart';
import 'package:safe2biz/app/modules/auth/features/login/data/models/user_model.dart';
import 'package:safe2biz/app/global/core/errors/exceptions.dart';
import 'package:safe2biz/app/global/core/micro_services/dio_micro_services.dart';

class LoginApi implements LoginApiDatasource {
  LoginApi({required this.dioMicroServices});
  final DioMicroServices dioMicroServices;

  @override
  Future<UserModel> login(String user) async {
    final result = await dioMicroServices.msDio.post(
      '/pr_ws_sc_user_v2',
      queryParameters: {
        'user_login': user,
      },
    );

    if (result.statusCode == 200) {
      final data = result.data['data'];
      final user = List.from(data)
          .map((item) => UserModel.fromJson(item))
          .toList()
          .first;

      return user;
    } else {
      throw ServerException(
        statusCode: result.statusCode,
      );
    }
  }
}
