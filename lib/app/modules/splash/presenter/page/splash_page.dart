import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:safe2biz/app/global/controllers/controllers.dart';
import 'package:safe2biz/app/global/controllers/settings_controller.dart';
import 'package:safe2biz/app/modules/splash/presenter/bloc/splash_bloc.dart';
import 'package:safe2biz/app/modules/splash/presenter/page/splash_body.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(
        authController: GetIt.I<AuthController>(),
        settingsController: GetIt.I<SettingsController>(),
      )..add(InitEv()),
      child: const SplashBody(),
    );
  }
}
