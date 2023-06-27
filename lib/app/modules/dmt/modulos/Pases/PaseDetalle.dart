import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:safe2biz/app/global/core/styles/colors.dart';
import 'package:safe2biz/app/modules/dmt/Database/host.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class PasesDetalle extends StatefulWidget {

  final int? idPase;
  PasesDetalle({Key? key, this.idPase}) : super(key: key);

  @override
  State<PasesDetalle> createState() => _PasesDetalleState();
}


class _PasesDetalleState extends State<PasesDetalle> {

  //Colores estado
  Color? colorEstado;


  Icon flag_cliente =  Icon(Icons.check_box_outline_blank, color: Color(0xffB60303));
  Icon flag_framework =  Icon(Icons.check_box_outline_blank, color: Color(0xffB60303));
  Icon flag_estandar =  Icon(Icons.check_box_outline_blank, color: Color(0xffB60303));


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
          title: Text("Pase"),
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

                  String desc = "${snapshot.data![index]['descripcion']}";
                  String? descParse;


                  final document = parse(desc);
                  final String parsedString = parse(document.body?.text).documentElement!.text;

                  descParse = parsedString;



                  String version_req_cliente = "${snapshot.data![index]['version_req_cliente']}";
                  String version_req_framwework = "${snapshot.data![index]['version_req_framwework']}";
                  String version_req_estandar = "${snapshot.data![index]['version_req_estandar']}";

                  String flag_v_cliente = "${snapshot.data![index]['flag_v_cliente']}";
                  String flag_v_framework = "${snapshot.data![index]['flag_v_framework']}";
                  String flag_v_estandar = "${snapshot.data![index]['flag_v_estandar']}";



                  if(version_req_cliente == ''){
                    version_req_cliente = '-';
                  }else if (version_req_framwework=='' ){
                    version_req_framwework = '-';
                  }else if (version_req_estandar=='' || version_req_estandar == null  ){
                    version_req_estandar = '-';
                  }

                  Icon checkIcon = Icon(Icons.check_box_rounded , color: Color(0xffB60303));

                  if (flag_v_cliente==1 ){
                    flag_cliente = checkIcon;
                  }else if (flag_v_framework==1 ){
                    flag_framework = checkIcon;
                  }else if (flag_v_estandar== 1 ){
                    flag_estandar = checkIcon;
                  }


                  String codEstado = "${snapshot.data![index]['orden']}";
                  String estado =  "${snapshot.data![index]['nombre_estado']}";

                  if(codEstado == '10' || codEstado == '20' || codEstado == '30' || codEstado == '46' || codEstado == '45' || codEstado == '40' || codEstado == '80'){
                    colorEstado = Color(0xffFF0000);
                  }
                  else if(codEstado == '50' || codEstado == '60'  ){
                    colorEstado =  Color(0xffFF8000);
                  }






                  if(estado == '50. Enviado a QA CLIENTE'){
                    estado = '50. Env. QA Cliente';
                  }
                  else if (estado =='30. Instalado en QA de DTECH'){
                    estado='30. Inst. QA DTECH';
                  }
                  else if(estado=='60. Instalado en QA CLIENTE'){
                    estado = '60. Inst. QA CLI';
                  }
                  else if(estado=='80. Instalado en PRODUCCIÓN CLIENTE'){
                    estado = '80. Inst. PROD CLI';
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
                                  Icon(Icons.app_registration, color: Colors.black, size: 18,),
                                  SizedBox(width: 5,),
                                  Text(" ${snapshot.data![index]['codigo']} ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                ],
                              ),
                              Text("${snapshot.data![index]['fecha_solicitud'].substring(0,10)} ",style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
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
                                   // FittedBox(child: Text(" ${snapshot.data![index]['nombre_cliente']}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),))
                                  ],
                                ),
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width*0.36,
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
                                      child: FittedBox(child: Text("${estado}", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),)),
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
                                      Text("Tipo Pase:  ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
                                      Text("${snapshot.data![index]['tipo_pase_nombre']}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("Versión:  ", style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400),),
                                      Text("${snapshot.data![index]['version']}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),)
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
                                      Text("Código del Proyecto:", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),



                                    ],
                                  ),
                                  Divider(height: 8,),

                                  Row(
                                    children: [
                                      Expanded(child: Text("${snapshot.data![index]['codigo_proyecto']}", style: TextStyle(height: 1.6, fontSize: 13),))
                                    ],
                                  ),

                                  SizedBox(height: 25,),

                                  Row(
                                    children: [
                                      Text("Nombre del Proyecto:", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),)
                                    ],
                                  ),




                                  Divider(height: 8,),

                                  Row(
                                    children: [
                                      Expanded(child: Text("${snapshot.data![index]['nombre_proyecto']}", style: TextStyle(height: 1.6, fontSize: 13),))
                                    ],
                                  ),

                                  SizedBox(height: 25,),
                                  Row(
                                    children: [
                                      Text("Descripción del Pase:", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),


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
                                      Text("Nombre Archivo Pase:", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                                    ],
                                  ),

                                  Divider(height: 8,),
                                  Row(
                                    children: [
                                      Expanded(child: Text("${snapshot.data![index]['nombre_archivo']}", style: TextStyle(height: 1.6, fontSize: 12, fontWeight: FontWeight.bold),))
                                    ],
                                  ),

                                  Divider(height: 25,),



                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          width:  MediaQuery.of(context).size.width*0.35,
                                          child: Text("URL Pase:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                      InkWell(
                                        onTap: (){
                                          launch('${snapshot.data![index]['url_pase']}');
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context).size.width*0.50,
                                            child: Text("${snapshot.data![index]['url_pase']}", style: TextStyle(fontSize: 11, height: 1.5, color: S2BColors.blue))),
                                      )
                                    ],
                                  ),
                                  Divider(height: 16,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          width:  MediaQuery.of(context).size.width*0.35,
                                          child: Text("Revisor:", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                      Container(

                                          width: MediaQuery.of(context).size.width*0.50,
                                          child: Text("${snapshot.data![index]['revisor']}", style: TextStyle(fontSize: 13, height: 1.5)))
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
                                      Text("  Detalle", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),)
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
                                                child: Text("Versión Requerida Cliente:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                            Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context).size.width*0.50,
                                                child: Text("${version_req_cliente}", style: TextStyle(fontSize: 13,)))
                                          ],
                                        ),


                                        Divider(height: 14,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width:  MediaQuery.of(context).size.width*0.35,
                                                child: Text("Versión Requerida Framework:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                            Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context).size.width*0.50,
                                                child: Text("${version_req_framwework}", style: TextStyle(fontSize: 13,)))
                                          ],
                                        ),
                                        Divider(height: 14,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width:  MediaQuery.of(context).size.width*0.35,
                                                child: Text("Versión Requerida Estándar:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                            Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context).size.width*0.50,
                                                child: Text("${version_req_estandar}", textAlign: TextAlign.center, style: TextStyle(fontSize: 13,)))
                                          ],
                                        ),
                                        Divider(height: 14,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width:  MediaQuery.of(context).size.width*0.35,
                                                child: Text("Flag Versión Requerida Cliente:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                            Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context).size.width*0.50,
                                                child: flag_cliente)
                                          ],
                                        ),
                                        Divider(height: 14,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width:  MediaQuery.of(context).size.width*0.35,
                                                child: Text("Flag Versión Requerida Framework:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                            Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context).size.width*0.50,
                                                child: flag_framework)
                                          ],
                                        ),

                                        Divider(height: 14,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                width:  MediaQuery.of(context).size.width*0.35,
                                                child: Text("Flag Versión Requerida Estándar:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                            Container(
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context).size.width*0.50,
                                                child: flag_estandar )
                                          ],
                                        ),


                                      ],
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



            )
                : const Center(
              // render the loading indicator
              child: CircularProgressIndicator(),
            ))
    );
  }


  //Request JSON directo
  Future <List< dynamic>> RequestIncidenciasGeneralesDetalle() async {
    int? idPase = widget.idPase;
    var url = 'https://app.eco2biz.com/intrasolution/ws/null/pr_ws_lista_pase_detalle?id_pase=$idPase';

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
