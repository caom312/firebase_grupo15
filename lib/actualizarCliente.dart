import 'package:firebase_grupo15/comprobarCliente.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class actualizarCliente extends StatefulWidget {
  final datosCliente cliente;
  const actualizarCliente({required this.cliente});

  @override
  _actualizarClienteState createState() => _actualizarClienteState();
}

class _actualizarClienteState extends State<actualizarCliente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Actualizar Datos: "+ widget.cliente.nombre),
      ),
      drawer : menu(),
    );
  }
}
