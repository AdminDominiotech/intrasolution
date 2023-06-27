import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_safe2bizapp_core/mobile_safe2bizapp_core.dart';
import 'package:safe2biz/app/global/controllers/controllers.dart';
import 'package:safe2biz/app/modules/auth/features/login/domain/usecases/usecases.dart';
import 'package:safe2biz/app/modules/auth/features/login/presenter/bloc/login_bloc.dart';
import 'package:safe2biz/app/modules/auth/features/login/presenter/page/login_body.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, this.user, this.pass}) : super(key: key);

  final String? user;
  final String? pass;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final auth = GetIt.I<AuthController>();



    final idSede =
        LocalPreferences.prefs?.getString('current_sede_id') ?? '0';
    String user = '';
    String pass = '';

    if (auth.user.value != null) {

      user = auth.user.value!.userLogin;
      pass = auth.user.value!.password;
    }

    return BlocProvider(
      create: (context) => LoginBloc(
        loginCheckUc: GetIt.I<LoginCheckUcImpl>(),
        authController: GetIt.I<AuthController>(),
        // getAccesosLocalUc: GetIt.I<GetAccesosLocalUcImpl>(),
        // saveAccesosLocalUc: GetIt.I<SaveAccesosLocalUcImpl>(),
      )..add(
          InitEv(),
        ),
      child:  LoginBody(user: user, pass: pass,),
    );
  }
}
