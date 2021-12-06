import 'package:firebase_grupo15/comprobarCliente.dart';
import 'package:firebase_grupo15/copia/moduloPedidoCopia.dart';
import 'package:firebase_grupo15/mapas.dart';
import 'package:firebase_grupo15/mensajes.dart';
import 'package:firebase_grupo15/moduloPedido.dart';
import 'package:firebase_grupo15/pantalla2.dart';
import 'package:firebase_grupo15/registroClientes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(const MyApp());
  });

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List datos_personas=[];

  void initState(){
    super.initState();
    getPersonas();
  }
  void getPersonas() async {
    CollectionReference datos= FirebaseFirestore.instance.collection("Personas"); //Conecte a la colleccion
    QuerySnapshot personas= await datos.get(); //Traer todas las personas

    if(personas.docs.length>0){ //Trae datos
      print("Trae Datos");
      for(var doc in personas.docs){
        print(doc.data());
        setState(() {
          datos_personas.add(doc.data());
        });

      }
    } else{
      print("Ha fallado.......");
    }

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Listado de Personas"),
      ),
      drawer: menu(),
      body: Center(
        child: ListView.builder(
          itemCount: datos_personas.length,
          itemBuilder: (BuildContext context,i){
            return ListTile(
              title: Text("Persona "+i.toString()+" - "+datos_personas[i]['nombre'].toString()),
              onTap: (){
                print(datos_personas[i]['posicion']);
                datosMapa_Persona mp = datosMapa_Persona(datos_personas[i]['nombre'], datos_personas[i]['apellido'], datos_personas[i]['correo'],
                    datos_personas[i]['edad'], datos_personas[i]['foto'], datos_personas[i]['web'], datos_personas[i]['posicion']);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>mapas(persona: mp)));
              },
            );

          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> pantalla2()));
        }, label: Text("Siguiente"),
        icon: Icon(Icons.arrow_forward),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class menu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                    color: Colors.amberAccent
                ),
                child: Image.network('https://www.lifeder.com/wp-content/uploads/2018/06/mercado-negocios-empresas-630x420.jpg')
            ),
            Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.account_circle_outlined, size: 30, color: Colors.green),
                    title: Text("Consultar Personas"),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>pantalla2()));
                    },
                  ),
                  ListTile(
                    trailing: Icon(Icons.account_box,size: 30, color: Colors.green),
                    title: Text("Registrar Cliente"),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>registroClientes()));
                    },
                  ),
                  ListTile(
                    trailing: Icon(Icons.account_box,size: 30, color: Colors.green),
                    enabled: true,
                    title: Text("Actualizar Datos"),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>comprobarCliente()));
                    },
                  ),
                  ListTile(
                    trailing: Icon(Icons.account_box,size: 30, color: Colors.green),
                    enabled: true,
                    title: Text("Registrar Pedido"),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>moduloPedidoCopia()));
                    },
                  ),
                  ListTile(
                    trailing: Icon(Icons.account_box,size: 30, color: Colors.green),
                    enabled: true,
                    title: Text("Registrar Pedido Copia"),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>moduloPedido()));
                    },
                  ),
                  ListTile(
                    trailing: Icon(Icons.email,size: 30, color: Colors.green),
                    enabled: true,
                    title: Text("Notificaciones"),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>mensajes()));
                    },
                  ),
                ]
            )
          ],
        )
    );
  }
}

class datosMapa_Persona{
  String nombre="";
  String apellido="";
  String correo="";
  int edad=0;
  String foto="";
  String web="";
  late GeoPoint posicion;

  datosMapa_Persona(this.nombre, this.apellido, this.correo, this.edad, this.foto, this.web, this.posicion);
}
