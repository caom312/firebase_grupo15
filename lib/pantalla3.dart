import 'package:firebase_grupo15/pantalla4.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'main.dart';


class pantalla3 extends StatefulWidget {
  final String criterio;
  const pantalla3(this.criterio,{Key? key}) : super(key: key);
  @override
  _pantalla3State createState() => _pantalla3State();
}
class _pantalla3State extends State<pantalla3> {
  List gustosLista =[];
  List personasLista=[];
  void initState(){
    super.initState();
    getCriterio();
  }
  void getCriterio()async{
    CollectionReference datos = FirebaseFirestore.instance.collection("Gustos");
    QuerySnapshot gustos = await datos.where("nombre",isEqualTo:widget.criterio).get();
    if(gustos.docs.length!=0){
      for(var per in gustos.docs){
        print(per.data());
        setState(() {
          gustosLista.add(per);
        });
      }
    }
    String id;
    CollectionReference datos2 = FirebaseFirestore.instance.collection("Personas");
    for(var i=0;i<gustosLista.length;i++){
      id=gustosLista[i]['persona'];
      QuerySnapshot persona = await datos2.where(FieldPath.documentId, isEqualTo: id).get();
      if(persona.docs.length>0){
        for(var pers in persona.docs){
          setState(() {
            personasLista.add(pers.data());
            print(pers.data());
          });

        }
      }else{ print('No encontro personas para ese gusto');}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi Gusto "+widget.criterio),
      ),
      drawer : menu(),
      body: ListView.builder(
          itemCount: personasLista.length,
          itemBuilder: (BuildContext context,j){
            return ListTile(
               onTap:(){
                 print(personasLista[j]);
                 datospersona p = datospersona(personasLista[j]['nombre'],personasLista[j]['apellido'],
                     personasLista[j]['edad'],personasLista[j]['correo'],personasLista[j]['foto'],
                     personasLista[j]['web']);
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>pantalla4(persona: p)));
               },
                title: miCardImage(url: personasLista[j]['foto'],texto: personasLista[j]['nombre']+" "+personasLista[j]['apellido']+'\n'+personasLista[j]['correo'])
            );
          }),
    );
  }
}

//crear widget de tarjetas, que va a manejar informacion de la consulta
class miCardImage extends StatelessWidget {
  final String url;
  final String texto;

  const miCardImage({required this.url, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        margin: EdgeInsets.all(20),
        elevation: 10,
        color: Colors.blueAccent,
        //permite poner el contenido de la tarjeta
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Column(
              children: [
                Image.network(url),
                Container(
                    padding:  EdgeInsets.all(10),
                    color: Colors.blueAccent,
                    child: Text(texto,style: TextStyle(fontSize: 20, color: Colors.white),textAlign: TextAlign.center)

                )
              ]
          ),
        )
    );
  }
}

class datospersona{

  String nombre="";
  String apellido="";
  int edad=0;
  String correo="";
  String foto="";
  String web="";

  datospersona(this.nombre, this.apellido, this.edad, this.correo, this.foto, this.web);
}
