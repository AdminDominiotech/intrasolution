import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:safe2biz/app/global/core/core.dart';
import 'package:safe2biz/app/modules/dmt/Database/host.dart';
import 'package:safe2biz/app/modules/dmt/Entidad/EmpleadoIncGen_model.dart';
import 'package:safe2biz/app/modules/dmt/modulos/Incidencias/IncidenciaDetalle.dart';
import 'package:http/http.dart' as http;
import 'package:safe2biz/app/modules/dmt/modulos/Pases/PaseDetalle.dart';

class Pases extends StatefulWidget {


 final String? usr_log, sc_id;

  const Pases({Key? key, this.usr_log, this.sc_id}) : super(key: key);

  @override
  State<Pases> createState() => _IncidenciasState();
}

class _IncidenciasState extends State<Pases> {


  String f_tipo_pase = 'Seleccionar';
  String f_estado = 'Seleccionar';
  String f_responsable = 'Seleccionar';
  String f_severidad = 'Seleccionar';
  String f_ambito = 'Seleccionar';
  String f_cliente = 'Seleccionar';

  int? sumaRojo;
  int? sumaNaranja;

  @override
  void initState(){
    super.initState();

     _asyncMethod();

  }


  _asyncMethod() async {
    List? cod10 = await RequestCantidadPases(10);
    List? cod20 = await RequestCantidadPases(20);
    List? cod80 = await RequestCantidadPases(80);
    List? cod30 = await RequestCantidadPases(30);
    List? cod60 = await RequestCantidadPases(60);
    List? cod45 = await RequestCantidadPases(45);
    List? cod46 = await RequestCantidadPases(46);
    List? cod40 = await RequestCantidadPases(40);
    List? cod50 = await RequestCantidadPases(50);


    int? cant10 = cod10[0]['cantidad'];
    int? cant20 = cod20[0]['cantidad'];
    int? cant80 = cod80[0]['cantidad'];
    int? cant30 = cod30[0]['cantidad'];
    int? cant60 = cod60[0]['cantidad'];
    int? cant45 = cod45[0]['cantidad'];
    int? cant40 = cod40[0]['cantidad'];
    int? cant46 = cod46[0]['cantidad'];
    int? cant50 = cod50[0]['cantidad'];

    sumaRojo = cant10!+cant30!+cant40!+cant45!+cant46!+cant20!+cant80!;
    sumaNaranja = cant50!+cant60!;

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
          title: Text("Pases"),
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


          actions: [


            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: InkWell(onTap: () async

              //Filtros Pase

              {

                showGeneralDialog(
                  barrierLabel: "Label",
                  barrierDismissible: true,
                  barrierColor: Colors.black.withOpacity(0.5),
                  transitionDuration: Duration(milliseconds: 300),
                  context: context,
                  pageBuilder: (context, anim1, anim2) {
                    return Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.6,
                          width:  MediaQuery.of(context).size.width*0.9,
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
                                          Text("Tipo de Pase", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
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
                                                      value: f_tipo_pase,
                                                      underline: SizedBox(),
                                                      dropdownColor: Color(0xffEBEFFB),

                                                      items: <String>[
                                                        'Seleccionar',
                                                        'Framework',
                                                        'App Estándar',
                                                        'App Cliente',
                                                        'Otros'

                                                      ].map<DropdownMenuItem<String>>((String value) {
                                                        return DropdownMenuItem<String>(
                                                          value: value,
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                value,
                                                                style: TextStyle(
                                                                    fontSize: 16, color: Colors.black),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }).toList(),
                                                      // Step 5.
                                                      onChanged: (String? newValue) async {
                                                        //          valorAnho = newValue!;
                                                        setState((){   } );
                                                        f_tipo_pase = newValue!;
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
                                                        '20. Preparado',
                                                        '30. Instalado en QA de DTECH',
                                                        '40. Revisado en QA DTECH',
                                                        '50. Enviado a QA CLIENTE',
                                                        '60. Instalado en QA CLIENTE',

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


                                          /*
                                          //==============================Responsable


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

                                          */

                                          //================CLIENTE

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

                        String codEstado = "${snapshot.data![index]['orden']}";
                        String estado =  "${snapshot.data![index]['nombre_estado']}";



                        if(codEstado == '10' || codEstado == '20' || codEstado == '30' || codEstado == '46' || codEstado == '45' || codEstado == '40' || codEstado == '80'){
                          colorEstado = Color(0xffFF0000);

                          cantRojo = snapshot.data!.length;


                        }
                        else if(codEstado == '50' || codEstado == '60'   ){
                          colorEstado =  Color(0xffFF8000);

                          cantNaranja = snapshot.data!.length;

                        }


                        if(estado == '50. Enviado a QA CLIENTE'){
                          estado = '50. Env. QA Cliente';
                        }
                        else if (estado =='30. Instalado en QA de DTECH'){
                          estado='30. Inst. QA DTECH';
                        }
                        else if(estado=='60. Instalado en QA CLIENTE'){
                          estado = '60. Inst. QA CLIENTE';
                        }

                        else if(estado=='80. Instalado en PRODUCCIÓN CLIENTE'){
                          estado = '80. Inst. PROD CLIENTE';
                        }


                        return Container(


                          width: MediaQuery.of(context).size.width*1,

                          // render list item
                          child: ListTile(
                            onTap: (){
                              int idPase = snapshot.data![index]['id'];

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      PasesDetalle(
                                        idPase: idPase,
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
                                                              Text("${snapshot.data![index]['codigo']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                                              Text("${snapshot.data![index]['fecha_solicitud'].substring(0,10)}", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFFB60303)),),
                                                            ],
                                                          ),
                                                          Divider(height: 12,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text("${snapshot.data![index]['nombre_cliente']}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, ),),
                                                            //  Image.asset("${ambitoImg}", width: 20,),
                                                            ],
                                                          ),

                                                          SizedBox(height: 12,),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                  child: Text("${snapshot.data![index]['descripcion']}", maxLines: 2, style: TextStyle(fontSize: 12, color: Colors.grey, height: 1.6),))
                                                            ],
                                                          ),
                                                          SizedBox(height: 15,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text("${snapshot.data![index]['codigo_proyecto']}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),),
                                                              Container(
                                                                  width: 105,
                                                                  height: 28,
                                                                  child: ElevatedButton(onPressed: (){},
                                                                      style: ElevatedButton.styleFrom(
                                                                          shape: StadiumBorder(),
                                                                          backgroundColor: colorEstado

                                                                      ),
                                                                      child: FittedBox(child: Text("${estado}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12) )  ))),
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


            FutureBuilder(
              future: Future.delayed(Duration(milliseconds: 7000), (){}),
              // delay for 2 seconds

              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text("Cargando ..."),
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



          ],
        )
    );
  }

//Request JSON directo
  Future <List< dynamic>> RequestIncidenciasGenerales() async {


    var url = '${Host.host}pr_ws_lista_pases';
    var mapIncGen = Map<String, dynamic>();
    mapIncGen['dato'] = '1';

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




  //Request JSON directo
  Future <List< dynamic>> RequestCantidadPases(int cod) async {
    var url = '${Host.host}pr_ws_cantidad_pases?cod_estado=$cod';
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



