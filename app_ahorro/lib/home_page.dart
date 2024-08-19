
import 'package:app_ahorro/Base%20De%20Datos/data_controller.dart';
//import 'package:app_ahorro/Base%20De%20Datos/ingreso.dart';
import 'package:app_ahorro/Base%20De%20Datos/moneda.dart';
import 'package:flutter/material.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
//import 'package:app_ahorro/Base De Datos/ingreso.dart';
//import 'package:app_ahorro/Base De Datos/categoria.dart';
//import 'package:app_ahorro/Base De Datos/usuario.dart';
import 'package:get/get.dart';



class HomePage extends StatelessWidget {
  
  const HomePage({super.key});
  
     Future<void> agregarUsuarios() async {
      final DataController dataController= Get.put(DataController());
  
      Usuario usuario1 = Usuario(
        id: 1, 
        userId: 'u321',
        nombre: 'Angel Carias',
        email: 'aacarias@unah.hn',
        contrasena: '20222001305',
      );
      Usuario usuario2 = Usuario(
        id: 2,
        userId: 'u331',
        nombre: 'Darlan Perdomo',
        email: 'darlan.perdomo@unah.hn',
        contrasena: '20222000729',
      );
  
        try {
      int result1 = await dataController.addUsuario(usuario1);
      int result2 = await dataController.addUsuario(usuario2);
      print('Usuarios agregados con éxito. IDs: $result1, $result2');
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
      body: Center(
        child: ElevatedButton(
          onPressed: agregarUsuarios,
          child: Text('Agregar usuario'),
        ),
      ),
    );
  }
}
