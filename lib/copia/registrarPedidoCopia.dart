import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_grupo15/copia/carritoCompraCopia.dart';
import 'package:firebase_grupo15/main.dart';
import 'package:flutter/material.dart';

import '../pantalla3.dart';
import 'carritoCompraCopia.dart';

class registrarPedidoCopia extends StatefulWidget {
  final String id,cedula;
  const registrarPedidoCopia({required this.id, required this.cedula});

  @override
  _registrarPedidoCopiaState createState() => _registrarPedidoCopiaState();
}

class _registrarPedidoCopiaState extends State<registrarPedidoCopia> {
  List listaCursos=[];
  List codigosGustos=[];
  List<datosPedidoCopia> pedido=[];

  void initState(){
    super.initState();
    getCursos();
  }

  void getCursos() async {

    CollectionReference gustos = FirebaseFirestore.instance.collection("Gustos");
    String cod="";
    QuerySnapshot cursos= await gustos.where("persona", isEqualTo: widget.id).get();
    if(cursos.docs.length>0){
      for(var doc in cursos.docs){
        cod=doc.id.toString();
        codigosGustos.add(cod);
        listaCursos.add(doc.data());
      }
    }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    final String texto;
    return Scaffold(
        appBar: AppBar(
          title: Text("Regist Pedid Copia"),
          actions: [
            IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>carritoComprasCopia(pedido: pedido, cedula: widget.cedula, id: widget.id)));
                }, icon: Icon(Icons.add_shopping_cart, size: 30, color: Colors.amber))
          ],
        ),
        drawer: menu(),
        body:SafeArea(
          child: GridView.builder(
              itemCount: listaCursos.length,
              scrollDirection: Axis.vertical,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1/2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, int i)
              {
                return Card(

                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                    margin: EdgeInsets.all(5),
                    elevation: 10,
                    color: Colors.white,
                    //permite poner el contenido de la tarjeta

                    child: ClipRRect(

                      borderRadius: BorderRadius.circular(5),

                      child: Column(

                          children: [
                            Image.network(listaCursos[i]['foto']),

                            Container(

                                padding:  EdgeInsets.all(1),
                                color: Colors.white,
                                child: Text("\n"+listaCursos[i]['nombre']+"\n"+listaCursos[i]['descripcion'],style: TextStyle(fontSize: 20, color: Colors.black),textAlign: TextAlign.center)


                            ),


                          ]

                      ),

                    )


                );


               //return miCardImage(url: listaCursos[i]['foto'], texto: listaCursos[i]['nombre']+" "+listaCursos[i]['descripcion']+'\n'+listaCursos[i]['precio'].toString());
              })

    ));
  }
}

class datosPedidoCopia{

  String codigo="";
  String nombre="";
  String descripcion="";
  String precio="";
  int cant=0;
  int total=0;

  datosPedidoCopia(this.codigo, this.nombre, this.descripcion, this.precio, this.cant, this.total);
}
