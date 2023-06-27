import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_safe2bizapp_core/mobile_safe2bizapp_core.dart';
import 'package:safe2biz/app/global/controllers/auth_controller.dart';
import 'package:safe2biz/app/global/core/core.dart';
import 'package:safe2biz/app/global/core/routing/routing.dart';
import 'package:safe2biz/app/modules/auth/features/login/domain/entities/acceso.dart';
import 'package:safe2biz/app/modules/auth/features/login/domain/entities/user.dart';
import 'package:safe2biz/app/modules/auth/features/login/presenter/page/login_page.dart';
import 'package:safe2biz/app/modules/dmt/moduloCompany.dart';
class CompanyBodyIntra extends StatefulWidget {

  final String? user_login, user_id;


  const CompanyBodyIntra({Key? key, this.user_login, this.user_id}) : super(key: key);


  @override
  State<CompanyBodyIntra> createState() => _CompanyBodyIntraState();
}

class _CompanyBodyIntraState extends State<CompanyBodyIntra> {


  @override
  void initState(){
    super.initState();

    print("User Login ===>  ${widget.user_login}");
    print("sc_user_id ===> ${widget.user_id}" );}


  @override
  Widget build(BuildContext context) {



    /*
    final auth = GetIt.I<AuthController>();
    String urlExt = '';
    String urlApp = '';
    String arroba = '';
    String empresa = '';
    if (auth.user.value != null) {
      urlExt = auth.user.value!.urlExt;
      urlApp = auth.user.value!.urlApp;
      arroba = auth.user.value!.arroba;
      empresa = auth.user.value!.enterprise;
*/
    List company = ["Dominiotech"];

    return Scaffold(
      appBar: AppBar(
        title: Text("Grupo",
        style: TextStyle(fontSize: S2BTypography.h6, fontWeight: FontWeight.w500),),
        backgroundColor: Color(0xFFB60303),

        actions: [

          IconButton(icon: Icon(Icons.logout), color: S2BColors.whiteSecundary, onPressed: () {

            _logout(context);


          },)
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.94,
                      height: 90,
                      child: InkWell(
                        onTap: (){
                          final auth = GetIt.I<AuthController>();
                          final idSede =
                              LocalPreferences.prefs?.getString('current_sede_id') ?? '0';
                          String urlExt = '';
                          String urlApp = '';
                          String arroba = '';
                          String empresa = '';
                          String sc_id ='';
                          String modulos = ''; //List Accesos

                          if (auth.user.value != null) {
                            urlExt = auth.user.value!.urlExt;
                            urlApp = auth.user.value!.urlApp;
                            arroba = auth.user.value!.arroba;
                            empresa = auth.user.value!.enterprise;
                            sc_id = auth.user.value!.uuid;
                            modulos = auth.user.value!.accesos;
                          }
                       //   var ab = json.decode(modulos).cast<String>().toList();

                          print("modulos: === ${modulos}");
                          //print("modulos convertidos: === ${ab}");
                          //fixme: redirigir a nuevos modulos segun el rol de usuario
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ModulosSede(
                            user_login: '${(widget.user_login)}', sc_id: sc_id,
                          ) ));},

                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Row(
                              children: [
                                Image.asset('assets/logo/logo-dmt.png', width: 55,),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 12),
                                child: Text(company[0], style: TextStyle(fontSize: 17, color: Color(0xFF3F3F3F), fontWeight: FontWeight.w500 ),),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
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