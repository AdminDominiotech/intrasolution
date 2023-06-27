import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:safe2biz/app/global/core/styles/colors.dart';
import 'package:safe2biz/app/modules/dmt/Database/host.dart';
import 'package:http/http.dart' as http;

class IncidenciaDetalle extends StatefulWidget {

  final int? idInc;
  IncidenciaDetalle({Key? key, this.idInc}) : super(key: key);

  @override
  State<IncidenciaDetalle> createState() => _IncidenciaDetalleState();
}


class _IncidenciaDetalleState extends State<IncidenciaDetalle> {

  //Colores estado
  Color? colorEstado;

  //Iconos
  Icon? flag_backlog;
  Icon? contiene_pase;

  String? fechaProg;
  String? tipoRelacion;
  String? incRelacion;
  String? descCausa;
  String? solCausa;
  String? respCliTI;
  String? infInc;
  String? paqArchivos;
  String? procInstalacion;
  String? casosPruebas;
  String? procUsuario;

  @override
  void initState(){
    super.initState();

    /*
    Future.delayed(const Duration(milliseconds: 1500), () {

      asyncMethod();

    });


     */
  }



  void asyncMethod() async {


    await RequestIncidenciasGeneralesDetalle();

  }


  @override
  Widget build(BuildContext context) {

    RequestIncidenciasGeneralesDetalle();

    return Scaffold(
        appBar:  AppBar(
          title: Text("Incidencia"),
          backgroundColor: S2BColors.primaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          leading: GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    width: 40,
                    child: Icon( Icons.arrow_back_ios )),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
            } ,
          ) ,

        ),
        body: FutureBuilder(
            future: RequestIncidenciasGeneralesDetalle(),

            builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>

            snapshot.hasData ? ListView.builder(

                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, index) {
                  String? img;
                  double hg = 35;
                  int wd = 150;
                  String cli = snapshot.data![index]['Cliente_Nombre'];
                  if(cli == 'DOMINIOTECH SAC'){
                    img = 'assets/logo/cliente-dmt.png';
                  }else if(cli == 'Buenaventura '){
                    img = 'assets/logo/cliente-bnv.png';
                  }
                  else if(cli == 'Compañia Minera Antapaccay'){
                    img = 'assets/logo/cliente-anta.png';
                    hg = 50;
                  }
                  else if(cli == 'Engie S.A.C'){
                    img = 'assets/logo/cliente-engie.png';
                  }  else if(cli == 'Petroperu SAC'){
                    img = 'assets/logo/cliente-ptp.png';
                  }  else if(cli == 'Compañia Minera Lincuna SAC'){
                    img = 'assets/logo/cliente-linc.png';
                    hg = 50;
                  }



                  String desc = "${snapshot.data![index]['Incidencia_Descripcion']}";
                  String? descParse;

                  //Parse HTML to  Flutter String

                  final document = parse(desc);
                  final String parsedString = parse(document.body?.text).documentElement!.text;

                  descParse = parsedString;



                  String codEstado = "${snapshot.data![index]['Estado_Incidencia_Codigo']}";
                  String tipoInc = "${snapshot.data![index]['Tipo_Incidencia_Nombre']}";

                  if(snapshot.data![index]['Incidencia_Fecha_Programada']  == null ){fechaProg = '-';}
                  if(snapshot.data![index]['incidencia_Tipo_Relacion']  == null ){tipoRelacion = '-';}
                  if(snapshot.data![index]['Incidencia_Relacionada']  == null ){incRelacion = '-';}
                  if(snapshot.data![index]['Incidencia_Descripcion_Causa'] == null || snapshot.data![index]['Incidencia_Descripcion_Causa'].isEmpty ){descCausa = '-';}else{descCausa = snapshot.data![index]['Incidencia_Descripcion_Causa'];}
                  if(snapshot.data![index]['Incidencia_Solucion_Causa'] == null || snapshot.data![index]['Incidencia_Solucion_Causa'].isEmpty ){solCausa = '-';}else{solCausa = snapshot.data![index]['Incidencia_Solucion_Causa'];}
                  if(snapshot.data![index]['Incidencia_Responsable_TI']  == null ){respCliTI = '-';}


                  if(snapshot.data![index]['Incidencia_Informe']  == null || snapshot.data![index]['Incidencia_Informe'].isEmpty  ){infInc = '-';}
                  if(snapshot.data![index]['Incidencia_Paquete_Archivo']  == null || snapshot.data![index]['Incidencia_Paquete_Archivo'].isEmpty){paqArchivos = '-';}
                  if(snapshot.data![index]['Incidencia_Procedimiento_Instalacion']  == null || snapshot.data![index]['Incidencia_Procedimiento_Instalacion'].isEmpty){procInstalacion = '-';}
                  if(snapshot.data![index]['Incidencia_Caso_Prueba']  == null || snapshot.data![index]['Incidencia_Caso_Prueba'].isEmpty){casosPruebas = '-';}
                  if(snapshot.data![index]['Incidencia_Procedimiento_Usuario']  == null || snapshot.data![index]['Incidencia_Procedimiento_Usuario'].isEmpty){procUsuario = '-';}


                  if(snapshot.data![index]['Incidencia_Flag_Backlog'] == 0 || snapshot.data![index]['Incidencia_Flag_Backlog'] == null ){
                    flag_backlog = Icon(Icons.check_box_outline_blank, color: Color(0xffB60303));
                  }else if(snapshot.data![index]['Incidencia_Flag_Backlog'] == 1 ){
                    flag_backlog = Icon(Icons.check_box_rounded , color: Color(0xffB60303));
                  }

                  if(snapshot.data![index]['Incidencia_Pase'] == 0 || snapshot.data![index]['Incidencia_Pase'] == null){
                    contiene_pase = Icon(Icons.check_box_outline_blank, color: Color(0xffB60303));
                  }else if(snapshot.data![index]['Incidencia_Pase'] == 1 ){
                    contiene_pase = Icon(Icons.check_box_rounded , color: Color(0xffB60303));
                  }


                  if(tipoInc == "Incidencia/Observacion"){
                    tipoInc = "Inc / Obs";
                  }else if(tipoInc == "Requerimiento/Cambio"){
                    tipoInc = "Req / Cam";
                  }

                  if(codEstado == '10. SOLICITADO' || codEstado == '20. ATENCION' || codEstado == '46. APROB_QA_DT' || codEstado == '45. INST_QA_DT' || codEstado == '40. COMPLETADO'){
                    colorEstado = Color(0xffFF0000);
                  }else if(codEstado == '50. ENV_QA_CLI' ){
                    colorEstado =  Color(0xffFF8000);

                  }else{
                    colorEstado =  Color(0xff309630);
                  }

                  return Container(

                    width: MediaQuery.of(context).size.width*1,

                    // render list item
                    child: ListTile(
                      onTap: (){



                      },

                      title:  Column(
                        children: [

                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.insert_drive_file_outlined, color: Colors.black, size: 20,),
                                  SizedBox(width: 5,),
                                  Text(" ${snapshot.data![index]['Incidencia_Ticket']} ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                ],
                              ),
                              Text("${snapshot.data![index]['Incidencia_Fecha'].substring(0,10)} -" " ${snapshot.data![index]['Incidencia_Hora'].substring(0,5)}",style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                            ],
                          ),

                          Divider(height: 25,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Container(
                                width: MediaQuery.of(context).size.width*0.55,
                                child: Row(
                                  children: [

                                      Image.asset('$img', height: hg,)

                                    //FittedBox(child: Text(" ${snapshot.data![index]['Cliente_Nombre']}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),))
                                  ],
                                ),
                              ),



                              Container(
                                width: MediaQuery.of(context).size.width*0.35,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: StadiumBorder(),
                                          backgroundColor: colorEstado
                                      ),
                                      onPressed: (){


                                      },
                                      child: FittedBox(child: Text("${snapshot.data![index]['Estado_Incidencia_Codigo']}", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),)),
                                    )

                                  ],
                                ),
                              ),
                            ],
                          ),


                          Divider(height: 25,),

                          Container(
                            decoration: BoxDecoration(        color: Colors.white,  borderRadius: BorderRadius.circular(10.0) ),
                            child:   Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text("Tipo Incidencia:  ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
                                      Text("$tipoInc", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Severidad:  ", style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                                      Text("${snapshot.data![index]['Nivel_Incidencia_Nombre']}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)
                                    ],
                                  ),

                                ],
                              ),
                            ),

                          ),
                          Divider(height: 25,),

                          Container(
                            decoration: BoxDecoration(        color: Colors.white,  borderRadius: BorderRadius.circular(10.0) ),

                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Título del Proyecto:", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),



                                    ],
                                  ),
                                  Divider(height: 8,),

                                  Row(
                                    children: [
                                      Expanded(child: Text("${snapshot.data![index]['Proyecto_Nombre']}", style: TextStyle(height: 1.6, fontSize: 13),))
                                    ],
                                  ),

                                  SizedBox(height: 25,),

                                  Row(
                                    children: [
                                      Text("Título de Incidencia:", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),)
                                    ],
                                  ),




                                  Divider(height: 8,),

                                  Row(
                                    children: [
                                      Expanded(child: Text("${snapshot.data![index]['Incidencia_Titulo']}", style: TextStyle(height: 1.6, fontSize: 13),))
                                    ],
                                  ),

                                  SizedBox(height: 25,),
                                  Row(
                                    children: [
                                      Text("Descripción del Incidente:", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),


                                    ],
                                  ),
                                  Divider(height: 8,),
                                  Row(
                                    children: [
                                      Expanded(child: Text("$descParse", style: TextStyle(height: 1.6, fontSize: 13),))
                                    ],
                                  ),

                                  SizedBox(height: 25,),

                                  Row(
                                    children: [
                                      Text("Pasos para Reproducir Incidente:", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                                    ],
                                  ),
                                  Divider(height: 8,),
                                  Row(
                                    children: [
                                      Expanded(child: Text("${snapshot.data![index]['Incidencia_Pasos']}", style: TextStyle(height: 1.6, fontSize: 13),))
                                    ],
                                  ),

                                  Divider(height: 25,),



                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          width:  MediaQuery.of(context).size.width*0.35,
                                          child: Text("Ámbito:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                      Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context).size.width*0.50,
                                          child: Text("${snapshot.data![index]['ambito']}", style: TextStyle(fontSize: 13,)))
                                    ],
                                  ),
                                  Divider(height: 16,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          width:  MediaQuery.of(context).size.width*0.35,
                                          child: Text("Tipo Contacto:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                      Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context).size.width*0.50,
                                          child: Text("${snapshot.data![index]['Incidencia_Contacto']}", style: TextStyle(fontSize: 13,)))
                                    ],
                                  ),
                                  Divider(height: 16,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          width:  MediaQuery.of(context).size.width*0.35,
                                          child: Text("Fecha Ejecución Programada:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),

                                      Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context).size.width*0.50,
                                          child: Text("${fechaProg}", style: TextStyle(fontSize: 13,)))
                                    ],
                                  ),
                                  Divider(height: 16,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          width:  MediaQuery.of(context).size.width*0.35,
                                          child: Text("Tipo Relación:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),

                                      Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context).size.width*0.50,
                                          child: Text("${tipoRelacion}", style: TextStyle(fontSize: 13,)))
                                    ],
                                  ),

                                  Divider(height: 16,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          width:  MediaQuery.of(context).size.width*0.35,
                                          child: Text("Inc. Relacionada:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                      Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context).size.width*0.50,
                                          child: Text("${incRelacion}", style: TextStyle(fontSize: 13,)))


                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Divider(height: 16,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Flag Backlog:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                                          Container(child: flag_backlog,)
                                        ],
                                      ),
                                      //${snapshot.data![index]['Incidencia_Flag_Backlog']}

                                      Row(
                                        children: [
                                          Text("Contiene Pase:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                                          Container(child: contiene_pase,)
                                        ],
                                      ),

                                      //${snapshot.data![index]['Incidencia_Pase']}

                                    ],
                                  ),


                                ],
                              ),
                            ),
                          ),

                          Divider(height: 25,),



                          Container(
                            decoration: BoxDecoration(        color: Color(0xffB60303),  borderRadius: BorderRadius.circular(10.0) ),
                            child:  Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(

                                    children: [
                                      Icon(Icons.app_registration, color: Colors.white, size: 16,),
                                      Text("  Causa", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),)
                                    ],
                                  ),
                                ),

                                Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 4,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width:  MediaQuery.of(context).size.width*0.35,
                                                child: Text("Categoría Causa:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                            Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context).size.width*0.50,
                                                child: Text("${snapshot.data![index]['Incidencia_Categoria_Causa']}", style: TextStyle(fontSize: 13,)))
                                          ],
                                        ),


                                        Divider(height: 14,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width:  MediaQuery.of(context).size.width*0.35,
                                                child: Text("Tipo Causa:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                            Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context).size.width*0.50,
                                                child: Text("${snapshot.data![index]['Tipo_Causa_Nombre']}", style: TextStyle(fontSize: 13,)))
                                          ],
                                        ),

                                        Divider(height: 14,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width:  MediaQuery.of(context).size.width*0.35,
                                                child: Text("Descripción Causa:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                            Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context).size.width*0.50,
                                                child: Text("${descCausa}", textAlign: TextAlign.center, style: TextStyle(fontSize: 13,)))
                                          ],
                                        ),
                                        Divider(height: 14,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width:  MediaQuery.of(context).size.width*0.35,
                                                child: Text("Solución Causa:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                            Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context).size.width*0.50,
                                                child: Text("${solCausa}", style: TextStyle(fontSize: 13,)))
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),



                              ],
                            ),

                          ),



                          Divider(height: 30,),




                          SizedBox(height: 4,),
                          Container(
                            decoration: BoxDecoration(        color: Color(0xffB60303),  borderRadius: BorderRadius.circular(10.0) ),



                            child: Column(
                              children: [

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(

                                    children: [
                                      Icon(Icons.person_sharp, color: Colors.white, size: 16,),
                                      Text("  Equipo de Trabajo", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),)
                                    ],
                                  ),
                                ),


                                Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 4,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width:  MediaQuery.of(context).size.width*0.35,
                                                child: Text("Responsable:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                            Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context).size.width*0.50,
                                                child: Text("${snapshot.data![index]['Responsable_Nombre']}", textAlign: TextAlign.center,  style: TextStyle(fontSize: 13)))
                                          ],
                                        ),


                                        Divider(height: 12,),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width:  MediaQuery.of(context).size.width*0.35,
                                                child: Text("Analista DTECH:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                            Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context).size.width*0.50,
                                                child: Text("${snapshot.data![index]['Analista_Nombre']}", textAlign: TextAlign.center, style: TextStyle(fontSize: 13,)))
                                          ],
                                        ),

                                        Divider(height: 12,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width:  MediaQuery.of(context).size.width*0.35,
                                                child: Text("Responsable TI Cliente:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                            Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context).size.width*0.50,
                                                child: Text("${respCliTI}", style: TextStyle(fontSize: 13,)))
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),



                              ],
                            ),

                          ),
                          Divider(height: 30,),



                          SizedBox(height: 4,),
                          Container(
                            decoration: BoxDecoration(        color: Color(0xffB60303),  borderRadius: BorderRadius.circular(10.0) ),


                            child: Column(
                              children: [

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(

                                    children: [
                                      Icon(Icons.file_copy_rounded, color: Colors.white, size: 16,),
                                      Text("   Archivos de Entregable", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),)
                                    ],
                                  ),
                                ),

                                Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 4,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width:  MediaQuery.of(context).size.width*0.35,
                                                child: Text("Informe del Incidente:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                            Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context).size.width*0.50,
                                                child: Text("${infInc}", style: TextStyle(fontSize: 13,)))
                                          ],
                                        ),

                                        Divider(height: 12,),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width:  MediaQuery.of(context).size.width*0.35,
                                                child: Text("Paquete de Archivos:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                            Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context).size.width*0.50,
                                                child: Text("${paqArchivos}", style: TextStyle(fontSize: 13,)))
                                          ],
                                        ),

                                        Divider(height: 12,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width:  MediaQuery.of(context).size.width*0.35,
                                                child: Text("Proc. de Instalación:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                            Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context).size.width*0.50,
                                                child: Text("${procInstalacion}", style: TextStyle(fontSize: 13,)))
                                          ],
                                        ),


                                        Divider(height: 12,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width:  MediaQuery.of(context).size.width*0.35,
                                                child: Text("Casos de Prueba:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                            Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context).size.width*0.50,
                                                child: Text("${casosPruebas}", style: TextStyle(fontSize: 13,)))
                                          ],
                                        ),


                                        Divider(height: 12,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width:  MediaQuery.of(context).size.width*0.35,
                                                child: Text("Proc. para el Usuario:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                            Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context).size.width*0.50,
                                                child: Text("${procUsuario}", style: TextStyle(fontSize: 13,)))
                                          ],
                                        ),


                                      ],
                                    ),
                                  ),
                                ),


                              ],
                            ),

                          )




                        ],
                      ),





                    ),
                  );

                }



            )
                : const Center(
              // render the loading indicator
              child: CircularProgressIndicator(),
            ))
    );
  }


  //Request JSON directo
  Future <List< dynamic>> RequestIncidenciasGeneralesDetalle() async {
    int? idIncidente = widget.idInc;
    var url = 'https://app.eco2biz.com/intrasolution/ws/null/pr_ws_lista_incidentes_generales_detalle?Incidencia_Id=$idIncidente';

    /*
    var mapIncGen = Map<String, dynamic>();
    mapIncGen['Incidencia_Id'] = '81010';
     */

    var response = await http.post(Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "userLogin": "joshua.rojas@intrasolution",
        "userPassword": "928504589",
        "systemRoot": "intrasolution"},
      //    body: jsonEncode(mapIncGen)
    );

    print("${response.statusCode}");
    var data_base = jsonDecode(response.body);
    var data = jsonDecode(response.body)['data'];
    List  results = [];
    //results = data.map((e) => EmpleadoIncGen_model.fromJson(e)).toList();

    print("data_base ---> ${data_base}");
    print("data ----> ${data}]");
    return data;

  }

  //Request JSON directo
  Future <List< dynamic>> RequestCantidadIncidente(int cod) async {
    var url = '${Host.host}pr_ws_cantidad_incidentes?cod_estado=$cod';
    var mapIncGen = Map<String, dynamic>();

    var response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "userLogin": "joshua.rojas@intrasolution",
          "userPassword": "928504589",
          "systemRoot": "intrasolution"},
        body: jsonEncode(mapIncGen)
    );
    print("${response.statusCode}");
    // print("${response.body}");
    // OBJECT JSON
    // var data =[];
    // data = json.decode(response.body)['data'] ;
    var data = jsonDecode(response.body)['data'];
    List  results = [];
    //   results = data.map((e) => EmpleadoIncGen_model.fromJson(e)).toList();
    print("data ----> ${data}]");
    return data;
  }


}
