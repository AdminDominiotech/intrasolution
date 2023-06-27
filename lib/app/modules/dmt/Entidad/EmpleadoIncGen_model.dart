import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:safe2biz/app/modules/dmt/Entidad/EmpleadoIncGen.dart';


List<EmpleadoIncGen_model> employeeFromJson(String str) =>
    List<EmpleadoIncGen_model>.from(json.decode(str).map((x) => EmpleadoIncGen_model.fromJson(x)));

String employeeToJson(List<EmpleadoIncGen_model> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmpleadoIncGen_model extends EmpleadoIncGen {


  EmpleadoIncGen_model({

    required int Incidencia_Id,
    required String Incidencia_Ticket,
    required String Incidencia_Fecha,
    required String Incidencia_Hora,
    required String Tipo_Incidencia_Nombre,
    required String Incidencia_Titulo,
    required String Proyecto_Codigo,
    required String Estado_Incidencia_Codigo,





  }) : super(

      Incidencia_Id : Incidencia_Id,
      Incidencia_Ticket: Incidencia_Ticket,
      Incidencia_Fecha: Incidencia_Fecha,
      Incidencia_Hora: Incidencia_Hora,
      Tipo_Incidencia_Nombre: Tipo_Incidencia_Nombre,
      Incidencia_Titulo: Incidencia_Titulo,
      Proyecto_Codigo:Proyecto_Codigo,
      Estado_Incidencia_Codigo:Estado_Incidencia_Codigo,


  );


  factory EmpleadoIncGen_model.fromJson(Map<String, dynamic> json) =>
      EmpleadoIncGen_model(
        Incidencia_Id: json['Incidencia_Id'] ?? 0,
        Incidencia_Ticket: json['Incidencia_Ticket'] ?? '',
        Incidencia_Fecha: json['Incidencia_Fecha'] ?? '',
        Incidencia_Hora: json['Incidencia_Hora'] ?? '',
        Tipo_Incidencia_Nombre: json['Tipo_Incidencia_Nombre'] ?? '',
        Incidencia_Titulo: json['Incidencia_Titulo'] ?? '',
        Proyecto_Codigo: json['Proyecto_Codigo'] ?? '',
        Estado_Incidencia_Codigo: json['Estado_Incidencia_Codigo'] ?? '',


      );



  Map<String, dynamic> toJson() => {
    'Incidencia_Id': Incidencia_Id,
    'Incidencia_Ticket':  Incidencia_Ticket,
    'Incidencia_Fecha': Incidencia_Fecha,
    'Incidencia_Hora': Incidencia_Hora,
    'Tipo_Incidencia_Nombre': Tipo_Incidencia_Nombre,
    'Incidencia_Titulo': Incidencia_Titulo,
    'Proyecto_Codigo': Proyecto_Codigo,
    'Estado_Incidencia_Codigo': Estado_Incidencia_Codigo,




  };

  EmpleadoIncGen_model copyWith({
    int? Incidencia_Id,
    String? Incidencia_Ticket,
    String? Incidencia_Fecha,
    String? Incidencia_Hora,
    String? Tipo_Incidencia_Nombre,
    String? Incidencia_Titulo,
    String? Proyecto_Codigo,
    String? Estado_Incidencia_Codigo





  }) =>

      EmpleadoIncGen_model(
        Incidencia_Id: Incidencia_Id ?? this.Incidencia_Id,
        Incidencia_Ticket: Incidencia_Ticket ?? this.Incidencia_Ticket,
        Incidencia_Fecha: Incidencia_Fecha ?? this.Incidencia_Fecha,
        Incidencia_Hora: Incidencia_Hora ?? this.Incidencia_Hora,
        Tipo_Incidencia_Nombre: Tipo_Incidencia_Nombre ?? this.Tipo_Incidencia_Nombre,
        Incidencia_Titulo: Incidencia_Titulo ?? this.Incidencia_Titulo,
        Proyecto_Codigo: Proyecto_Codigo ?? this.Proyecto_Codigo,
        Estado_Incidencia_Codigo:Estado_Incidencia_Codigo ?? this.Estado_Incidencia_Codigo,


      );





}