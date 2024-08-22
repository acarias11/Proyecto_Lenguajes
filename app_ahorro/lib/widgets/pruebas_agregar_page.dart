
import 'package:app_ahorro/Base%20De%20Datos/cuenta.dart';
import 'package:app_ahorro/Base%20De%20Datos/data_controller.dart';
import 'package:app_ahorro/Base%20De%20Datos/moneda.dart';
import 'package:app_ahorro/Base%20De%20Datos/usuario.dart';
import 'package:flutter/material.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
import 'package:get/get.dart';



class PruebasAgregarPage extends StatefulWidget {
  
  const PruebasAgregarPage({super.key});

  @override
  State<PruebasAgregarPage> createState() => _PruebasAgregarPageState();
}

class _PruebasAgregarPageState extends State<PruebasAgregarPage> {
   List<Moneda> _monedas = [];
   

  @override
  void initState() {
    super.initState();
    _loadMoneda();
    
  }
   String uid1 ='u001';
   String uid2 ='u002';

   

  // Función para cargar usuarios desde la base de datos
  Future<void> _loadMoneda() async {
    try {
      final monedas = await DBHelper.queryMonedas(
      );
      setState(() {
        _monedas = monedas;
      });
    } catch (e) {
      print('Error al cargar usuarios: $e');
    }
  }
  Future<void> agregarUsuarios() async {
      final DataController dataController= Get.put(DataController());
  
       Usuario u1 = Usuario(
        userId: uid1,
        nombre: 'Angerl Andres Carias',
        email: 'cariasangerl60@gmail.com',
        contrasena: '20222001305'
      );
    
        Usuario u2 = Usuario(
        userId: uid2,
        nombre: 'Darlan Perdomo',
        email: 'darlangas@gmail.com',
        contrasena: 'Darlan'
      ); 
        try {
      int mon1 = await dataController.addUsuario(u1);
      int mon2 = await dataController.addUsuario(u2);
      print('Cuentas agregados con éxito. IDs: $mon1, $mon2');
         } catch (e) {
          print('Error al agregar la cuenta: $e');
             }
      }
        Future<void> agregarMonedas() async {
      final DataController dataController= Get.put(DataController());
  
       Moneda m1 = Moneda(
        nombre: 'Lempira',
        simbolo: 'L'
      );
    
        Moneda m2 = Moneda(
        nombre: 'Dolares',
        simbolo: '\$'
      );
      Moneda m3 = Moneda(
        nombre: 'Euros',
        simbolo: '€',
      );
        try {
      int mon1 = await dataController.addMoneda(m1);
      int mon2 = await dataController.addMoneda(m2);
      int mon3 = await dataController.addMoneda(m3);
      print('Cuentas agregados con éxito. IDs: $mon1, $mon2, $mon3');
         } catch (e) {
          print('Error al agregar la cuenta: $e');
             }
      }

     Future<void> agregarCuenta() async {
      final DataController dataController= Get.put(DataController());
  
       Cuenta c1 = Cuenta(
        userid: uid1,
        nombre: 'angel',
        tipo: 'Cuenta Corriente',
        moneda: 'Lempira',
      );
    
       Cuenta c2 = Cuenta(
        userid: uid2,
        nombre: 'darlangas',
        tipo: 'Cuenta Corriente',
        moneda: 'Dolares',
      );
      Cuenta c3 =Cuenta(
        nombre: 'Pablo Pruebas', 
        tipo: 'Ahorro', 
        moneda: 'Euros'
        );
      
        try {
      int mon1 = await dataController.addCuenta(c1);
      int mon2 = await dataController.addCuenta(c2);
      int mon3 = await dataController.addCuenta(c3);

      print('Cuentas agregados con éxito. IDs: $mon1, $mon2, $mon3');
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
            onPressed: agregarCuenta,
            child: const Text('Agregar Cuentas'),
          ),
          ElevatedButton(
            onPressed: agregarUsuarios,
            child:const  Text('Agregar Usuarios'),
          ),
           ElevatedButton(
            onPressed: agregarMonedas,
            child:const  Text('Agregar Monedas'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _monedas.length,
              itemBuilder: (context, index) {
                final monedas = _monedas[index];
                return ListTile(
                  title: Text(monedas.nombre),
                  subtitle: Text(monedas.simbolo),
            );
            },
            ),
          ),
        ],
      ),
    );
  }
}