import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_safe2bizapp_core/mobile_safe2bizapp_core.dart';
import 'package:safe2biz/app/global/controllers/auth_controller.dart';
import 'package:safe2biz/app/global/core/micro_services/dio_micro_services.dart';
import 'package:safe2biz/app/modules/auth/features/login/presenter/page/page.dart';
import 'package:safe2biz/app/modules/auth/features/settings/presenter/screen/settings_screen.dart';
import 'package:safe2biz/app/modules/auth/features/settings/presenter/settings_page.dart';
import 'package:safe2biz/app/modules/dmt/companyBodyIntra.dart';
import 'package:safe2biz/app/modules/splash/presenter/bloc/bloc.dart';
import 'package:safe2biz/app/global/core/core.dart';
import 'package:safe2biz/app/global/core/routing/routing.dart';
import 'package:safe2biz/app/ui/module_ui.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) async {
        if (state is Successful) {
          final header = GetIt
              .I<DioMicroServices>()
              .msDio
              .options
              .headers;
          GetIt
              .I<DioMicroServices>()
              .msDio
              .options
              .headers = {
            ...header,
            'userLogin': '${state.user.userLogin}@${state.user.enterprise}',
            'userPassword': state.user.password,
            'systemRoot': 'intrasolution',
          };

          final auth = GetIt.I<AuthController>();
          String user = '';
          String pass = '';

          if (auth.user.value != null) {
            user = auth.user.value!.userLogin;
            pass = auth.user.value!.password;
          }

          Navigator.of(context).pushReplacement(
            FadePageRoute(
              newPage: LoginPage(user: user, pass: pass,),
              //    newPage:  CompanyBodyIntra(user_login: '${state.user.userLogin}', user_id: '${state.user.uuid}' ,),
            ),
          );
        }
        if (state is FailureNotHaveSetting) {
          Toast.show(
            description: state.error,
            toastType: ToastType.warning,
          );
          Navigator.of(context).pushReplacement(
            FadePageRoute(
              newPage: const LoginPage(),
            ),
          );
        }
        if (state is FailureHasSession) {
          Navigator.of(context).pushReplacement(
            FadePageRoute(
              newPage: const LoginPage(),
            ),
          );
        }
      },

      child: Scaffold(
        backgroundColor: S2BColors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              UiValues.intraLogoPng,
              width: MediaQuery.of(context).size.width*0.8,
            ),
            const Spacer(),
            const Center(
              child: CircularProgressIndicator(
                color: S2BColors.primaryColor,
              ),
            ),
            const SizedBox(
              height: S2BSpacing.md,
            ),
            TextLabel.labelText(
              'Cargando ...',
              textAlign: TextAlign.center,
              color: S2BColors.silver,
            ),
            const SizedBox(
              height: S2BSpacing.md,
            ),
          ],
        ),
      ),
    );
  }
}
