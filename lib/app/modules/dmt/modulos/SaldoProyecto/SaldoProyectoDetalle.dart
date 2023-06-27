import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:safe2biz/app/global/core/styles/colors.dart';
import 'package:safe2biz/app/modules/dmt/Database/host.dart';
import 'package:http/http.dart' as http;

class SaldoProyectoDetalle extends StatefulWidget {

  final int? idSaldoProy;
  final String? montoProy;
  final String? montoFac;
  final String? total;
  SaldoProyectoDetalle({Key? key, this.idSaldoProy, this.montoFac, this.total, this.montoProy}) : super(key: key);

  @override
  State<SaldoProyectoDetalle> createState() => _SaldoProyectoDetalleState();
}


class _SaldoProyectoDetalleState extends State<SaldoProyectoDetalle> {

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
          title: Text("Saldo Proyecto Detalle", style: TextStyle(fontSize: 18),),
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
                  String cli = snapshot.data![index]['cliente'];
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

                  String? obs = snapshot.data![index]['observacion'];
                  String? fecha_programada = snapshot.data![index]['fecha_ejecucion_programada'];
                  String? tipo_tarea = snapshot.data![index]['nombre_tipo_tarea'];


                  //Monto soles / dolares

                  /*
                  String cli = snapshot.data![index]['monto_dolares'];
                  if(cli == 'DOMINIOTECH SAC'){
                    String img = 'assets/logo/logo-dmt.jpg';
                  }

                   */


                  String? monto;
                  double? monto_dolares = snapshot.data![index]['monto_dolares'];
                  double? monto_soles = snapshot.data![index]['monto_soles'];

                  if(monto_dolares == null && monto_soles != null){
                    monto = "\$ ${(monto_soles/3.50).toStringAsFixed(2)}";
                  }
                  if(monto_soles == null && monto_dolares != null){
                    monto = "\$ $monto_dolares";
                  }


                  if(tipo_tarea == 'Incidencia/Requerimiento'){
                    tipo_tarea = 'Incidencia / Req.';
                  }

                  if(obs  == null || obs == ''){obs = 'No especifica observaciones';}
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



                  if(snapshot.data![index]['estado'] == 'ACTIVO'){
                    colorEstado = Color(0xff309630);
                  }else{
                    colorEstado = Color(0xffB60303);
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
                                  Icon(Icons.receipt_long_rounded, color: Colors.black, size: 16,),
                                  SizedBox(width: 5,),
                                  Text(" ${snapshot.data![index]['codigo_proyecto']} ", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                ],
                              ),
                              Text("  ",style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
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

                                    // FittedBox(child: Text(" ${snapshot.data![index]['cliente']}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),))

                                  ],
                                ),
                              ),



                              Container(
                                width: MediaQuery.of(context).size.width*0.35,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: StadiumBorder(),
                                            backgroundColor: colorEstado
                                        ),
                                        onPressed: (){

                                        },
                                        child: FittedBox(child: Text("${snapshot.data![index]['estado']}", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),)),
                                      ),
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
                                  Row(
                                    children: [
                                      Text("Proyecto:  ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
                                      Container(
                                          width: MediaQuery.of(context).size.width*0.7,
                                          child: Text("${snapshot.data![index]['proyecto']}", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, height: 1.4),))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            width: MediaQuery.of(context).size.width*1,
                            decoration: BoxDecoration(        color: Colors.white,  borderRadius: BorderRadius.circular(10.0) ),
                            child:   Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width*1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.5,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text("Monto:    ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
                                              Text("        \$ ${widget.montoProy}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),)
                                            ],
                                          ),
                                          SizedBox(height: 8,),
                                          Row(
                                            children: [
                                              Text("Monto Fact:   ", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
                                              Text("\$ ${widget.montoFac}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      width: MediaQuery.of(context).size.width*0.3,
                                      child: Column(
                                        children: [
                                          Text("Monto Total", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
                                          SizedBox(height: 5,),
                                          Text("\$ ${widget.total}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),)
                                        ],
                                      ),
                                    )




                                  ],
                                ),
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
                                    children: [
                                      Text("Descripción del Proyecto:", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),)
                                    ],
                                  ),

                                  Divider(height: 8,),

                                  Row(
                                    children: [
                                      Expanded(child: Text("${snapshot.data![index]['descripcion']}", style: TextStyle(height: 1.6, fontSize: 11),))
                                    ],
                                  ),



/*
                                  SizedBox(height: 25,),

                                  Row(
                                    children: [
                                      Text("HES:", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                                    ],
                                  ),
                                  Divider(height: 8,),
                                  Row(
                                    children: [
                                      Expanded(child: Text("${snapshot.data![index]['hes']}", style: TextStyle(height: 1.6, fontSize: 13),))
                                    ],
                                  ),


 */

                                  SizedBox(height: 25,),





                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          width:  MediaQuery.of(context).size.width*0.35,
                                          child: Text("Empresa Cuenta Bancaria:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                      Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context).size.width*0.50,
                                          child: Text("-", style: TextStyle(fontSize: 13,)))
                                    ],
                                  ),
                                  Divider(height: 16,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          width:  MediaQuery.of(context).size.width*0.35,
                                          child: Text("Movimiento Bancario:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                      Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context).size.width*0.50,
                                          child: Text("-", style: TextStyle(fontSize: 13,)))
                                    ],
                                  ),
                                  Divider(height: 16,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          width:  MediaQuery.of(context).size.width*0.35,
                                          child: Text("Voucher:  ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                      Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context).size.width*0.50,
                                          child: Text("-", style: TextStyle(fontSize: 13,)))
                                    ],
                                  ),
                                  Divider(height: 16,),


                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          width:  MediaQuery.of(context).size.width*0.35,
                                          child: Text("Flag Retención:   ", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                      Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery.of(context).size.width*0.50,
                                          child:  Text("-"))
                                    ],
                                  ),
                                  Divider(height: 16,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Fecha Pago Est.:    ", style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500),),
                                          Container(child: Text("-", style: TextStyle(fontSize: 12),),)
                                        ],
                                      ),
                                      //${snapshot.data![index]['Incidencia_Flag_Backlog']}

                                      Row(
                                        children: [
                                          Text("Fecha Pago Real:    ", style: TextStyle(fontSize: 11,fontWeight: FontWeight.w500),),
                                          Container(child: Text("-", style: TextStyle(fontSize: 12),),)
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

                          SizedBox(height: 25,),
                          Container(
                            decoration: BoxDecoration(        color: S2BColors.primaryColor,  borderRadius: BorderRadius.circular(10.0) ),



                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(

                                    children: [
                                      Icon(Icons.search , color: Colors.white, size: 16,),
                                      Text("  Observación", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),)
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
                                              child: Text('${obs}', style: TextStyle(fontSize: 12),),
                                            )
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
    int? idSaldoPry = widget.idSaldoProy;
    var url = 'https://app.eco2biz.com/intrasolution/ws/null/pr_ws_saldo_proyecto_detalle?proyecto_id=$idSaldoPry';

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
