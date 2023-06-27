import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:safe2biz/app/global/core/core.dart';
import 'package:safe2biz/app/modules/dmt/Database/host.dart';
import 'package:safe2biz/app/modules/dmt/Entidad/EmpleadoIncGen_model.dart';
import 'package:safe2biz/app/modules/dmt/modulos/Incidencias/IncidenciaDetalle.dart';
import 'package:http/http.dart' as http;
import 'package:safe2biz/app/modules/dmt/modulos/Tareas/TareasDetalle.dart';

class Tareas extends StatefulWidget {



  const Tareas({Key? key}) : super(key: key);

  @override
  State<Tareas> createState() => _TareasState();
}

class _TareasState extends State<Tareas> {

  int? sumaRojo;
  int? sumaNaranja;

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _asyncMethod();
    });
  }

  _asyncMethod() async {




  }

  @override
  Widget build(BuildContext context) {

    //Colores estado
    Color? colorEstado;
    String? ambitoImg;

    //Cantidad de incidentes por color de estado
    int cantRojo = 0;
    int cantNaranja = 0;

    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Tareas"),
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
                Icon( Icons.arrow_back_ios ),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
            } ,
          ) ,

          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: InkWell(onTap: () async{

                setState(() {

                });
                //    await RequestIncidenciasGenerales();
              }, child: Icon(Icons.refresh) ),
            )
          ],
        ),


        body:Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: RequestMisTareas(),

                  builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>

                  snapshot.hasData ? ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, index) {

                        String? tipo_tarea = snapshot.data![index]['nombre_tipo_tarea'];


                        String? proy_modulo = snapshot.data![index]['nombre_proy'];

                        if(proy_modulo == 'null' || proy_modulo == null){
                          proy_modulo = 'No Especifíca';
                        }

                        if(tipo_tarea == 'Incidencia/Requerimiento'){
                          tipo_tarea = 'Incidencia / Req.';
                        }

                        /*
                        String codEstado = "${snapshot.data![index]['Estado_Incidencia_Codigo']}";
                        String ambInc =  "${snapshot.data![index]['ambito']}";


                        if(ambInc == "INT"){
                          ambitoImg = 'assets/icons/interno-icon.png';
                        }else if(ambInc == "EXT"){
                          ambitoImg = 'assets/icons/externo-icon.png';
                        }

                        if(codEstado == '10. SOLICITADO' || codEstado == '20. ATENCION' || codEstado == '46. APROB_QA_DT' || codEstado == '45. INST_QA_DT' || codEstado == '40. COMPLETADO'){
                          colorEstado = Color(0xffFF0000);
                        }
                        else if(codEstado == '50. ENV_QA_CLI' ){
                          colorEstado =  Color(0xffFF8000);
                        }
*/
                        return Container(


                          width: MediaQuery.of(context).size.width*1,

                          // render list item
                          child: ListTile(
                            onTap: (){
                              int idInc = snapshot.data![index]['id'];

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      TareasDetalle(
                                        idInc: idInc,
                                      ),),);

                            },

                            title: Container(

                              child: Row(
                                  children: [
                                    Expanded(
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10.0),
                                          ),
                                        ),
                                        elevation: 5,
                                        child:
                                        Padding(
                                          padding: EdgeInsets.only(right: 10.0, top: 0.0, bottom: 0.0),
                                          child: IntrinsicHeight(
                                            child: Container(
                                              width: MediaQuery.of(context).size.width*1,
                                              child: Row(
                                                children: [
                                                  Container(
                                                      width: 12,
                                                      height: double.infinity,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: colorEstado,
                                                          borderRadius: BorderRadius.only(
                                                              topLeft: Radius.circular(10),
                                                              bottomLeft: Radius.circular(10)
                                                          ),
                                                        ),
                                                      )
                                                  ),

                                                  SizedBox(width: 10,),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top:8.0, bottom: 8.0),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text("${snapshot.data![index]['nombre_subtipo_tarea']}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                                              Text("${snapshot.data![index]['fecha_inicio'].substring(0,10)}", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFFB60303)),),
                                                            ],
                                                          ),
                                                          Divider(height: 10,),



                                                          Row(
                                                            children: [
                                                              Text("Responsable: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                                                              Expanded(
                                                                  child: Text(" ${snapshot.data![index]['nombreCompleto']}", maxLines: 2, style: TextStyle(fontSize: 12, color: Colors.black, height: 1.6),))
                                                            ],
                                                          ),
                                                          SizedBox(height: 4,),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                  child: Text("${snapshot.data![index]['titulo_tarea']}", maxLines: 2, style: TextStyle(fontSize: 12, color: Colors.grey, height: 1.6),))
                                                            ],
                                                          ),

                                                          SizedBox(height: 8,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [

                                                              Row(
                                                                children: [
                                                                  Text("Horas Trabajo: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12,),),
                                                                  Text("${snapshot.data![index]['horas_trabajo']}", style: TextStyle( fontSize: 12),),
                                                                ],
                                                              ),

                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width:100,
                                                                    height: 30,
                                                                    child: ElevatedButton(
                                                                        onPressed: (){},
                                                                        style: ElevatedButton.styleFrom(
                                                                            shape: StadiumBorder(),
                                                                            backgroundColor: S2BColors.primaryColor
                                                                        ),
                                                                        child: Container(

                                                                            child: FittedBox(child: Text("${tipo_tarea}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)))),
                                                                  )
                                                                ],
                                                              ),

                                                            ],
                                                          ),

                                                          /*
                                                          Divider(height: 16,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Icon(Icons.build, size: 15, color: Color(0xffB60303),),
                                                              SizedBox(width: 8,),
                                                              Container(child: FittedBox(child: Text("${proy_modulo}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.black87),))),
                                                            ],
                                                          )
                                                          */

                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                        );
                      }
                  )
                      : const Center(
                    // render the loading indicator
                    child: CircularProgressIndicator(),
                  )),
            ),

            /*
            FutureBuilder(
              future: Future.delayed(Duration(milliseconds: 12000), (){}),
              // delay for 2 seconds
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else {
                  // return your UI widgets with the data
                  return Container(
                    height: 50,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 0.1),
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            children: [
                              Image.asset("assets/icons/icon-estado-rojo.png", width: 25,),
                              SizedBox(width: 10,),
                              Text("${sumaRojo}", style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                            ],
                          ),

                          VerticalDivider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
                          Row(
                            children: [
                              Image.asset("assets/icons/icon-estado-naranja.png", width: 25,),
                              SizedBox(width: 10,),
                              Text("${sumaNaranja}", style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                            ],
                          ),
                          VerticalDivider(
                            color: Colors.grey,
                            thickness:  0.5,
                          ),
                          Row(
                            children: [

                              Text("Total:   "),
                              Text("${sumaRojo!+sumaNaranja!}", style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),


            */
          ],
        )
    );
  }

//Request JSON directo
  Future <List< dynamic>> RequestMisTareas() async {


    var url = '${Host.host}pr_ws_lista_tareas_horas?dato=1';
    var mapIncGen = Map<String, dynamic>();
    // mapIncGen['usuario_id'] = '30040';

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

    var data = jsonDecode(response.body)['data'];
    List  results = [];
    //   results = data.map((e) => EmpleadoIncGen_model.fromJson(e)).toList();
    print("data ----> ${data}]");
    return data;
  }

/*
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

 */

}



