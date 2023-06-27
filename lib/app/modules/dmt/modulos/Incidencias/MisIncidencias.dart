import 'dart:convert';

import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:safe2biz/app/global/core/core.dart';
import 'package:safe2biz/app/modules/dmt/Database/host.dart';
import 'package:safe2biz/app/modules/dmt/Entidad/EmpleadoIncGen_model.dart';
import 'package:safe2biz/app/modules/dmt/moduloCompany.dart';
import 'package:safe2biz/app/modules/dmt/modulos/Incidencias/IncidenciaDetalle.dart';
import 'package:http/http.dart' as http;


class MisIncidencias extends StatefulWidget {



  final String? user_login, sc_id;

  const MisIncidencias({Key? key, this.user_login, this.sc_id}) : super(key: key);

  @override
  State<MisIncidencias> createState() => _MisIncidenciasState();
}

class _MisIncidenciasState extends State<MisIncidencias> {



  String f_tipo_proy = 'Seleccionar';
  String f_estado = 'Seleccionar';
  String f_responsable = 'Seleccionar';
  String f_severidad = 'Seleccionar';
  String f_ambito = 'Seleccionar';
  String f_cliente = 'Seleccionar';


  int? sumaRojo;
  int? sumaNaranja;

  int? total;



  @override
  void initState(){
    super.initState();

  }




  @override
  Widget build(BuildContext context) {


    //Colores estado
    Color? colorEstado;
    String? ambitoImg;

    //Cantidad por estado
    int cantRojo = 0;
    int cantNaranja = 0;
    int cantVerde = 0;


    return Scaffold(
        appBar: AppBar(
          title: Text("Mis Incidencias"),
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ModulosSede(user_login: widget.user_login, sc_id: widget.sc_id,)));
            } ,
          ) ,

          actions: [


            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: InkWell(onTap: () async

            //=====FILTROS INCIDENCIA=====
                  {

                showGeneralDialog(
                  barrierLabel: "Label",
                  barrierDismissible: true,
                  barrierColor: Colors.black.withOpacity(0.5),
                  transitionDuration: Duration(milliseconds: 300),
                  context: context,
                  pageBuilder: (context, anim1, anim2) {
                    return Container(

                      child: Align(
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.6,
                          width: MediaQuery.of(context).size.width*0.9,

                          child: Material(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: MediaQuery.of(context).size.height*1,
                                width: MediaQuery.of(context).size.width*1,
                                color: Colors.white,
                                child: SizedBox.expand(child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(24.0),
                                      child: Container(
                                        child: Row(children: [
                                          Icon(Icons.filter_list_alt, size: 0,),
                                          SizedBox(width: 5,),
                                          Text("Filtrar por:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
                                        ],),
                                      ),
                                    ),
                                    Divider(height: 1,),


                                    Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [


                                          Text("Estado", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                          SizedBox(height: 8,),
                                          Container(

                                            width: MediaQuery.of(context).size.width*0.9,
                                            height: 50,

                                            decoration: BoxDecoration(
                                              //     color: Colors.red,
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                              border: Border.all(color: Colors.grey, width: 1),
                                            ),

                                            child: Align(

                                              alignment: Alignment.center,
                                              child: StatefulBuilder(builder: (context, setState) {
                                                return Container(
                                                  width: MediaQuery.of(context).size.width*0.74,
                                                  child: DecoratedBox(
                                                    decoration: ShapeDecoration(
                                                      //  color: Colors.cyan,
                                                      shape: RoundedRectangleBorder(
                                                        //     side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.cyan),
                                                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                                      ),
                                                    ),

                                                    child: DropdownButton<String>(
                                                      iconEnabledColor: Colors.black,
                                                      isExpanded: true,
                                                      value: f_estado,
                                                      underline: SizedBox(),
                                                      dropdownColor: Color(0xffEBEFFB),

                                                      items: <String>[

                                                        'Seleccionar',
                                                        '10. Solicitado',
                                                        '20. En Proceso de Atencion',
                                                        '30. En espera de Informacion del Cliente',
                                                        '40. Solucion Completada',
                                                        '45. Instalado en QA DTECH',
                                                        '46. Aprobado en QA DTECH',
                                                        '47. Solucionado SIN PASE',
                                                        '50. Pase Enviado o Instalado QA Cliente',
                                                        '60. Aprobado en QA del Cliente',
                                                        '70. Pase a Producción Enviado',
                                                        '80. Pase a Producción Ejecutado'

                                                      ].map<DropdownMenuItem<String>>((String value) {
                                                        return DropdownMenuItem<String>(
                                                          value: value,
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                value,
                                                                style: TextStyle(
                                                                    fontSize: 12, color: Colors.black),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }).toList(),
                                                      // Step 5.
                                                      onChanged: (String? newValue) async {
                                                        setState((){   } );
                                                        //          valorAnho = newValue!;
                                                        f_estado = newValue!;
                                                        print("valorAnho--> ${newValue}");

                                                        //   _asyncMethod(dropdownValue);
                                                        /*  Actualizar filtros
                                          Future.delayed(Duration(milliseconds: 200))
                                                        .then((value) => _refreshChart());
                                         */
                                                      },
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),

                                          SizedBox(height: 15,),


                                          //==============================ESTADO
                                          Text("Cliente", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                          SizedBox(height: 8,),
                                          Container(

                                            width: MediaQuery.of(context).size.width*0.9,
                                            height: 50,

                                            decoration: BoxDecoration(
                                              //     color: Colors.red,
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                              border: Border.all(color: Colors.grey, width: 1),
                                            ),

                                            child: Align(

                                              alignment: Alignment.center,
                                              child: StatefulBuilder(builder: (context, setState) {
                                                return Container(
                                                  width: MediaQuery.of(context).size.width*0.74,
                                                  child: DecoratedBox(
                                                    decoration: ShapeDecoration(
                                                      //  color: Colors.cyan,
                                                      shape: RoundedRectangleBorder(
                                                        //     side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.cyan),
                                                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                                      ),
                                                    ),

                                                    child: DropdownButton<String>(
                                                      iconEnabledColor: Colors.black,
                                                      isExpanded: true,
                                                      value: f_cliente,
                                                      underline: SizedBox(),
                                                      dropdownColor: Color(0xffEBEFFB),

                                                      items: <String>[

                                                        'Seleccionar',
                                                        'Buenaventura ',
                                                        'Compañia Minera Antapaccay',
                                                        'Compañia Minera Lincuna SAC',
                                                        'Cuzcatlan - FORTUNA SILVER',
                                                        'DOMINIOTECH SAC',
                                                        'Engie S.A.C',
                                                        'Fortuna Silver',
                                                        'Mansfield- FORTUNA SILVER',
                                                        'Petroperu SAC'


                                                      ].map<DropdownMenuItem<String>>((String value) {
                                                        return DropdownMenuItem<String>(
                                                          value: value,
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                value,
                                                                style: TextStyle(
                                                                    fontSize: 11, color: Colors.black),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }).toList(),
                                                      // Step 5.
                                                      onChanged: (String? newValue) async {
                                                        //          valorAnho = newValue!;
                                                        setState((){   } );
                                                        f_cliente = newValue!;
                                                        print("valorAnho--> ${newValue}");

                                                        //   _asyncMethod(dropdownValue);


                                                        /*  Actualizar filtros
                                                         Future.delayed(Duration(milliseconds: 200))
                                                        .then((value) => _refreshChart());
                                                        */

                                                      },
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),


                                          SizedBox(height: 15,),

                                          Text("Responsable", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                                          SizedBox(height: 8,),
                                          Container(

                                            width: MediaQuery.of(context).size.width*0.9,
                                            height: 50,

                                            decoration: BoxDecoration(
                                              //     color: Colors.red,
                                              borderRadius: BorderRadius.all(Radius.circular(5)),
                                              border: Border.all(color: Colors.grey, width: 1),
                                            ),

                                            child: Align(

                                              alignment: Alignment.center,
                                              child: StatefulBuilder(builder: (context, setState) {
                                                return Container(
                                                  width: MediaQuery.of(context).size.width*0.74,
                                                  child: DecoratedBox(
                                                    decoration: ShapeDecoration(
                                                      //  color: Colors.cyan,
                                                      shape: RoundedRectangleBorder(
                                                        //     side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.cyan),
                                                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                                                      ),
                                                    ),

                                                    child: DropdownButton<String>(
                                                      iconEnabledColor: Colors.black,
                                                      isExpanded: true,
                                                      value: f_responsable,
                                                      underline: SizedBox(),
                                                      dropdownColor: Color(0xffEBEFFB),

                                                      items: <String>[

                                                        'Seleccionar',
                                                        'Arroyo Zuloaga, Juan Alberto',
                                                        'Ayala Galindo, Kenny Scott Abel',
                                                        'Barbaran Quiroz, Bruno Paolo',
                                                        'Ccorahua Miramira, Katherine',
                                                        'Cubas Landa, Carlos German',
                                                        'Fajardo Díaz, Lorena',
                                                        'Felix  Galindo, Jorge Luis',
                                                        'Gutierrez Prado, Carlos Alberto',
                                                        'Lara Gurmendi, Victor Raul',
                                                        'Perez  Eusebio, Cesar',
                                                        'Perez Segovia, Jesus Alejandro ',
                                                        'Quispe Huari, Ronald German',
                                                        'Rojas Saavedra, Joshua Guillermo',
                                                        'Roque  Villavicencio, Mauro Max',
                                                        'Salinas Cuba, Valky Aleksei',
                                                        'Torres  Visso, Eliana',
                                                        'Vergel Ramos, Guillermo Andres'

                                                      ].map<DropdownMenuItem<String>>((String value) {
                                                        return DropdownMenuItem<String>(
                                                          value: value,
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                value,
                                                                style: TextStyle(
                                                                    fontSize: 11, color: Colors.black),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }).toList(),
                                                      // Step 5.
                                                      onChanged: (String? newValue) async {
                                                        //          valorAnho = newValue!;
                                                        setState((){   } );
                                                        f_responsable = newValue!;
                                                        print("valorAnho--> ${newValue}");

                                                        //   _asyncMethod(dropdownValue);


                                                        /*  Actualizar filtros
                                                         Future.delayed(Duration(milliseconds: 200))
                                                        .then((value) => _refreshChart());
                                                        */

                                                      },
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),

                                          //================CLIENTE

                                          SizedBox(height: 15,),



                                          SizedBox(height: 30,),
                                          Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Container(
                                              width: MediaQuery.of(context).size.width*0.9,
                                              height: 45,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor: Color(0xffB60303)
                                                ),
                                                onPressed: (){

                                                },
                                                child: Text("Filtrar", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                              ),
                                            ),
                                          )

                                        ],
                                      ),
                                    ),




                                  ],
                                )),
                                //    margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  transitionBuilder: (context, anim1, anim2, child) {
                    return SlideTransition(
                      position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
                      child: child,
                    );
                  },
                );

              },

                  child: Icon(Icons.filter_list_alt, size: 0,) ),
            ),


            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: InkWell(onTap: () async{



              }, child: Icon(Icons.refresh) ),
            )
          ],
        ),



        body:Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: RequestIncidenciasGenerales(),

                  builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>



                  snapshot.hasData ? ListView.builder(

                      itemCount: snapshot.data!.length,

                      itemBuilder: (BuildContext context, index) {

                        String codEstado = "${snapshot.data![index]['Estado_Incidencia_Codigo']}";
                        String ambInc =  "${snapshot.data![index]['ambito']}";



                        if(ambInc == "INT"){
                          ambitoImg = 'assets/icons/interno-icon.png';
                        }else if(ambInc == "EXT"){
                          ambitoImg = 'assets/icons/externo-icon.png';
                        }


                        if(codEstado == '10. SOLICITADO' || codEstado == '20. ATENCION' || codEstado == '46. APROB_QA_DT' || codEstado == '45. INST_QA_DT'){
                          colorEstado = Color(0xffFF0000);


                          cantRojo = snapshot.data!.length;

                          print("cantidad rojo--->${cantRojo}");

                        }
                        else if(codEstado == '50. ENV_QA_CLI' ){
                          colorEstado =  Color(0xffFF8000);
                          cantNaranja = snapshot.data!.length;

                        }else{
                          colorEstado =  Color(0xff309630);
                          cantVerde++;
                          print("cantidad verde --> ${cantVerde}");
                        }


                        /*

                        Future.delayed(Duration(milliseconds: 2000), (){
                          total = snapshot.data!.length;
                        });

                         */


                        return Container(


                          width: MediaQuery.of(context).size.width*1,



                          // render list item
                          child: ListTile(
                            onTap: (){

                              int idInc = snapshot.data![index]['Incidencia_Id'];

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      IncidenciaDetalle(
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
                                                          ), ),

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
                                                              Text("${snapshot.data![index]['Incidencia_Ticket']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                                              Text("${snapshot.data![index]['Incidencia_Fecha'].substring(0,10)} -" " ${snapshot.data![index]['Incidencia_Hora'].substring(0,5)}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFFB60303)),),
                                                            ],
                                                          ),
                                                          Divider(height: 12,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text("${snapshot.data![index]['Tipo_Incidencia_Nombre']}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),),
                                                              Image.asset("${ambitoImg}", width: 20,),

                                                            ],
                                                          ),
                                                          SizedBox(height: 12,),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                  child: Text("${snapshot.data![index]['Incidencia_Titulo']}", maxLines: 2, style: TextStyle(fontSize: 12, color: Colors.grey, height: 1.6),))
                                                            ],
                                                          ),
                                                          SizedBox(height: 15,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text("${snapshot.data![index]['Proyecto_Codigo']}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11),),
                                                              Container(
                                                                  width: 105,
                                                                  height: 28,
                                                                  child: ElevatedButton(onPressed: (){},
                                                                      style: ElevatedButton.styleFrom(
                                                                          shape: StadiumBorder(),
                                                                          backgroundColor: colorEstado

                                                                      ),
                                                                      child: FittedBox(child: Text("${snapshot.data![index]['Estado_Incidencia_Codigo']}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12) )  ))),
                                                            ],
                                                          )
                                                          //Suma de registros
                                                          //Lista de nro de total de factura y monto
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
              future: Future.delayed(Duration(milliseconds: 2000), (){}),
              // delay for 2 seconds
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text("Cargando ..."),
                  );
                }
                else {

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
                              Text("${cantRojo}", style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
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
                              Text("${cantNaranja}", style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                            ],
                          ),
                          VerticalDivider(
                            color: Colors.grey,
                            thickness:  0.5,
                          ),
                          Row(
                            children: [

                              Text("Total:   "),
                              Text("${cantRojo+cantNaranja}", style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
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
  Future <List< dynamic>> RequestIncidenciasGenerales() async {


    var url = '${Host.host}pr_ws_lista_incidentes_usuario?user_login=${widget.user_login}';

   // var mapIncGen = Map<String, dynamic>();
    //mapIncGen['user_login'] = '$user_login';

    var response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "userLogin": "joshua.rojas@intrasolution",
          "userPassword": "928504589",
          "systemRoot": "intrasolution"},
        //body: jsonEncode(mapIncGen)
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

