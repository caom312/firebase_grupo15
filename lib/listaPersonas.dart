import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_grupo15/pantalla3.dart';
import 'package:firebase_grupo15/registrarPedido.dart';
import 'package:firebase_grupo15/registrarPedido.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'main.dart';

class listaPersonas extends StatefulWidget {
  final String cedula;
  const listaPersonas({required this.cedula});

  @override
  _listaPersonasState createState() => _listaPersonasState();
}

class _listaPersonasState extends State<listaPersonas> {

  List personas=[];
  List codigos=[];

  void initState(){
    super.initState();
    getPersonas();
  }

  void getPersonas() async {
    CollectionReference persona = FirebaseFirestore.instance.collection("Personas");
    String id="";
    QuerySnapshot datos = await persona.get();
    if(datos.docs.length>0){
      for(var doc in datos.docs){
        id=doc.id.toString();
        codigos.add(id);
        personas.add(doc.data());

      }
    }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profesores"),
      ),
      drawer: menu(),
      body: ListView.builder(
          itemCount: personas.length,
          itemBuilder: (BuildContext context,i){
            return ListTile(

                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>registrarPedido(id: codigos[i], cedula: widget.cedula)));
                },
                title: miCardImage(url: personas[i]['foto'],texto: personas[i]['nombre']+" "+personas[i]['apellido']+'\n'+personas[i]['correo'])

            );
          }),
    );
  }
}
