
import 'package:app_ahorro/Base%20De%20Datos/data_controller.dart';
//import 'package:app_ahorro/Base%20De%20Datos/ingreso.dart';
import 'package:app_ahorro/Base%20De%20Datos/moneda.dart';
import 'package:flutter/material.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
//import 'package:app_ahorro/Base De Datos/ingreso.dart';
//import 'package:app_ahorro/Base De Datos/categoria.dart';
//import 'package:app_ahorro/Base De Datos/usuario.dart';
import 'package:get/get.dart';



class HomePage extends StatefulWidget {
  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
     Future<void> agregarMonedas() async {
      final DataController dataController= Get.put(DataController());
  
      Moneda moneda1 = Moneda(
        id: 1, 
        nombre: 'Dolares',
        simbolo: 'USD'
      );
     Moneda moneda2 = Moneda(
        id: 2, 
        nombre: 'Lempiras',
        simbolo: 'L'
      );
      Moneda moneda3 = Moneda(
        id: 3, 
        nombre: 'Euros',
        simbolo: '€',
      );
        try {
      int mon1 = await dataController.addMoneda(moneda1);
      int mon2 = await dataController.addMoneda(moneda2);
      int mon3 = await dataController.addMoneda(moneda3);
      print('Monedas agregados con éxito. IDs: $mon1, $mon2, $mon3');
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
            onPressed: agregarMonedas,
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