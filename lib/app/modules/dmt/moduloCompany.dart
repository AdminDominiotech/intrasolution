import 'package:flutter/material.dart';
import 'package:safe2biz/app/global/core/styles/colors.dart';
import 'package:safe2biz/app/global/core/styles/typography.dart';
import 'package:safe2biz/app/modules/dmt/companyBodyIntra.dart';
import 'package:safe2biz/app/modules/dmt/modulos/Facturas/Facturas.dart';
import 'package:safe2biz/app/modules/dmt/modulos/Incidencias/Incidencias.dart';
import 'package:safe2biz/app/modules/dmt/modulos/Incidencias/MisIncidencias.dart';
import 'package:safe2biz/app/modules/dmt/modulos/Pases/Pases.dart';
import 'package:safe2biz/app/modules/dmt/modulos/SaldoProyecto/SaldoProyecto.dart';
import 'package:safe2biz/app/modules/dmt/modulos/Tareas/MisTareas.dart';
import 'package:safe2biz/app/modules/dmt/modulos/Tareas/Tareas.dart';
class ModulosSede extends StatefulWidget {

  final String? user_login, sc_id;

  const ModulosSede({Key? key, this.user_login, this.sc_id}) : super(key: key);

  @override
  State<ModulosSede> createState() => _ModulosSedeState();
}

class _ModulosSedeState extends State<ModulosSede> {

  bool flagAdm = false;

  @override

  void initState(){
    super.initState();


  }

  @override
  Widget build(BuildContext context) {



    print("user_loging ---> ${widget.user_login}");

    String usr = '${widget.user_login}';

    if(usr == 'manuel.perez' || usr == 'Manuel.perez' || usr == 'MANUEL.PEREZ' || usr == 'juan.arroyo' || usr == 'cesar.perez' || usr == 'alejandro.perez' || usr == 'joshua.rojas' || usr == 'admin' ){
      flagAdm = true;
    }

    return Scaffold(

      appBar: AppBar(
        title: Text("Dominiotech",
          style: TextStyle(fontSize: S2BTypography.h6, fontWeight: FontWeight.w500),),
        backgroundColor: Color(0xFFB60303),
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
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => CompanyBodyIntra(user_login: widget.user_login, user_id: widget.sc_id,)));
          } ,
        ) ,


      ),
      body: SingleChildScrollView(
        child: Column(
      children: [

        //Modulo 1
        SizedBox(height: 12,),

        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(

                width: MediaQuery.of(context).size.width*0.94,
                height: 90,
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MisTareas(sc_id: '${widget.sc_id}',)));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                        color: Color(0xffB60303),
                        width: 2//<-- SEE HERE
                      ),
                    ),
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),

                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color:  Color(0xffB60303),
                                    ),
                                    padding:  EdgeInsets.all(8.0),
                                    child: Image.asset('assets/icons/mis-tareas_2.png',  width: 40, color: Colors.white,)
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 14),
                                  child: Text("Mis Tareas", style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500,  ),),
                                ),
                              ],
                            ),

                            Container(
                              child: Icon(Icons.arrow_forward_ios_rounded),
                            )


                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),


        //Modulo Tareas


        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(

                width: MediaQuery.of(context).size.width*0.94,
                height: 90,
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Tareas()));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                          color: Color(0xffB60303),
                          width: 2//<-- SEE HERE
                      ),
                    ),
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color:  Color(0xffB60303),
                                    ),
                                    padding:  EdgeInsets.all(8.0),


                                    child: Image.asset('assets/icons/tareas.png',  width: 40,  color: Colors.white)
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 14),
                                  child: Text("Tareas", style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500,  ),),
                                ),
                              ],
                            ),
                            Container(
                              child: Icon(Icons.arrow_forward_ios_rounded),
                            )


                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),




        Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(

              width: MediaQuery.of(context).size.width*0.94,
              height: 90,
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MisIncidencias(user_login : '${widget.user_login}', sc_id: widget.sc_id,)));
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                        color: Color(0xffB60303),
                        width: 2//<-- SEE HERE
                    ),
                  ),
                  color: Colors.white,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color:  Color(0xffB60303),
                                  ),
                                  padding:  EdgeInsets.all(8.0),


                                child: Image.asset('assets/icons/mis-incidencias.png',  width: 40,  color: Colors.white)
                              ),

                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 14),
                                child: Text("Mis Incidencias", style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500,  ),),
                              ),


                            ],
                          ),

                          Container(
                            child: Icon(Icons.arrow_forward_ios_rounded),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),


        //Modulo 2



        Container(

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(

                width: MediaQuery.of(context).size.width*0.94,
                height: 90,
                child: InkWell(
                  onTap: (){

                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Incidencias(usr: widget.user_login, sc_id: widget.sc_id,)));
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Incidencias(usr: widget.user_login, sc_id: widget.sc_id,)));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                          color: Color(0xffB60303),
                          width: 2//<-- SEE HERE
                      ),
                    ),
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color:  Color(0xffB60303),
                                    ),
                                    padding:  EdgeInsets.all(8.0),
                                    child:    Image.asset('assets/icons/incidencia.png' , width: 40, color: Colors.white)
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 14),
                                  child: Text("Incidencias", style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500,  ),),
                                ),
                              ],
                            ),
                            Container(
                              child: Icon(Icons.arrow_forward_ios_rounded),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        //Modulo 3


        Container(

          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(

                width: MediaQuery.of(context).size.width*0.94,
                height: 90,
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Pases(usr_log: widget.user_login, sc_id: widget.sc_id,)));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                          color: Color(0xffB60303),
                          width: 2//<-- SEE HERE
                      ),
                    ),
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color:  Color(0xffB60303),
                                    ),
                                    padding:  EdgeInsets.all(8.0),

                                    child: Image.asset('assets/icons/pases.png',  width: 40,  color: Colors.white)
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 14),
                                  child: Text("Pases", style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500,  ),),
                                ),

                              ],
                            ),
                            Container(
                              child: Icon(Icons.arrow_forward_ios_rounded),
                            )

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),



        //Modulo 4

        Visibility(
          visible: flagAdm,
          child: Container(

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(

                  width: MediaQuery.of(context).size.width*0.94,
                  height: 90,
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Facturas(usr_log: widget.user_login, sc_id: widget.sc_id,)));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                            color: Color(0xffB60303),
                            width: 2//<-- SEE HERE
                        ),
                      ),
                      color: Colors.white,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [

                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color:  Color(0xffB60303),
                                      ),
                                      padding:  EdgeInsets.all(8.0),

                                      child: Image.asset('assets/icons/factura.png',  width: 40,  color: Colors.white)
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 14),
                                    child: Text("Facturas", style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500,  ),),
                                  ),
                                ],
                              ),
                              Container(
                                child: Icon(Icons.arrow_forward_ios_rounded),
                              )



                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),



        //Modulo 5


        Visibility(
          visible: flagAdm,
          child: Container(

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(

                  width: MediaQuery.of(context).size.width*0.94,
                  height: 90,
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SaldoProyecto(usr_log: widget.user_login, sc_id: widget.sc_id,)));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                            color: Color(0xffB60303),
                            width: 2//<-- SEE HERE
                        ),
                      ),
                      color: Colors.white,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color:  Color(0xffB60303),
                                      ),
                                      padding:  EdgeInsets.all(8.0),

                                      child: Image.asset('assets/icons/saldopry.png',  height: 50, width: 40, color: Colors.white,)
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 14),
                                    child: Text("Saldo Proyecto", style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500,  ),),
                                  ),

                                ],
                              ),
                              Container(
                                child: Icon(Icons.arrow_forward_ios_rounded),
                              )

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),





      ],
    ),
    ),
    );
  }
}
