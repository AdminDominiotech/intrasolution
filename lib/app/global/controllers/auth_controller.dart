// Flutter imports:
import 'package:flutter/material.dart';
import 'package:mobile_safe2bizapp_core/mobile_safe2bizapp_core.dart';
import 'package:safe2biz/app/global/core/errors/errors.dart';
import 'package:safe2biz/app/modules/auth/features/login/data/models/models.dart';
import 'package:safe2biz/app/modules/auth/features/login/domain/entities/entities.dart';

// Project imports:

class AuthController {
  AuthController({required this.sqlite});
  // final LocalLogoutUc logoutUseCase;
  final LocalSqlite sqlite;

  ValueNotifier<User?> user = ValueNotifier<User?>(null);
  ValueNotifier<List<String>> modulos = ValueNotifier<List<String>>([]);

  String get getID => user.value!.uuid;
  String get getEmployeeID => user.value!.fbEmpleadoId;
  List<String> getModulos() => modulos.value;

  Future<User?> hasSession() async {
    try {
      final db = await sqlite.database;

      final respUser = await db.query('user');
      if (respUser.isNotEmpty) {
        final model = UserModel.fromJson(respUser.last);
        user.value = model;
        return model;
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      throw AppException(message: stackTrace.toString());
    }
  }

  Future<bool> logout() async {
    try {
      await deleteAllData();
      user.value = null;
      return true;
    } catch (e, stackTrace) {
      throw AppException(message: stackTrace.toString());
    }
  }

  Future<bool> login(User newUser) async {
    try {
      final db = await sqlite.database;
      await db.delete('user');
      final results1 = await db.insert('user', {
        'id': 1,
        'SC_USER_ID': newUser.uuid,
        'USER_LOGIN': newUser.userLogin,
        'nombre_empleado': newUser.name,
        'ENTERPRISE': newUser.enterprise,
        'userPassword': newUser.password,
        'fb_empleado_id': newUser.fbEmpleadoId,
        'URL_EXT': newUser.urlExt,
        'URL_APP': newUser.urlApp,
        'ARROBA': newUser.arroba,
      });
      user.value = newUser;

    //  await saveAccesos(newUser.accesos);

      if (results1 == 1) {
        return true;
      } else {
        throw const LocalFailure(message: 'Error al guardar su sesión');
      }
    } catch (e, stackTrace) {
      throw AppException(message: stackTrace.toString());
    }
  }

  Future<List<String>> getModulosFromLocal(String fbUeaPeId) async {
    try {
      final db = await sqlite.database;

      final result = await db.query(
        LocalSqlite.TABLE_ACCESOS,
        whereArgs: [fbUeaPeId],
        where: 'fb_uea_pe_id = ?',
      );
      if (result.isNotEmpty) {
        final model =
            List.from(result).map((item) => AccesoModel.fromJson(item)).first;
        final list = model.modulos.split(',');
        modulos.value = list;
        return list;
      } else {
        modulos.value = List<String>.from([]);
        return [];
      }
    } catch (e, stackTrace) {
      throw AppException(message: stackTrace.toString());
    }
  }

  Future<bool> saveAccesos(List<Acceso> listAccesos) async {
    try {
      final db = await sqlite.database;
      await db.delete(LocalSqlite.TABLE_ACCESOS);

      final batch = db.batch();

      for (final i in listAccesos) {
        batch.insert(LocalSqlite.TABLE_ACCESOS, {

          'modulos': i.modulos,
        });
      }

      await batch.commit(noResult: true);
      return true;
    } catch (e, stackTrace) {
      throw AppException(message: stackTrace.toString());
    }
  }

  Future<void> deleteAllData() async {
    final db = await sqlite.database;
    await db
      ..delete(LocalSqlite.TABLE_USER)
      ..delete(LocalSqlite.TABLE_FB_UEA_PE);
    //--------------------------------------------
    //----------------- AYC ----------------------
    //--------------------------------------------
    await db
      ..delete(LocalSqlite.TABLE_AYC_REGISTRO)
      ..delete(LocalSqlite.TABLE_G_TIPO_CAUSA)
      ..delete(LocalSqlite.TABLE_G_NIVEL_RIESGO)
      ..delete(LocalSqlite.TABLE_ORIGEN_AYC)
      ..delete(LocalSqlite.TABLE_TIPO_RIESGO_AYC)
      ..delete(LocalSqlite.TABLE_AYC_EVIDENCIA)
      ..delete(LocalSqlite.TABLE_AYC_REPORTANTE);
    //--------------------------------------------
    //----------------- INC ----------------------
    //--------------------------------------------
    await db
      ..delete(LocalSqlite.TABLE_INC_REGISTRO)
      ..delete(LocalSqlite.TABLE_INC_TIPO_REPORTE)
      ..delete(LocalSqlite.TABLE_INC_SUB_TIPO_REPORTE)
      ..delete(LocalSqlite.TABLE_INC_DETALLE_PERDIDA)
      ..delete(LocalSqlite.TABLE_INC_POTENCIAL_PERDIDA);

    //--------------------------------------------
    //----------------- SAC ----------------------
    //--------------------------------------------
    await db.delete(LocalSqlite.TABLE_SAC_ACCION_CORRECTIVA);
    //--------------------------------------------
    //----------------- OPS ----------------------
    //--------------------------------------------
    await db
      ..delete(LocalSqlite.TABLE_OPS_REGISTRO_GENERALES)
      ..delete(LocalSqlite.TABLE_OPS_REGISTRO_RESULTADO)
      ..delete(LocalSqlite.TABLE_OPS_LISTA_VERIFICACION)
      ..delete(LocalSqlite.TABLE_OPS_LISTA_VERIF_CATEGORIA)
      ..delete(LocalSqlite.TABLE_OPS_LISTA_VERIF_SECCION)
      ..delete(LocalSqlite.TABLE_OPS_LISTA_VERIF_PREGUNTA)
      ..delete(LocalSqlite.TABLE_OPS_LISTA_VERIF_RESULTADO)
      ..delete(LocalSqlite.TABLE_OPS_LISTA_TIPO_RESULTADO)
      ..delete(LocalSqlite.TABLE_OPS_TURNOS)
      ..delete(LocalSqlite.TABLE_ACCESOS);

    //---------------------------------------------
    //--------------- DATA PARA SINCRONIZAR -------
    //---------------------------------------------
    await db
      ..delete(LocalSqlite.TABLE_FB_GERENCIA)
      ..delete(LocalSqlite.TABLE_FB_AREA)
      ..delete(LocalSqlite.TABLE_FB_EMPRESA_ESPECIALIZADA);

    // static const String TABLE_USER = 'user';
    // static const String TABLE_COMPANY = 'compay';
    // static const String TABLE_T_PARAMETRO = 't_parametro';
    // static const String TABLE_SETTINGS = 'settings';
    // static const String TABLE_FB_UEA_PE = 'FB_UEA_PE';
    // //--------------------------------------------
    // //----------------- AYC ----------------------
    // //--------------------------------------------
    // static const String TABLE_AYC_REGISTRO = 'AYC_REGISTRO';
    // static const String TABLE_G_TIPO_CAUSA = 'G_TIPO_CAUSA';
    // static const String TABLE_G_NIVEL_RIESGO = 'G_NIVEL_RIESGO';
    // static const String TABLE_ORIGEN_AYC = 'ORIGEN_AYC';
    // static const String TABLE_TIPO_RIESGO_AYC = 'TIPO_RIESGO_AYC';
    // static const String TABLE_AYC_EVIDENCIA = 'AYC_EVIDENCIA';
    // static const String TABLE_AYC_REPORTANTE = 'AYC_REPORTANTE';
    // //--------------------------------------------
    // //----------------- INC ----------------------
    // //--------------------------------------------
    // static const String TABLE_INC_REGISTRO = 'INC_REGISTRO';
    // static const String TABLE_INC_TIPO_REPORTE = 'INC_TIPO_REPORTE';
    // static const String TABLE_INC_SUB_TIPO_REPORTE = 'INC_SUB_TIPO_REPORTE';
    // static const String TABLE_INC_DETALLE_PERDIDA = 'INC_DETALLE_PERDIDA';
    // static const String TABLE_INC_POTENCIAL_PERDIDA = 'INC_POTENCIAL_PERDIDA';

    // //--------------------------------------------
    // //----------------- SAC ----------------------
    // //--------------------------------------------
    // static const String TABLE_SAC_ACCION_CORRECTIVA = 'SAC_ACCION_CORRECTIVA';

    // //--------------------------------------------
    // //----------------- OPS ----------------------
    // //--------------------------------------------

    // static const String TABLE_OPS_REGISTRO_GENERALES = 'OPS_REGISTRO_GENERALES';
    // static const String TABLE_OPS_REGISTRO_RESULTADO = 'OPS_REGISTRO_RESULTADO';
    // static const String TABLE_OPS_LISTA_VERIFICACION = 'OPS_LISTA_VERIFICACION';
    // static const String TABLE_OPS_LISTA_VERIF_CATEGORIA =
    //     'OPS_LISTA_VERIF_CATEGORIA';
    // static const String TABLE_OPS_LISTA_VERIF_SECCION = 'OPS_LISTA_VERIF_SECCION';
    // static const String TABLE_OPS_LISTA_VERIF_PREGUNTA =
    //     'OPS_LISTA_VERIF_PREGUNTA';
    // static const String TABLE_OPS_LISTA_VERIF_RESULTADO =
    //     'OPS_LISTA_VERIF_RESULTADO';
    // static const String TABLE_OPS_LISTA_TIPO_RESULTADO =
    //     'OPS_LISTA_TIPO_RESULTADO';
    // static const String TABLE_OPS_TURNOS = 'OPS_TURNOS';
    // static const String TABLE_ACCESOS = 'ACCESOS';

    // //------------------------------------------------
    // //--------------- DATA PARA SINCRONIZAR ----------
    // //------------------------------------------------
    // static const String TABLE_FB_GERENCIA = 'FB_GERENCIA';
    // static const String TABLE_FB_AREA = 'FB_AREA';
    // static const String TABLE_FB_EMPRESA_ESPECIALIZADA =
    //     'FB_EMPRESA_ESPECIALIZADA';
  }
}
