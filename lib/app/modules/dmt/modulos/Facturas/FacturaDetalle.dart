import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:safe2biz/app/global/core/styles/colors.dart';
import 'package:safe2biz/app/modules/dmt/Database/host.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:open_filex/open_filex.dart';

class FacturaDetalle extends StatefulWidget {

  final int? idFac;
  FacturaDetalle({Key? key, this.idFac}) : super(key: key);

  @override
  State<FacturaDetalle> createState() => _FacturaDetalleState();
}

List<dynamic>? ListHES = [];
List<dynamic>? ListFAC = [];

class _FacturaDetalleState extends State<FacturaDetalle> {

  //Colores estado
  Color? colorEstado;

  //Iconos
  Icon? iconFlagRetencion = Icon(
      Icons.check_box_outline_blank, color: Color(0xffB60303));

  @override
  void initState() {
    super.initState();
    asyncMethod();
    /*
    Future.delayed(const Duration(milliseconds: 1500), () {

      asyncMethod();

    });


     */
  }


  void asyncMethod() async {
    Map<String,dynamic> lista_hes = await RequestFacturaHES();
    Map<String,dynamic> lista_fac = await RequestFacturaFAC();


    ListHES =  lista_hes.values.toList();
    ListFAC = lista_fac.values.toList();
  }





  NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

  @override
  Widget build(BuildContext context) {
    RequestFacturaDetalle();

    _createPdf(String base64_url, String nombre) async {
      var base64 = '$base64_url';
      var bytes = base64Decode(base64);
      final output = await getTemporaryDirectory();
      final file = File("${output.path}/${nombre}.pdf");
      await file.writeAsBytes(bytes.buffer.asUint8List());
      debugPrint("${output.path}/${nombre}.pdf");
      await OpenFilex.open("${output.path}/${nombre}.pdf");
    }



    return Scaffold(
        appBar: AppBar(
          title: Text("Factura Detalle"),
          backgroundColor: S2BColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          elevation: 0,
          leading: GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [
                Container(
                    width: 40,
                    child: Icon(Icons.arrow_back_ios)),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),


        ),
        body: FutureBuilder(
            future: RequestFacturaDetalle(),

            builder: (BuildContext ctx, AsyncSnapshot<List> snapshot) =>

            snapshot.hasData ? ListView.builder(

                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, index) {
                  String? montoParse;
                  String? montoImp;
                  String? montoTot;

                  double? monto;
                  double? imp;
                  double? montotal;
                  bool soles = true;

                  if(snapshot.data![index]['monto_soles'] == null){
                    monto = snapshot.data![index]['monto_dolares'];
                    montoParse = myFormat.format(monto);
                    soles = false;
                  }else{
                    monto = snapshot.data![index]['monto_soles'];
                    montoParse = myFormat.format(monto);
                  }

                  if(snapshot.data![index]['monto_impuesto_soles'] == null){
                    imp = snapshot.data![index]['monto_impuesto_dolares'];
                    montoImp = myFormat.format(imp);
                  }else{
                    imp = snapshot.data![index]['monto_impuesto_soles'];
                    montoImp = myFormat.format(imp);
                  }

                  print("monto total soles --- ${snapshot.data![index]['monto_total_soles']}");

                  if(snapshot.data![index]['monto_total_soles'] == null || snapshot.data![index]['monto_total_soles'] == 0.0){
                    montotal = snapshot.data![index]['monto_total_venta_dolares'];
                    montoTot = myFormat.format(montotal);
                  }else{
                    montotal = snapshot.data![index]['monto_total_soles'];
                    montoTot = myFormat.format(montotal);
                  }

                  String? img;
                  double hg = 35;
                  int wd = 150;
                  String cli = snapshot.data![index]['nombre_cliente'];
                  if (cli == 'DOMINIOTECH SAC') {
                    img = 'assets/logo/cliente-dmt.png';
                  } else if (cli == 'Buenaventura ') {
                    img = 'assets/logo/cliente-bnv.png';
                  }
                  else if (cli == 'Compañia Minera Antapaccay') {
                    img = 'assets/logo/cliente-anta.png';
                    hg = 50;
                  }
                  else if (cli == 'Engie S.A.C') {
                    img = 'assets/logo/cliente-engie.png';
                  } else if (cli == 'Petroperu SAC') {
                    img = 'assets/logo/cliente-ptp.png';
                  } else if (cli == 'Compañia Minera Lincuna SAC') {
                    img = 'assets/logo/cliente-linc.png';
                    hg = 50;
                  }


                  String? obs = snapshot.data![index]['observacion'];
                  String? fecha_programada = snapshot
                      .data![index]['fecha_ejecucion_programada'];
                  String? estado_venta = snapshot.data![index]['estado_venta'];
                  String? fecha_pago_estimado = snapshot
                      .data![index]['fecha_pago_estimado'];
                  String? fecha_pago_real = snapshot
                      .data![index]['fecha_pago_real'];

                  //flag
                  int? flag_retencion = snapshot.data![index]['flag_retencion'];


                  //Archivos

                  String? emp_cuenta_bancaria = snapshot
                      .data![index]['emp_cuenta_bancaria'];
                  String? mov_bancario = snapshot.data![index]['mov_bancario'];
                  String? voucher = snapshot.data![index]['voucher'];
                  //      String emp_cuenta_bancaria = snapshot.data![index]['emp_cuenta_bancaria'];

                  if (mov_bancario == null) {
                    mov_bancario = '-';
                  }
                  if (voucher == null) {
                    voucher = '-';
                  }

                  print("archivo HES ---> ${snapshot
                      .data![index]['archivo_hes']}");

                  if (flag_retencion == 1) {
                    iconFlagRetencion =
                        Icon(Icons.check_box_rounded, color: Color(0xffB60303));
                  }

                  //fecha
                  if (fecha_pago_estimado == '' ||
                      fecha_pago_estimado == null) {
                    fecha_pago_estimado = '-';
                  }
                  if (fecha_pago_real == '' || fecha_pago_real == null) {
                    fecha_pago_real = '-';
                  }

                  //---

                  if (obs == '' || obs == null) {
                    obs = 'No hay Observaciones';
                  }

                  if (estado_venta == 'Por Pagar') {
                    colorEstado = Color(0xffFF8000);
                  }

                  if (emp_cuenta_bancaria == '' ||
                      emp_cuenta_bancaria == null) {
                    emp_cuenta_bancaria = '-';
                  } else if (mov_bancario == '' || mov_bancario == null) {
                    mov_bancario = '-';
                  } else if (voucher == '' || voucher == null) {
                    voucher = '-';
                  }


                  if (obs == null || obs == '') {
                    obs = '-';
                  }
                  if (fecha_programada == null || fecha_programada == '') {
                    fecha_programada = '-';
                  }


                  return Container(

                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 1,

                    // render list item
                    child: ListTile(
                      onTap: () {

                      },

                      title: Column(
                        children: [

                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.receipt_long_rounded,
                                    color: Colors.black, size: 18,),
                                  SizedBox(width: 5,),
                                  Text(" ${snapshot
                                      .data![index]['numero_factura']} ",
                                    style: TextStyle(fontSize: 16,
                                        fontWeight: FontWeight.bold),),
                                ],
                              ),
                              Text("${snapshot.data![index]['fecha_factura']
                                  .substring(0, 10)}", style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),),
                            ],
                          ),


                          Divider(height: 25,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.55,
                                child: Row(
                                  children: [


                                    Image.asset('$img', height: hg,)
                                    //   FittedBox(child: Text(" ${snapshot.data![index]['nombre_cliente']}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),))
                                  ],
                                ),
                              ),


                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.35,
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
                                        onPressed: () {


                                        },
                                        child: FittedBox(child: Text("${snapshot
                                            .data![index]['estado_venta']}",
                                          style: TextStyle(fontSize: 11,
                                              fontWeight: FontWeight.bold),)),
                                      ),
                                    )

                                  ],
                                ),
                              ),
                            ],
                          ),

                          Divider(height: 25,),

                          Container(
                            decoration: BoxDecoration(color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [


                                      Container(
                                        width: MediaQuery.of(context).size.width*0.15,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text("Proyecto: ",
                                                style: TextStyle(fontSize: 11,
                                                    fontWeight: FontWeight.w500),),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Container(
                                        width: MediaQuery.of(context).size.width*0.7,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text("${snapshot
                                                  .data![index]['proyecto_nombre']}",
                                                style: TextStyle(fontSize: 11,
                                                    fontWeight: FontWeight.w500),),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),


                            ),

                          ),
                          SizedBox(height: 5,),


                          //======SOLES
                          Visibility(
                            visible: soles,
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 1,
                              decoration: BoxDecoration(color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.5,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text("Monto:  ", style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight
                                                        .w400),),
                                                Text("     S/. ${montoParse}",
                                                  style: TextStyle(fontSize: 14,
                                                      fontWeight: FontWeight
                                                          .w500),)
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              children: [
                                                Text("Impuesto:   ",
                                                  style: TextStyle(fontSize: 12,
                                                      fontWeight: FontWeight
                                                          .w400),),
                                                Text("S/. ${montoImp}",
                                                  style: TextStyle(fontSize: 14,
                                                      fontWeight: FontWeight
                                                          .w500),)
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),

                                      Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.3,
                                        child: Column(
                                          children: [
                                            Text("Monto Total", style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),),
                                            SizedBox(height: 5,),
                                            Text("S/. ${montoTot}",
                                              style: TextStyle(fontSize: 16,
                                                  fontWeight: FontWeight.w500),)
                                          ],
                                        ),
                                      )


                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),


                          //========DOLAR
                          Visibility(
                            visible: !soles,
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 1,
                              decoration: BoxDecoration(color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.5,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text("Monto:  ", style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight
                                                        .w400),),
                                                Text("     \$ ${montoParse}",
                                                  style: TextStyle(fontSize: 14,
                                                      fontWeight: FontWeight
                                                          .w500),)
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Row(
                                              children: [
                                                Text("Impuesto:   ",
                                                  style: TextStyle(fontSize: 12,
                                                      fontWeight: FontWeight
                                                          .w400),),
                                                Text("\$ ${montoImp}",
                                                  style: TextStyle(fontSize: 14,
                                                      fontWeight: FontWeight
                                                          .w500),)
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),

                                      Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.3,
                                        child: Column(
                                          children: [
                                            Text("Monto Total", style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),),
                                            SizedBox(height: 5,),
                                            Text("\$ ${montoTot}",
                                              style: TextStyle(fontSize: 16,
                                                  fontWeight: FontWeight.w500),)
                                          ],
                                        ),
                                      )


                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),






                          Divider(height: 25,),

                          Container(
                            decoration: BoxDecoration(color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0)),

                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text("Código del Proyecto: ",
                                        style: TextStyle(fontSize: 14,
                                            fontWeight: FontWeight.w500),),


                                    ],
                                  ),
                                  Divider(height: 8,),

                                  Row(
                                    children: [
                                      Expanded(child: Text("${snapshot
                                          .data![index]['proyecto_codigo']}",
                                        style: TextStyle(
                                            height: 1.6, fontSize: 13),))
                                    ],
                                  ),

                                  SizedBox(height: 25,),

                                  Row(
                                    children: [
                                      Text("Descripción del Proyecto:",
                                        style: TextStyle(fontSize: 14,
                                            fontWeight: FontWeight.w500),)
                                    ],
                                  ),

                                  Divider(height: 8,),

                                  Row(
                                    children: [
                                      Expanded(child: Text("${snapshot
                                          .data![index]['proyecto_descripcion']}",
                                        style: TextStyle(
                                            height: 1.6, fontSize: 12),))
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
                                    children: [
                                      Icon(Icons.picture_as_pdf, size: 16,
                                        color: S2BColors.primaryColor,),
                                      SizedBox(width: 5,),
                                      Text("Archivo HES:", style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),),
                                    ],
                                  ),
                                  Divider(height: 8,),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                            onTap: () async {
                                             await _createPdf(ListHES?[0], '${ListHES?[1]}');
                                            },
                                            child: Text("${snapshot
                                                .data![index]['archivo_hes']}",
                                              style: TextStyle(height: 1.6,
                                                  fontSize: 13,
                                                  color: S2BColors.blue),)),
                                      )
                                    ],
                                  ),

                                  Divider(height: 25,),

                                  Row(
                                    children: [
                                      Icon(Icons.picture_as_pdf, size: 16,
                                        color: S2BColors.primaryColor,),
                                      SizedBox(width: 5,),
                                      Text("Archivo FAC:", style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),),
                                    ],
                                  ),
                                  Divider(height: 8,),
                                  Row(
                                    children: [
                                      Expanded(child: InkWell(
                                        onTap: () async {
                                          await _createPdf(ListFAC?[0], '${ListFAC?[1]}');
                                        },
                                        child: Text(
                                          "${snapshot.data![index]['archivo']}",
                                          style: TextStyle(height: 1.6,
                                              fontSize: 13,
                                              color: S2BColors.blue),),
                                      ))
                                    ],
                                  ),


                                  SizedBox(height: 25,),


                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Container(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.35,
                                          child: Text(
                                            "Empresa Cuenta Bancaria:  ",
                                            style: TextStyle(fontSize: 14,
                                                fontWeight: FontWeight.bold),)),
                                      Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.50,
                                          child: Text("${emp_cuenta_bancaria}",
                                              style: TextStyle(fontSize: 13,)))
                                    ],
                                  ),
                                  Divider(height: 16,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Container(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.35,
                                          child: Text("Movimiento Bancario:  ",
                                            style: TextStyle(fontSize: 14,
                                                fontWeight: FontWeight.bold),)),
                                      Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.50,
                                          child: Text("${mov_bancario}",
                                              style: TextStyle(fontSize: 13,)))
                                    ],
                                  ),
                                  Divider(height: 16,),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Container(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.35,
                                          child: Text("Voucher:  ",
                                            style: TextStyle(fontSize: 14,
                                                fontWeight: FontWeight.bold),)),
                                      Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.50,
                                          child: Text("${voucher}",
                                              style: TextStyle(fontSize: 13,)))
                                    ],
                                  ),
                                  Divider(height: 16,),


                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Container(
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.35,
                                          child: Text("Flag Retención:   ",
                                            style: TextStyle(fontSize: 14,
                                                fontWeight: FontWeight.bold),)),
                                      Container(
                                          alignment: Alignment.center,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width * 0.50,
                                          child: iconFlagRetencion)
                                    ],
                                  ),
                                  Divider(height: 16,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Fecha Pago Est.:    ",
                                            style: TextStyle(fontSize: 11,
                                                fontWeight: FontWeight.w500),),
                                          Container(child: Text(
                                            "${fecha_pago_estimado.substring(
                                                0, 10)}",
                                            style: TextStyle(fontSize: 12),),)
                                        ],
                                      ),
                                      //${snapshot.data![index]['Incidencia_Flag_Backlog']}

                                      Row(
                                        children: [
                                          Text("Fecha Pago Real:    ",
                                            style: TextStyle(fontSize: 11,
                                                fontWeight: FontWeight.w500),),
                                          Container(child: Text(
                                            "${fecha_pago_real}",
                                            style: TextStyle(fontSize: 12),),)
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
                            decoration: BoxDecoration(color: S2BColors
                                .primaryColor, borderRadius: BorderRadius
                                .circular(10.0)),


                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(

                                    children: [
                                      Icon(Icons.search, color: Colors.white,
                                        size: 16,),
                                      Text("  Observación", style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),)
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
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Container(
                                              child: Text('${obs}',
                                                style: TextStyle(
                                                    fontSize: 12),),
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
  Future <List<dynamic>> RequestFacturaDetalle() async {
    int? idFac = widget.idFac;
    var url = 'https://app.eco2biz.com/intrasolution/ws/null/pr_ws_fnz_venta_detalle?venta_id=$idFac';

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
    List results = [];
    //results = data.map((e) => EmpleadoIncGen_model.fromJson(e)).toList();

    print("data_base ---> ${data_base}");
    print("data ----> ${data}]");
    return data;
  }


  Future <Map<String, dynamic>> RequestFacturaHES() async {
    int? idFac = widget.idFac;
    var url = 'https://app.eco2biz.com/intrasolution/ws/obtieneHESFnz?id=$idFac';

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
    var data = jsonDecode(response.body);
    List results = [];
    //results = data.map((e) => EmpleadoIncGen_model.fromJson(e)).toList();

    print("data_base ---> ${data_base}");
    print("data HES ----> ${data}");
    return data;
  }


  Future <Map<String, dynamic>> RequestFacturaFAC() async {
    int? idFac = widget.idFac;
    var url = 'https://app.eco2biz.com/intrasolution/ws/obtieneFACFnz?id=$idFac';

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
    var data = jsonDecode(response.body);
    List results = [];
    //results = data.map((e) => EmpleadoIncGen_model.fromJson(e)).toList();

    print("data_base ---> ${data_base}");
    print("data FAC ----> ${data}");
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
