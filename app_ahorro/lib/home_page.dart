import 'package:app_ahorro/Base%20De%20Datos/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
//import 'package:app_ahorro/Base De Datos/ingreso.dart';
//import 'package:app_ahorro/Base De Datos/categoria.dart';
import 'package:app_ahorro/Base De Datos/usuario.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Usuario> _usuarios = [];

  @override
  void initState() {
    super.initState();
    _loadUsuarios();
  }

  // Función para cargar usuarios desde la base de datos
  Future<void> _loadUsuarios() async {
    try {
      final usuarios = await DBHelper.queryUsuarios();
      setState(() {
        _usuarios = usuarios;
      });
    } catch (e) {
      print('Error al cargar usuarios: $e');
    }
  }

  Future<void> agregarUsuarios() async {
    final DataController dataController = Get.put(DataController());

    Usuario usuario1 = Usuario(
      id: 1,
      userId: 'u321',
      nombre: 'Angel Carias',
      email: 'aacarias@unah.hn',
      contrasena: '20222001305',
    );
    Usuario usuario3 = Usuario(
      userId: 'u1234',
      nombre: 'Jefferson',
      email: 'Jefferson.Castro@unah.hn',
      contrasena: 'Jefferson',
    );

    try {
      int result1 = await dataController.addUsuario(usuario1);
      int result2 = await dataController.addUsuario(usuario3);
      print('Usuarios agregados con éxito. IDs:  $result2');
    } catch (e) {
      print('Error al agregar la cuenta: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página de Inicio'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: agregarUsuarios,
            child: Text('Agregar usuarios'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _usuarios.length,
              itemBuilder: (context, index) {
                final usuario = _usuarios[index];
                return ListTile(
                  title: Text(usuario.nombre),
                  subtitle: Text(usuario.email),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
