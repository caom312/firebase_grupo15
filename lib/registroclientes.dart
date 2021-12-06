import 'package:firebase_grupo15/comprobarCliente.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'main.dart';



class registroClientes extends StatefulWidget {
  const registroClientes({Key? key}) : super(key: key);

  @override
  _registroClientesState createState() => _registroClientesState();
}

class _registroClientesState extends State<registroClientes> {
  final cedula=TextEditingController();
  final nombre=TextEditingController();
  final apellido=TextEditingController();
  final correo=TextEditingController();
  final celular=TextEditingController();

  void limpiar(){
    cedula.text=""; nombre.text=""; apellido.text=""; correo.text=""; celular.text="";
  }

  CollectionReference clientes =FirebaseFirestore.instance.collection('Clientes');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resgistro de Clientes"),
      ),
      drawer : menu(),
      body: ListView(
        children: [
          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: cedula,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    fillColor: Colors.lightBlue,
                    filled: true,
                    icon: Icon(Icons.assignment_rounded,size: 25,color: Colors.blue),
                    hintText: "Digite numero de cedula",
                    hintStyle: TextStyle(color: Colors.black12)
                ),
              )
          ),
          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: nombre,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    fillColor: Colors.lightBlue,
                    filled: true,
                    icon: Icon(Icons.assignment_rounded,size: 25,color: Colors.blue),
                    hintText: "Digite el nombre",
                    hintStyle: TextStyle(color: Colors.black12)
                ),
              )
          ),
          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: apellido,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    fillColor: Colors.lightBlue,
                    filled: true,
                    icon: Icon(Icons.assignment_rounded,size: 25,color: Colors.blue),
                    hintText: "Digite los apellidos",
                    hintStyle: TextStyle(color: Colors.black12)
                ),
              )
          ),
          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: correo,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    fillColor: Colors.lightBlue,
                    filled: true,
                    icon: Icon(Icons.assignment_rounded,size: 25,color: Colors.blue),
                    hintText: "Digite su correo",
                    hintStyle: TextStyle(color: Colors.black12)
                ),
              )
          ),
          Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: celular,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    fillColor: Colors.lightBlue,
                    filled: true,
                    icon: Icon(Icons.assignment_rounded,size: 25,color: Colors.blue),
                    hintText: "Digite numero de celular",
                    hintStyle: TextStyle(color: Colors.black12)
                ),
              )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    if(cedula.text.isEmpty || nombre.text.isEmpty || apellido.text.isEmpty || correo.text.isEmpty || celular.text.isEmpty){
                      print("Campos Vacios");
                      Fluttertoast.showToast(msg: "Campos Vacios", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                    }else{
                      QuerySnapshot existe = await clientes.where(FieldPath.documentId, isEqualTo: cedula.text).get();

                      if(existe.docs.length>0){
                        Fluttertoast.showToast(msg: "El cliente ya Existe.", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                        limpiar();
                      }else{
                        clientes.doc(cedula.text).set({
                          "nombre": nombre.text,
                          "apellidos": apellido.text,
                          "correo": correo.text,
                          "celular": celular.text
                        });
                        QuerySnapshot inserto = await clientes.where(FieldPath.documentId, isEqualTo: cedula.text).get();
                        limpiar();
                        if(inserto.docs.length>0){
                          Fluttertoast.showToast(msg: "Se Registo el Cliente Exitosamente.", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                        }else{
                          Fluttertoast.showToast(msg: "No se registro el Cliente.", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
                        }

                      }

                    }
                    setState(() {

                    });
                  },
                  child: Text("Registrar",style: TextStyle(color: Colors.white, fontSize: 25)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    if(cedula.text.isEmpty){
                      Fluttertoast.showToast(msg: "Digite la cedula.", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                          toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                    }else{
                      List lista=[];
                      var id;
                      var ced=cedula.text;
                      QuerySnapshot consulta = await clientes.where(FieldPath.documentId, isEqualTo: cedula.text).get();
                      if(consulta.docs.length>0){
                        for(var doc in consulta.docs){
                          //id= FieldPath.documentId;
                          lista.add(doc.data());
                        }
                        Fluttertoast.showToast(msg: "Cargando Datos.", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                            toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                        cedula.text=ced;
                        nombre.text=lista[0]['nombre'];
                        apellido.text= lista[0]['apellidos'];
                        correo.text= lista[0]['correo'];
                        celular.text= lista[0]['celular'];
                      }
                      else{
                        limpiar();
                        Fluttertoast.showToast(msg: "El Cliente no se encontro.", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                            toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                      }
                    }
                  },
                  child: Text("Consultar",style: TextStyle(color: Colors.white, fontSize: 25)),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: (){
                    if(cedula.text.isEmpty || nombre.text.isEmpty || apellido.text.isEmpty || correo.text.isEmpty || celular.text.isEmpty){
                      Fluttertoast.showToast(msg: "Campos Vacios.", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                          toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                    }else{
                      clientes.doc(cedula.text).update({
                        "nombre": nombre.text,
                        "apellidos": apellido.text,
                        "correo": correo.text,
                        "celular": celular.text
                      });
                      limpiar();
                      Fluttertoast.showToast(msg: "Datos Actualizados Correctamente.", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                          toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                    }
                  },
                  child: Text("Actualizar",style: TextStyle(color: Colors.white, fontSize: 25)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: (){
                    if(cedula.text.isEmpty){
                      Fluttertoast.showToast(msg: "Campos Vacios.", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                          toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                    }else
                    {
                      clientes.doc(cedula.text).delete();
                      limpiar();
                      Fluttertoast.showToast(msg: "Cliente Eliminado Exitosamente.", fontSize: 20, backgroundColor: Colors.red, textColor: Colors.lightGreen,
                          toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                    }
                  },
                  child: Text("Eliminar",style: TextStyle(color: Colors.white, fontSize: 25)),
                ),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>comprobarCliente()));
        },
        child: Icon(Icons.arrow_forward_sharp,size: 30,color: Colors.white),
      ),
    );
  }
}
