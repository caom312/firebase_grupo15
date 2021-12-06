import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_grupo15/copia/listaPersonasCopia.dart';
import 'package:firebase_grupo15/listaPersonas.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';


class moduloPedidoCopia extends StatefulWidget {
  const moduloPedidoCopia({Key? key}) : super(key: key);

  @override
  _moduloPedidoCopiaState createState() => _moduloPedidoCopiaState();
}

class _moduloPedidoCopiaState extends State<moduloPedidoCopia> {
  final cedula = TextEditingController();
  final correo = TextEditingController();
  CollectionReference cliente =
  FirebaseFirestore.instance.collection("Clientes");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Comprobar Clien Copia"),
        ),
        drawer: menu(),
        body: ListView(children: [
          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: cedula,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    fillColor: Colors.lightBlue,
                    filled: true,
                    icon: Icon(Icons.assignment_rounded,
                        size: 25, color: Colors.blue),
                    hintText: "Digite numero de cedula",
                    hintStyle: TextStyle(color: Colors.black12)),
              )),
          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: correo,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    fillColor: Colors.lightBlue,
                    filled: true,
                    icon: Icon(Icons.assignment_rounded,
                        size: 25, color: Colors.blue),
                    hintText: "Digite su correo",
                    hintStyle: TextStyle(color: Colors.black12)),
              )),
          Container(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () async {
                QuerySnapshot ingreso = await cliente
                    .where(FieldPath.documentId, isEqualTo: cedula.text)
                    .where("correo", isEqualTo: correo.text)
                    .get();
                List listaCliente = [];
                if (ingreso.docs.length > 0) {
                  for (var cli in ingreso.docs) {
                    listaCliente.add(cli.data());
                  }

                  Navigator.push(context, MaterialPageRoute (builder: (context) =>listaPersonasCopia(cedula: cedula.text)));
                  Fluttertoast.showToast(msg: "Cargando Datos",
                      fontSize: 20,
                      backgroundColor: Colors.red,
                      textColor: Colors.lightGreen,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER);
                } else {
                  Fluttertoast.showToast(msg: "Datos Incorrectos",
                      fontSize: 20,
                      backgroundColor: Colors.red,
                      textColor: Colors.lightGreen,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER);
                }
              },
              child: Text("Verificar",
                  style: TextStyle(color: Colors.white, fontSize: 25)),
            ),
          )
        ]));
  }
}


