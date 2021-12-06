import 'package:firebase_grupo15/pantalla3.dart';
import 'package:firebase_grupo15/registroClientes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main.dart';

class pantalla4 extends StatelessWidget {

  final datospersona persona;
  const pantalla4({required this.persona});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("Datos Detallados:"+persona.nombre),
      ),
      drawer : menu(),
      body: ListView(
        children: [
          miCardImage(url: persona.foto, texto: persona.nombre+" "+persona.apellido),
          ElevatedButton(
              onPressed: (){
                launch(persona.web.toString());
              },
              child: Text("Mi pagina web"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>registroClientes()));
        },
        child: Icon(Icons.add,size: 30,color: Colors.white),
      ),
    );
  }
}
