// Flutter imports:
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:safe2biz/app/global/controllers/auth_controller.dart';
import 'package:safe2biz/app/modules/auth/features/login/presenter/page/login_page.dart';
import 'package:safe2biz/app/global/core/core.dart';
import 'package:safe2biz/app/global/core/routing/routing.dart';

import 'package:safe2biz/app/ui/module_ui.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  _DrawerDerState createState() => _DrawerDerState();
}

class _DrawerDerState extends State<DrawerMenu> {
  ValueNotifier<bool> disponible = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: S2BColors.white,
        ),
        child: SizedBox(
          width: size.width * .6,
          height: MediaQuery.of(context).size.height,
          child: Drawer(
            elevation: 0,
            child: ListView(
              padding: const EdgeInsets.all(
                S2BSpacing.zero,
              ),
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  color: S2BColors.primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: S2BSpacing.sm,
                      horizontal: S2BSpacing.md,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: S2BSpacing.md,
                          ),
                          child: Container(
                            width: 110.0,
                            height: 110.0,
                            padding: const EdgeInsets.all(S2BSpacing.md),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              color: S2BColors.white,
                            ),
                            child: const Image(
                              image: AssetImage(UiValues.safe2BizLogoPng),
                              height: 80,
                              width: 80,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            TextLabel.labelText(
                              'Hola, Cesar',
                              textAlign: TextAlign.center,
                              color: S2BColors.white,
                            ),
                            const SizedBox(height: 5),
                            TextLabel.small(
                              'Bienvenido a Safe2Biz',
                              color: S2BColors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                ItemMenu(
                  ontap: () {

                  },
                  icon: FontAwesomeIcons.industry,
                  title: 'Cambiar Sede',
                ),
                ItemMenu(
                  ontap: () => _logout(context),
                  icon: FontAwesomeIcons.rightFromBracket,
                  title: 'Cerrar Sesión',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    PopupMessage(
      context: context,
      title: 'Cerrar Sesión',
      bodyText: '¿Esta seguro que desea cerrar la sesión?',
      isDismissible: false,
      onSucess: () async {
        final auth = GetIt.I<AuthController>();
        final result = await auth.logout();

        if (result) {
          await Navigator.pushAndRemoveUntil(
            context,
            FadePageRoute(newPage: const LoginPage()),
            (route) => false,
          );
        } else {
          Toast.show(
            description: 'Hubo un error',
            toastType: ToastType.error,
          );
        }
      },
    );
  }
}

class ItemMenu extends StatelessWidget {
  const ItemMenu({
    Key? key,
    required this.ontap,
    required this.icon,
    required this.title,
  }) : super(key: key);
  final VoidCallback ontap;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: S2BColors.graySecondary,
            ),
          ),
        ),
        padding: const EdgeInsets.all(S2BSpacing.md),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: S2BColors.orange,
            ),
            const SizedBox(width: S2BSpacing.sl),
            TextLabel.labelText(
              title,
            ),
          ],
        ),
      ),
    );
  }
}
