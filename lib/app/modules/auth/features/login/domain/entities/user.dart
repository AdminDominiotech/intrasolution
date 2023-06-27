import 'package:equatable/equatable.dart';
import 'package:safe2biz/app/modules/auth/features/login/domain/entities/entities.dart';

// ignore: must_be_immutable
abstract class User extends Equatable {
  User({
    required this.uuid,
    required this.name,
    required this.userLogin,
    required this.enterprise,
    required this.password,
    required this.fbEmpleadoId,
    required this.urlExt,
    required this.urlApp,
    required this.arroba,
    required this.accesos,
  });


  final String uuid;
  final String name;
  final String userLogin;
  final String enterprise;
  final String password;
  final String fbEmpleadoId;
  final String urlExt;
  final String urlApp;
  final String arroba;
  final String accesos;

  Map<String, dynamic> toJson();

  @override
  List<Object> get props => [
        uuid,
        name,
        userLogin,
        enterprise,
        password,
        fbEmpleadoId,
        urlExt,
        urlApp,
        arroba,
        accesos,
      ];
}
