import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:safe2biz/app/global/core/styles/colors.dart';
import 'package:safe2biz/app/modules/dmt/Database/host.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';


class TareasDetalle extends StatefulWidget {

  final int? idInc;
  TareasDetalle({Key? key, this.idInc}) : super(key: key);

  @override
  State<TareasDetalle> createState() => _TareasDetalleState();
}




class _TareasDetalleState extends State<TareasDetalle> {

  //Colores estado
  Color? colorEstado;

  //Iconos
  Icon? flag_backlog;
  Icon? contiene_pase;

  Icon? flag_tarea_programada;
  Icon? flag_fuera_horario;


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
          title: Text("Tarea Detalle"),
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
                  String cli = snapshot.data![index]['nombre_cliente'];
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


                  String? desc = "${snapshot.data![index]['descripcion_tarea']}";
                  String? descParse;

                  //Parse HTML to  Flutter String

                    final document = parse(desc);
                    final String parsedString = parse(document.body?.text).documentElement!.text;

                    descParse = parsedString;


                  String? proy_modulo = snapshot.data![index]['nombre_proy'];

                  if(proy_modulo == 'null' || proy_modulo == null){
                    proy_modulo = 'No Especifíca';
                  }

                  String? obs = snapshot.data![index]['observacion'];
                  String? fecha_programada = snapshot.data![index]['fecha_ejecucion_programada'];
                  String? tipo_tarea = snapshot.data![index]['nombre_tipo_tarea'];

                  if(tipo_tarea == 'Incidencia/Requerimiento'){
                    tipo_tarea = 'Incidencia / Req.';
                  }


                  if(obs  == null || obs == ''){obs = 'No registra observaciones';}
                  if(fecha_programada  == null || fecha_programada == '' ){fecha_programada = '-';}



                  if(snapshot.data![index]['flag_fecha_ejecucion'] == 0 || snapshot.data![index]['flag_fecha_ejecucion'] == null ){
                    flag_tarea_programada = Icon(Icons.check_box_outline_blank, color: Color(0xffB60303));
                  }else if(snapshot.data![index]['flag_fecha_ejecucion'] == 1 ){
                    flag_tarea_programada = Icon(Icons.check_box_rounded , color: Color(0xffB60303));
                  }


                  if(snapshot.data![index]['flag_fuera_horario'] == 0 || snapshot.data![index]['flag_fuera_horario'] == null ){
                    flag_fuera_horario = Icon(Icons.check_box_outline_blank, color: Color(0xffB60303));
                  }else if(snapshot.data![index]['flag_fuera_horario'] == 1 ){
                    flag_fuera_horario = Icon(Icons.check_box_rounded , color: Color(0xffB60303));
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
                                  Icon(Icons.insert_drive_file_outlined, color: Colors.black, size: 18,),
                                  SizedBox(width: 5,),
                                  Text(" ${snapshot.data![index]['nombre_subtipo_tarea']} ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                ],
                              ),
                              Text("${snapshot.data![index]['fecha_inicio'].substring(0,10)}",style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
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
                                    Image.asset('$img', height: hg,),
                               //     FittedBox(child: Text(" ${snapshot.data![index]['nombre_cliente']}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),))
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
                                          backgroundColor: S2BColors.primaryColor
                                      ),
                                      onPressed: (){


                                      },
                                      child: FittedBox(child: Text("${tipo_tarea}", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),)),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text("Responsable:  ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
                                          Text("${snapshot.data![index]['nombre']}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)
                                        ],
                                      ),
                                      SizedBox(height: 10,),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text("Horas de Trabajo:  ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
                                          Text("${snapshot.data![index]['horas_trabajo']}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)
                                        ],
                                      ),
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
                                      Expanded(child: Text("${proy_modulo}", style: TextStyle(height: 1.6, fontSize: 13),))
                                    ],
                                  ),

                                  SizedBox(height: 25,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Título de Tarea:", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),



                                    ],
                                  ),
                                  Divider(height: 6,),

                                  Row(
                                    children: [
                                      Expanded(child: Text("${snapshot.data![index]['titulo_tarea']}", style: TextStyle(height: 1.6, fontSize: 13),))
                                    ],
                                  ),

                                  SizedBox(height: 25,),

                                  Row(
                                    children: [
                                      Text("Descripción de Tarea:", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),)
                                    ],
                                  ),




                                  Divider(height: 6,),

                                  Row(
                                    children: [
                                      Expanded(child: Text("$descParse", style: TextStyle(height: 1.6, fontSize: 13),))
                                    ],
                                  ),


                                  SizedBox(height: 25,),

                                  Row(
                                    children: [
                                      Text("Observacion:", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                                    ],
                                  ),
                                  Divider(height: 6,),
                                  Row(
                                    children: [
                                      Expanded(child: Text("${obs}", style: TextStyle(height: 1.6, fontSize: 13),))
                                    ],
                                  ),


                                  Divider(height: 25,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Tarea Programada:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                                          Container(child: flag_tarea_programada,)
                                        ],
                                      ),
                                      //${snapshot.data![index]['Incidencia_Flag_Backlog']}

                                      Row(
                                        children: [
                                          Text("Fuera de Horario:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                                          Container(child: flag_fuera_horario,)
                                        ],
                                      ),

                                      //${snapshot.data![index]['Incidencia_Pase']}

                                    ],
                                  ),
/*
                                  Divider(height: 25,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          width:  MediaQuery.of(context).size.width*0.35,
                                          child: Text("Fecha Programada:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                      Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context).size.width*0.50,
                                          child: Text("${fecha_programada}", style: TextStyle(fontSize: 13,)))
                                    ],
                                  ),
 */

                                ],
                              ),
                            ),
                          ),




                        ],
                      ),





                    ),
                  );

                }



            )
                :  Center(


              // render the loading indicator
              child: CircularProgressIndicator(),


            ))
    );
  }


  //Request JSON directo
  Future <List< dynamic>> RequestIncidenciasGeneralesDetalle() async {
    int? idIncidente = widget.idInc;
    var url = 'https://app.eco2biz.com/intrasolution/ws/null/pr_ws_tarea_detalle?incidencia_hh=$idIncidente';

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

/*
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


   */

}
