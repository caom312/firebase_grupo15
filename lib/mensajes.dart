import 'package:firebase_grupo15/recibiendoMensajes.dart';
import 'package:flutter/material.dart';

class mensajes extends StatefulWidget {
  const mensajes({Key? key}) : super(key: key);

  @override
  _mensajesState createState() => _mensajesState();
}

class _mensajesState extends State<mensajes> {

  void initState(){
    super.initState();
    final objeto = new recibiendoMensajes();
    objeto.notificaciones();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:AppBar(
      title: Text("Notificaciones"),
    ),
    );
  }
}
