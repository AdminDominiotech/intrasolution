import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:safe2biz/app/global/core/core.dart';
import 'package:safe2biz/app/modules/dmt/Database/host.dart';
import 'package:safe2biz/app/modules/dmt/Entidad/EmpleadoIncGen_model.dart';
import 'package:safe2biz/app/modules/dmt/modulos/Incidencias/IncidenciaDetalle.dart';
import 'package:http/http.dart' as http;
import 'package:safe2biz/app/modules/dmt/modulos/SaldoProyecto/SaldoProyectoDetalle.dart';

class SaldoProyecto extends StatefulWidget {

  final String? usr_log, sc_id;

  const SaldoProyecto({Key? key, this.usr_log, this.sc_id}) : super(key: key);

  @override
  State<SaldoProyecto> createState() => _SaldoProyectoState();
}


NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

class _SaldoProyectoState extends State<SaldoProyecto> {
  int? cantidad;
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _asyncMethod();
    });
  }



  _asyncMethod() async {
    List cant = await RequestCantidadIncidente(1);
    cantidad = cant[0]['cantidad'];
    print("cod 50 ---> ${cantidad}");
  }

  @override
  Widget build(BuildContext context) {

    String f_cliente = 'Seleccionar';
    String f_moneda = 'Seleccionar';



    //TipoFactura
    bool facturaSoles = true;
    bool facturaDolares = false;

    //Colores estado
    Color? colorEstado;
    String? ambitoImg;


    return Scaffold(
        appBar: AppBar(
          title: Text("Saldo Proyecto"),
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
              child: InkWell(onTap: () async{

                {

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
                              height: MediaQuery.of(context).size.height*0.5,
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
                                                            f_cliente = newValue!;
                                                            print("valorAnho--> ${newValue}");

                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),

                                              SizedBox(height: 15,),


                                              //================CLIENTE

                                              Text("Moneda", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
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
                                                            'Soles ',
                                                            'Dolares',


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
                  }
                }
              }, child: Icon(Icons.filter_list_alt, size: 0,) ),
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
                  future: RequestSaldoActivo(),

                  builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>

                  snapshot.hasData ? ListView.builder(

                      itemCount: snapshot.data!.length,

                      itemBuilder: (BuildContext context, index) {



                        String codEstado = "${snapshot.data![index]['estado_venta']}";
                        String ambInc =  "${snapshot.data![index]['ambito']}";

                        String pry_estado = "${snapshot.data![index]['estado']}";

                        String monto_proyecto_dolares = "${snapshot.data![index]['monto_proyecto_dolares']}";
                        String monto_facturado_dolares = "${snapshot.data![index]['monto_facturado_dolares']}";


                        if(monto_proyecto_dolares == null  || monto_proyecto_dolares == 'null'){

                          monto_proyecto_dolares = '0';

                        }
                        if(monto_facturado_dolares == null  || monto_facturado_dolares == 'null'){

                          monto_facturado_dolares = '0';

                        }



                        double monto_proy = double.parse(monto_proyecto_dolares);
                        String monto_pry = myFormat.format(monto_proy);

                        double monto_fac =double.parse(monto_facturado_dolares);
                        String monto_fact = myFormat.format(monto_fac);

                        double saldoProy = monto_proy-monto_fac;
                        String saldoPry = myFormat.format(saldoProy);

                        if(pry_estado == '1'){
                          pry_estado = 'Activo';
                        }

                        if(snapshot.data![index]['monto_soles'] == null  ){

                          facturaSoles = false;
                          facturaDolares = true;

                        }else{
                          facturaSoles = true;
                          facturaDolares = false;

                        }


                        if(ambInc == "INT"){
                          ambitoImg = 'assets/icons/interno-icon.png';
                        }else if(ambInc == "EXT"){
                          ambitoImg = 'assets/icons/externo-icon.png';
                        }



                        if(codEstado == 'Facturado'){
                          colorEstado = Color(0xffFF0000);
                        }else if(codEstado == 'Por Pagar' ){
                          colorEstado =  Color(0xffFF8000);
                        }else{
                          colorEstado =  Color(0xff309630);
                        }

                        return Container(


                          width: MediaQuery.of(context).size.width*1,



                          // render list item
                          child: ListTile(
                            onTap: (){

                              print("Facturas ID");


                              //fixme: facturas ID

                              int idProy = snapshot.data![index]['pry_proyecto_id'];

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      SaldoProyectoDetalle(
                                        idSaldoProy: idProy,
                                        montoProy: "$monto_pry",
                                        montoFac: "$monto_fact",
                                        total: saldoPry,
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
                                                              Row(
                                                                children: [
                                                                  //Text("${snapshot.data![index]['numero_factura']} - ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                                                  Text("${snapshot.data![index]['codigo_proyecto']}", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
                                                                ],

                                                              ),
                                                              Text("${snapshot.data![index]['fecha_inicio_estimada'].substring(0,10)}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFFB60303)),),
                                                            ],
                                                          ),
                                                          Divider(height: 12,),
                                                          Row(

                                                            children: [
                                                              Expanded(child: Container(child: Text("${snapshot.data![index]['descripcion']}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10, height: 1.5, color: Colors.grey),))),
                                                              // Image.asset("${ambitoImg}", width: 20,),
                                                            ],
                                                          ),
                                                          SizedBox(height: 12,),
                                                          Visibility(
                                                            visible: facturaSoles,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Column(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    Container(

                                                                      width: MediaQuery.of(context).size.width*0.43,
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Column(

                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  Align(
                                                                                    alignment: Alignment.centerLeft,
                                                                                    child: Container(
                                                                                        child: Text("Monto Pry.    ", style: TextStyle(fontSize: 11, color: Colors.black, height: 1.6, fontWeight: FontWeight.bold ),)
                                                                                    ),
                                                                                  ),
                                                                                  Container(child:  Text(" \$ $monto_pry", style: TextStyle(fontSize: 12),),)
                                                                                ],
                                                                              ),


                                                                              Row(
                                                                                children: [
                                                                                  Container(
                                                                                    width: MediaQuery.of(context).size.width*0.40,
                                                                                    child: Column(
                                                                                      children: [
                                                                                        Row(
                                                                                          children: [
                                                                                            Container(
                                                                                                child: Text("Monto Fact.  ",  style: TextStyle(fontSize: 11, color: Colors.black, height: 1.6, fontWeight: FontWeight.bold ),)),
                                                                                            Container(child:  Text(" \$ $monto_fact ",  style: TextStyle(fontSize: 12),),),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),


                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),

                                                                Container(
                                                                  width: MediaQuery.of(context).size.width*0.32,
                                                                  child:
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                                    children: [
                                                                      Column(
                                                                        children: [
                                                                          Text(" Saldo Proy.", style: TextStyle( fontSize: 12, fontWeight: FontWeight.bold),),
                                                                          SizedBox(height: 3,),
                                                      /*Antes S/.*/       Text("\$ $saldoPry", style: TextStyle( fontWeight: FontWeight.w500, fontSize: 12),),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),

                                                          Visibility(
                                                            visible: facturaDolares,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: [
                                                                Column(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width*0.45,
                                                                          child: Column(
                                                                            children: [
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  Align(
                                                                                    alignment: Alignment.centerLeft,
                                                                                    child: Container(
                                                                                        child: Text("Monto Proy.:      ",  style: TextStyle(fontSize: 11, color: Colors.black, height: 1.6, fontWeight: FontWeight.bold ),)),
                                                                                  ),
                                                                                  Container(child:  Text("\$ $monto_pry", style: TextStyle(fontSize: 12),),)
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),

                                                                    Row(
                                                                      children: [
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width*0.45,
                                                                          child: Column(
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Container(
                                                                                      child: Text("Monto Fact.:    ",  style: TextStyle(fontSize: 12, color: Colors.black, height: 1.6, fontWeight: FontWeight.bold ),)),
                                                                                  Container(child:  Text("\$ $monto_fact ", style: TextStyle(fontSize: 12),))
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),

                                                                  ],
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width*0.32,
                                                                  child:


                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                                    children: [
                                                                      Column(
                                                                        children: [
                                                                          Text("Saldo Proy.", style: TextStyle( fontSize: 12, fontWeight: FontWeight.bold),),
                                                                          SizedBox(height: 3,),
                                                                          Text("\$  $saldoPry ", style: TextStyle( fontWeight: FontWeight.w500, fontSize: 13),),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),



                                                          SizedBox(height: 15,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [Text("${snapshot.data![index]['cliente']}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)],
                                                              ),

                                                              Container(
                                                                  width: 95,
                                                                  height: 28,
                                                                  child: ElevatedButton(onPressed: (){},
                                                                      style: ElevatedButton.styleFrom(
                                                                          shape: StadiumBorder(),
                                                                          backgroundColor: colorEstado
                                                                      ),
                                                                      child: FittedBox(child: Text("$pry_estado", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12) )  ))),
                                                              //ESTADO DE venta == 1/2 --- Activo / Inactivo
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
                              Text("0", style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                            ],
                          ),

                          VerticalDivider(
                            color: Colors.grey,
                            thickness: 0.5,
                          ),
                          Row(
                            children: [
                              Image.asset("assets/icons/icon-estado-verde.png", width: 25,),
                              SizedBox(width: 10,),
                              Text("${cantidad}", style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                            ],
                          ),
                          VerticalDivider(
                            color: Colors.grey,
                            thickness:  0.5,
                          ),
                          Row(
                            children: [

                              Text("Total:   "),
                              Text("${cantidad}", style:  TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
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
  Future <List< dynamic>> RequestSaldoActivo() async {
    var url = '${Host.host}pr_ws_lista_saldo_proyecto';
    var mapIncGen = Map<String, dynamic>();
    mapIncGen['usuario'] = '1';
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

  //Request JSON directo
  Future <List< dynamic>> RequestCantidadIncidente(int cod) async {
    var url = '${Host.host}pr_ws_cantidad_saldo_pry?cod_estado=1';
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




