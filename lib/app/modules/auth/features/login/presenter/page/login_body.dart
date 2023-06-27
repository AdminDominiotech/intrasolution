import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_safe2bizapp_core/mobile_safe2bizapp_core.dart';

import 'package:safe2biz/app/global/controllers/settings_controller.dart';
import 'package:safe2biz/app/global/core/micro_services/dio_micro_services.dart';
import 'package:safe2biz/app/modules/auth/features/login/presenter/bloc/login_bloc.dart';
import 'package:safe2biz/app/modules/auth/features/login/presenter/widgets/widgets.dart';
import 'package:safe2biz/app/global/core/core.dart';
import 'package:safe2biz/app/modules/auth/features/settings/presenter/screen/settings_screen.dart';
import 'package:safe2biz/app/modules/auth/features/settings/presenter/settings_page.dart';
import 'package:safe2biz/app/modules/dmt/companyBodyIntra.dart';
import 'package:safe2biz/app/ui/module_ui.dart';

import '../../../../../../global/controllers/auth_controller.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({Key? key, this.user, this.pass}) : super(key: key);

  final String? user;
  final String? pass;

  @override
  State<LoginBody> createState() => _LoginBodyState();
}



class _LoginBodyState extends State<LoginBody> {



  late var userTxt =  TextEditingController(text: '${widget.user}');
  late var passTxt = TextEditingController(text: '${widget.pass}');
  final formKey = GlobalKey<FormState>();

  //final passTxt = TextEditingController(text: '4321');
  // final userTxt = TextEditingController();
  // final passTxt = TextEditingController();




  @override
  Widget build(BuildContext context) {





    final size = MediaQuery.of(context).size;
    final spacingLogin = size.height * .15;
    final sizeLogo = size.height * .25;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: BlocListener<LoginBloc, LoginState>(
          listenWhen: (previous, current) => current != previous,
          listener: (context, state) async {
            if (state is Loaded) {

            }
            if (state is Successful) {
              Nav.replace(
                context,
                CompanyBodyIntra(user_login: '${userTxt.text.trim().toLowerCase() }',  ),
              );
              return;
            }

            if (state is FailureLogin) {
              Toast.show(
                description: state.error,
                toastType: ToastType.error,
              );
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Stack(
                    children: [
                      const BackgroundEffect(),
                      BtnSettings(
                        onTap: () {
                          Nav.go(
                            context,
                            const SettingsPage(),
                          );
                        },
                      ),
                      Positioned(
                        left: S2BSpacing.zero,
                        right: S2BSpacing.zero,
                        top: spacingLogin,
                        bottom: S2BSpacing.xl,
                        child: Padding(
                          padding: const EdgeInsets.all(S2BSpacing.md),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: PhysicalModel(
                                  color: S2BColors.white,
                                  elevation: S2BElevation.md,
                                  borderRadius:
                                      BorderRadius.circular(S2BRadius.lg),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: S2BSpacing.lg,
                                      horizontal: S2BSpacing.lg,
                                    ).copyWith(
                                      bottom: S2BSpacing.zero,
                                    ),
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          TextLabel.h5(
                                            UiValues.iniciarSesion,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          const SizedBox(
                                            height: S2BSpacing.lg,
                                          ),
                                          Image.asset(
                                            UiValues.safe2BizLogoPng,
                                            fit: BoxFit.contain,
                                            height: sizeLogo,
                                          ),
                                          const SizedBox(
                                            height: S2BSpacing.lg,
                                          ),
                                          InputTextField(

                                            controller: userTxt,

                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Usuario requerido';
                                              }
                                              return null;
                                            },
                                            leadingIcon: const InputLeadingIcon(
                                              FontAwesomeIcons.solidUser,
                                              color: S2BColors.primaryColor,
                                            ),

                                            placeholder: UiValues.usuario,
                                          ),
                                          const SizedBox(
                                            height: S2BSpacing.lg,
                                          ),
                                          InputTextField(
                                            controller: passTxt,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Contraseña requerida';
                                              }
                                              return null;
                                            },
                                            leadingIcon: const InputLeadingIcon(
                                              FontAwesomeIcons.key,
                                              color: S2BColors.primaryColor,
                                            ),
                                            type: InputType.password,
                                            placeholder: UiValues.contrasenia,
                                          ),
                                          const SizedBox(
                                            height: S2BSpacing.lg,
                                          ),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                primary: S2BColors.primaryColor,
                                                onSurface: S2BColors.colorHover,
                                                backgroundColor:
                                                    S2BColors.background),
                                            onPressed: () => _login(context),
                                            child: Text(UiValues.iniciarSesion),
                                          )
                                          /*BtnDefault(
                                            UiValues.iniciarSesion,
                                            loading: state is Loading,
                                            onTap: () => _login(context),
                                          ),*/
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }


  void _login(BuildContext context) {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final settings = GetIt.I<SettingsController>();
    if (settings.setting == null) {
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
        'userLogin': '${userTxt.text.trim()}@intrasolution',
        'userPassword': passTxt.text.trim(),
        'systemRoot': 'intrasolution',
      };
      context.read<LoginBloc>().add(
        LoginEv(
          user: userTxt.text.trim(),
          password: passTxt.text.trim(),
        ),
      );

      return;
    } else if (settings.setting != null) {
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
        'userLogin': '${userTxt.text.trim()}@${settings.setting!.nameCompany}',
        'userPassword': passTxt.text.trim(),
        'systemRoot': 'safe2biz',
      };

      context.read<LoginBloc>().add(
        LoginEv(
          user: userTxt.text.trim(),
          password: passTxt.text.trim(),
        ),
      );
    }

  }
}
