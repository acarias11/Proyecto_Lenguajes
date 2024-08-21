
import 'package:app_ahorro/Base%20De%20Datos/cuenta.dart';
import 'package:app_ahorro/Base%20De%20Datos/data_controller.dart';
//import 'package:app_ahorro/Base%20De%20Datos/ingreso.dart';
import 'package:app_ahorro/Base%20De%20Datos/moneda.dart';
import 'package:app_ahorro/Base%20De%20Datos/usuario.dart';
import 'package:flutter/material.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
//import 'package:app_ahorro/Base De Datos/ingreso.dart';
//import 'package:app_ahorro/Base De Datos/categoria.dart';
//import 'package:app_ahorro/Base De Datos/usuario.dart';
import 'package:get/get.dart';



class AhorroPage extends StatefulWidget {
  
  const AhorroPage({super.key});

  @override
  State<AhorroPage> createState() => _AhorroPageState();
}

class _AhorroPageState extends State<AhorroPage> {
  List<Usuario> _usuario =[];
   List<Moneda> _monedas = [];

  @override
  void initState() {
    super.initState();
    _loadMoneda();
  }

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
     Future<void> agregarCuenta() async {
      final DataController dataController= Get.put(DataController());
  
       Cuenta c1 = Cuenta(
        userid: 'u111',
        nombre: 'aacc',
        tipo: 'Cuenta Corriente',
        moneda: 'Lempira',
      );
    
       Cuenta c2 = Cuenta(
        userid: 'u111',
        nombre: 'darlangas',
        tipo: 'Cuenta Corriente',
        moneda: 'Dolares',
      );
      Cuenta c3 = Cuenta(
        userid: 'u111',
        nombre: 'Jeff',
        tipo: 'Ahorro',
        moneda: 'Euros',
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
            child: Text('Agregar Monedas'),
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