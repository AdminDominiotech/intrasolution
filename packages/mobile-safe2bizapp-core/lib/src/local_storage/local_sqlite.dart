// ignore_for_file: constant_identifier_names

import 'package:sqflite/sqflite.dart';

class LocalSqlite {
  LocalSqlite._();
  factory LocalSqlite() => _instance;
  static final LocalSqlite _instance = LocalSqlite._();

  static const String TABLE_USER = 'user';
  // static const String TABLE_COMPANY = 'compay';
  // static const String TABLE_T_PARAMETRO = 't_parametro';
  static const String TABLE_SETTINGS = 'settings';
  static const String TABLE_FB_UEA_PE = 'FB_UEA_PE';
  //--------------------------------------------
  //----------------- AYC ----------------------
  //--------------------------------------------
  static const String TABLE_AYC_REGISTRO = 'AYC_REGISTRO';
  static const String TABLE_G_TIPO_CAUSA = 'G_TIPO_CAUSA';
  static const String TABLE_G_NIVEL_RIESGO = 'G_NIVEL_RIESGO';
  static const String TABLE_ORIGEN_AYC = 'ORIGEN_AYC';
  static const String TABLE_TIPO_RIESGO_AYC = 'TIPO_RIESGO_AYC';
  static const String TABLE_AYC_EVIDENCIA = 'AYC_EVIDENCIA';
  static const String TABLE_AYC_REPORTANTE = 'AYC_REPORTANTE';
  //--------------------------------------------
  //----------------- INC ----------------------
  //--------------------------------------------
  static const String TABLE_INC_REGISTRO = 'INC_REGISTRO';
  static const String TABLE_INC_TIPO_REPORTE = 'INC_TIPO_REPORTE';
  static const String TABLE_INC_SUB_TIPO_REPORTE = 'INC_SUB_TIPO_REPORTE';
  static const String TABLE_INC_DETALLE_PERDIDA = 'INC_DETALLE_PERDIDA';
  static const String TABLE_INC_POTENCIAL_PERDIDA = 'INC_POTENCIAL_PERDIDA';

  //--------------------------------------------
  //----------------- SAC ----------------------
  //--------------------------------------------
  static const String TABLE_SAC_ACCION_CORRECTIVA = 'SAC_ACCION_CORRECTIVA';

  //--------------------------------------------
  //----------------- OPS ----------------------
  //--------------------------------------------

  static const String TABLE_OPS_REGISTRO_GENERALES = 'OPS_REGISTRO_GENERALES';
  static const String TABLE_OPS_REGISTRO_RESULTADO = 'OPS_REGISTRO_RESULTADO';
  static const String TABLE_OPS_LISTA_VERIFICACION = 'OPS_LISTA_VERIFICACION';
  static const String TABLE_OPS_LISTA_VERIF_CATEGORIA =
      'OPS_LISTA_VERIF_CATEGORIA';
  static const String TABLE_OPS_LISTA_VERIF_SECCION = 'OPS_LISTA_VERIF_SECCION';
  static const String TABLE_OPS_LISTA_VERIF_PREGUNTA =
      'OPS_LISTA_VERIF_PREGUNTA';
  static const String TABLE_OPS_LISTA_VERIF_RESULTADO =
      'OPS_LISTA_VERIF_RESULTADO';
  static const String TABLE_OPS_LISTA_TIPO_RESULTADO =
      'OPS_LISTA_TIPO_RESULTADO';
  static const String TABLE_OPS_TURNOS = 'OPS_TURNOS';
  static const String TABLE_ACCESOS = 'ACCESOS';

  //------------------------------------------------
  //--------------- DATA PARA SINCRONIZAR ----------
  //------------------------------------------------
  static const String TABLE_FB_GERENCIA = 'FB_GERENCIA';
  static const String TABLE_FB_AREA = 'FB_AREA';
  static const String TABLE_FB_EMPRESA_ESPECIALIZADA =
      'FB_EMPRESA_ESPECIALIZADA';

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbnew = await openDatabase(
      'Safe2BizApp001.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
            CREATE TABLE IF NOT EXISTS $TABLE_SETTINGS(
            ip TEXT(20),
            name_company TEXT(50)
            )
          ''');
        await db.execute('''
            CREATE TABLE IF NOT EXISTS $TABLE_USER(
            id INTEGER,
            SC_USER_ID INTEGER,
            USER_LOGIN TEXT(50) NOT NULL,
            nombre_empleado TEXT(50) NOT NULL,
            ENTERPRISE TEXT(50),
            userPassword TEXT(50),
            fb_empleado_id TEXT(15),
            URL_EXT TEXT(200),
            URL_APP TEXT(200),
            ARROBA TEXT(50)
            )
          ''');
        // await db.execute('''
        //     CREATE TABLE IF NOT EXISTS $TABLE_T_PARAMETRO(
        //     n_parametro INTEGER PRIMARY KEY,
        //     x_codigo TEXT(50),
        //     x_valor TEXT(50),
        //     x_descripcion TEXT(50)
        //     )
        //   ''');

        // await db.execute('''
        //     CREATE TABLE IF NOT EXISTS $TABLE_COMPANY(
        //     id INTEGER PRIMARY KEY,
        //     name TEXT(50),
        //     address TEXT(50),
        //     imagePrimary TEXT,
        //     imageSecond TEXT,
        //     email TEXT(50),
        //     phone TEXT(20),
        //     ruc TEXT(15),
        //     descriptionPrimary TEXT(50),
        //     descriptionSecond TEXT(50)
        //     )
        //   ''');

        await db.execute('''
           CREATE TABLE $TABLE_FB_UEA_PE (
            fb_uea_pe_id INTEGER,
            codigo TEXT(50),
            nombre TEXT(50),
            sc_user_id TEXT(15)
            );
          ''');

        await db.execute('''
           CREATE TABLE $TABLE_ACCESOS (
            fb_uea_pe_id INTEGER,
            codigo TEXT(50),
            modulos TEXT(50)
            );
          ''');

        //--------------------------------------------
        //----------------- AYC ----------------------
        //--------------------------------------------

        await db.execute('''
            CREATE TABLE IF NOT EXISTS $TABLE_AYC_REGISTRO (
            ayc_registro_id INTEGER primary key,
            origen TEXT(15),
            g_tipo_causa_id TEXT(15),
            g_tipo_causa_nombre TEXT(100),
            fb_gerencia_id TEXT(15),
            fb_gerencia_nombre TEXT(100),
            fb_area_id TEXT(15),
            fb_area_nombre TEXT(100),
            descripcion TEXT(200),
            lugar TEXT(200),
            fecha TEXT(10),
            hora  TEXT(5),
            corrigio TEXT(200),
            tipo_evento_id TEXT(15),
            tipo_evento_nombre TEXT(100),
            nivel_riesgo_id TEXT(15),
            nivel_riesgo_nombre TEXT(100),
            accion_ejec TEXT(200),
            fb_empresa_especializada_id TEXT(15),
            fb_empresa_especializada_nombre TEXT(100),
            latitud TEXT(15),
            longitud TEXT(15),
            foto_pre_evento_nombre TEXT(100),
            foto_pre_evento_ruta TEXT,
            foto_evento_nombre TEXT(100),
            foto_evento_ruta TEXT,
            fb_empleado_id TEXT(15),
            fb_empleado_nombre TEXT(100),
            fb_uea_pe_id TEXT(15),
            estado TEXT(1)
            );
          ''');

        await db.execute('''
            CREATE TABLE IF NOT EXISTS $TABLE_G_TIPO_CAUSA (
          	g_tipo_causa_id TEXT(15),
            ayc TEXT(50),
            descripcion TEXT(200)
            );
          ''');
        await db.execute('''
            CREATE TABLE IF NOT EXISTS $TABLE_G_NIVEL_RIESGO (
            g_nivel_riesgo_id TEXT(15),
            nombre TEXT(100)
            );
          ''');

        await db.execute('''
            CREATE TABLE IF NOT EXISTS $TABLE_ORIGEN_AYC (
            code TEXT(15) primary key,
            name TEXT(100)
            );
          ''');

        await db.execute('''
            CREATE TABLE IF NOT EXISTS $TABLE_TIPO_RIESGO_AYC (
            inc_tipo_reporte_id TEXT(15),
            nombre TEXT(100)
            );
          ''');
        await db.execute('''
            CREATE TABLE IF NOT EXISTS $TABLE_AYC_EVIDENCIA (
            nombre TEXT(100),
            ruta TEXT(500),
            ayc_registro_id TEXT(15)
            );
          ''');

        await db.execute('''
            CREATE TABLE IF NOT EXISTS $TABLE_AYC_REPORTANTE (
            fb_empleado_id TEXT(15),
            fb_uea_pe_id TEXT(15),
            nombreCompleto TEXT(100),
            numero_documento TEXT(100),
            cargo_nombre TEXT(100),
            gerencia_nombre TEXT(100),
            empresa TEXT(100)
            );
          ''');

        //--------------------------------------------
        //----------------- INC ----------------------
        //--------------------------------------------

        await db.execute('''
            CREATE TABLE IF NOT EXISTS $TABLE_INC_REGISTRO (
            inc_incidente_id INTEGER primary key,
            fb_empleado_id TEXT(15),
            fb_uea_pe_id TEXT(15),
            inc_tipo_evento TEXT(15),
            inc_tipo_evento_nombre TEXT(100),
            inc_sub_tipo_evento TEXT(15),
            inc_sub_tipo_evento_nombre TEXT(100),
            inc_segun_tipo TEXT(15),
            inc_segun_tipo_nombre TEXT(100),
            inc_potencial_perdida TEXT(15),
            inc_potencial_perdida_nombre TEXT(100),
            fb_gerencia_id TEXT(15),
            fb_gerencia_nombre TEXT(100),
            fb_area TEXT(15),
            fb_area_nombre TEXT(100),
            fecha_evento TEXT(10),
            hora TEXT(5),
            lugar_evento TEXT(100),
            descripcion_evento TEXT(100),
            imagen_pre_evento_nombre TEXT(100),
            imagen_pre_evento_ruta TEXT,
            imagen_evento_nombre TEXT(100),
            imagen_evento_ruta TEXT,
            estado TEXT(1)
            );
          ''');
        //--------------------------------------------
        //----------------- SAC ----------------------
        //--------------------------------------------

        await db.execute('''
            CREATE TABLE IF NOT EXISTS $TABLE_SAC_ACCION_CORRECTIVA (
            sac_accion_correctiva_id TEXT(15),
            codigo_accion_correctiva TEXT(100),
            accion_correctiva_detalle TEXT(100),
            fecha_acordada_ejecucion TEXT(10),
            nombre_responsable_correccion TEXT(100),
            origen TEXT(50),
            uea_id TEXT(15),
            fecha_ejecucion TEXT(10),
            evidencia_nombre TEXT(100),
            evidencia_ruta TEXT,
            obs_resp_corr TEXT(100),
            estado TEXT(1)
            );
          ''');
        //--------------------------------------------
        //----------------- OPS ----------------------
        //--------------------------------------------
        await db.execute('''
            CREATE TABLE IF NOT EXISTS $TABLE_OPS_REGISTRO_GENERALES(
            ops_registro_generales_id           INTEGER primary key,
            fb_uea_pe_id                        TEXT(15),
            codigo                              TEXT(50),
            g_tipo_origen_id                    TEXT(15),
            fecha_ops                           TEXT(15),
            hora_ops                            TEXT(15),
            turno                               TEXT(50),
            fb_area_id                          TEXT(15),
            g_rol_empresa_id                    TEXT(15),
            fb_empresa_especializada_id         TEXT(15),
            fb_empleado_id                      TEXT(15),
            ops_lista_verificacion_id           TEXT(15),
            ops_tipo_resultado_id               TEXT(15),
            latitud                             TEXT(15),
            longitud                            TEXT(15),
            fb_area_nombre                      TEXT(100),
            turno_nombre                        TEXT(100),
            fb_empresa_especializada_nombre     TEXT(100),
            fb_empleado_nombre_completo         TEXT(100),
            id_generado_syncronizacion          TEXT(15),
            estado                              TEXT(1),
            flag                                TEXT(1)
          );
          ''');

        await db.execute('''
            CREATE TABLE IF NOT EXISTS $TABLE_OPS_REGISTRO_RESULTADO(
            ops_registro_resultado_id       INTEGER primary key,
            ops_registro_generales_id       TEXT(15),
            ops_lista_verif_pregunta_id     TEXT(15),
            ops_lista_verif_seccion_id      TEXT(15),
            ops_lista_verif_categoria_id    TEXT(15),
            ops_lista_verif_resultado_id    TEXT(15),
            observacion                     TEXT(200),
            ruta_imagen                     TEXT,
            nombre_imagen                   TEXT(100),
            id_generado_syncronizacion      TEXT(15),
            aux_codigo                      TEXT(20)
            );
            ''');

        //--------------------------------------------
        //---------- DATA PARA SINCRONIZAR -----------
        //--------------------------------------------
        await db.execute('''
            CREATE TABLE IF NOT EXISTS $TABLE_FB_GERENCIA (
            fb_gerencia_id TEXT(15),
            fb_uea_pe_id TEXT(15),
            codigo TEXT(50),
            nombre TEXT(100)
            );
          ''');
        await db.execute('''
            CREATE TABLE IF NOT EXISTS $TABLE_FB_AREA (
            fb_area_id  TEXT(15),
            fb_gerencia_id TEXT(15),
            codigo  TEXT(50),
            nombre  TEXT(100)
            );
          ''');
        await db.execute('''
            CREATE TABLE IF NOT EXISTS $TABLE_FB_EMPRESA_ESPECIALIZADA (
            fb_empresa_especializada_id TEXT(15),
            razon_social TEXT(100),
            ruc_empresa TEXT(20),
            g_rol_empresa_id TEXT(15)
            );
          ''');

        await db.execute('''
            CREATE TABLE IF NOT EXISTS $TABLE_INC_TIPO_REPORTE (
            inc_tipo_reporte_id TEXT(15),
            nombre TEXT(100)
            );
          ''');

        await db.execute('''
            CREATE TABLE IF NOT EXISTS $TABLE_INC_SUB_TIPO_REPORTE (
            inc_sub_tipo_reporte_id TEXT(15),
	          inc_tipo_reporte_id TEXT(15),
            nombre TEXT(100)
            );
          ''');

        await db.execute('''
            CREATE TABLE IF NOT EXISTS $TABLE_INC_DETALLE_PERDIDA (
            inc_segun_tipo_id TEXT(15),
          	inc_tipo_reporte_id TEXT(15),
            nombre TEXT(500),
            codigo TEXT(500)
            );
          ''');

        await db.execute('''
            CREATE TABLE IF NOT EXISTS $TABLE_INC_POTENCIAL_PERDIDA (
            inc_potencial_perdida_id TEXT(15),
            nombre TEXT(100),
            codigo TEXT(50)
            );
          ''');

        await db.execute('''
            CREATE TABLE $TABLE_OPS_LISTA_TIPO_RESULTADO (
            ops_tipo_resultado_id   TEXT(15),
            codigo                  TEXT(20),
            nombre                  TEXT(100)
            );    
          ''');

        await db.execute('''
            CREATE TABLE $TABLE_OPS_LISTA_VERIFICACION (
            ops_lista_verificacion_id TEXT(15),
            ops_tipo_resultado_id     TEXT(15),
            codigo                    TEXT(20),
            nombre                    TEXT(100)
            );
          ''');

        await db.execute('''
            CREATE TABLE $TABLE_OPS_LISTA_VERIF_CATEGORIA(
            ops_lista_verif_categoria_id  TEXT(15),
            ops_lista_verificacion_id     TEXT(15),
            nombre                        TEXT(100)
            );    
          ''');

        await db.execute('''
            CREATE TABLE $TABLE_OPS_LISTA_VERIF_SECCION (
            ops_lista_verif_seccion_id    TEXT(15),
            ops_lista_verif_categoria_id  TEXT(15),
            ops_lista_verificacion_id     TEXT(15),
            nombre                        TEXT(100),
            orden                         TEXT(20)
            );
          ''');

        await db.execute('''
            CREATE TABLE $TABLE_OPS_LISTA_VERIF_PREGUNTA(
            ops_lista_verif_pregunta_id   TEXT(15),
            ops_lista_verif_seccion_id    TEXT(15),
            ops_lista_verif_categoria_id  TEXT(15),
            ops_lista_verificacion_id     TEXT(15),
            nombre                        TEXT(100),
            flag_pregunta                 TEXT(1),
            orden                         TEXT(20),
            aux_codigo                    TEXT(20)
            );  
          ''');

        await db.execute('''
            CREATE TABLE $TABLE_OPS_LISTA_VERIF_RESULTADO(
            ops_lista_verif_resultado_id    TEXT(15),
            ops_tipo_resultado_id           TEXT(15),
            codigo                          TEXT(20),
            nombre                          TEXT(100)
            );
          ''');

        await db.execute('''
            CREATE TABLE $TABLE_OPS_TURNOS(
            ops_turno_id    INTEGER primary key,
            codigo          TEXT(20),
            nombre          TEXT(100)
            );
          ''');
      },
    );
    return dbnew;
  }
}
