import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_grupo15/main.dart';
import 'package:firebase_grupo15/pantalla3.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class mapas extends StatefulWidget {

  final datosMapa_Persona persona;
  const mapas({required this.persona});

  @override
  _mapasState createState() => _mapasState();
}

class _mapasState extends State<mapas> {

  late GeoPoint pos = widget.persona.posicion;

  @override
  Widget build(BuildContext context) {

    final posicion = CameraPosition(
        target: LatLng(pos.latitude, pos.longitude),
        zoom: 15
    );

    final Set<Marker> marcador = Set();
    String cedula="123456";

    marcador.add(
        Marker(
            markerId: MarkerId(cedula),
            position: LatLng(pos.latitude, pos.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            infoWindow: InfoWindow(
                title: widget.persona.nombre+" "+widget.persona.apellido,
                snippet: widget.persona.correo
            )


        )
    );
    return Scaffold(
        appBar: AppBar(
          title: Text("Geolocalización"),
        ),
        body: ListView(
          children: [
            miCardImage(url: widget.persona.foto, texto: widget.persona.nombre+" "+widget.persona.apellido),
            Container(
              width: 400,
              height: 600,
              child: GoogleMap(
                initialCameraPosition: posicion,
                scrollGesturesEnabled: true, //activar - desactivar mover el mapa
                zoomGesturesEnabled: false, //activar - desactivar zoom con la mano
                zoomControlsEnabled: true, // descativar botones zoom
                mapType: MapType.normal,
                markers: marcador,
              ),
            )
          ],
        )


    );
  }
}
