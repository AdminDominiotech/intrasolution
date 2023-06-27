
import 'package:equatable/equatable.dart';

abstract class EmpleadoIncGen extends Equatable {
  EmpleadoIncGen({
    required this.Incidencia_Id,                  //81014
    required this.Incidencia_Ticket,              //2023-00064-DMT
    required this.Incidencia_Fecha,              //2020-02-14 00:00:00.000   --> convertir
    required this.Incidencia_Hora,             //08:24
    required this.Tipo_Incidencia_Nombre,       //Mejora
    required this.Incidencia_Titulo,         //titulo / Descripcion del incidente
    required this.Proyecto_Codigo,           //PRY-2022-0023-DMT-OTROS
    required this.Estado_Incidencia_Codigo,  //20. ATENCION

  });


  /// ayc_registro_id
  int Incidencia_Id;
  String Incidencia_Ticket;
  String Incidencia_Fecha;
  String Incidencia_Hora;
  String Tipo_Incidencia_Nombre;
  String Incidencia_Titulo;
  String Proyecto_Codigo;
  String Estado_Incidencia_Codigo;



  /// 0: create,1: online
  //String estado;
  @override
  List<Object> get props => [
    Incidencia_Id,
    Incidencia_Ticket,
    Incidencia_Fecha,
    Incidencia_Hora,
    Tipo_Incidencia_Nombre,
    Incidencia_Titulo,
    Proyecto_Codigo,
    Estado_Incidencia_Codigo



  ];
}


