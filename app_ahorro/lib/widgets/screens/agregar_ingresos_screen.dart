import 'package:app_ahorro/Base%20De%20Datos/data_controller.dart';
//import 'package:app_ahorro/Base%20De%20Datos/ingreso.dart';
//import 'package:app_ahorro/Base%20De%20Datos/moneda.dart';
import 'package:flutter/material.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
import 'package:app_ahorro/Base De Datos/ingreso.dart';
//import 'package:app_ahorro/Base De Datos/categoria.dart';
import 'package:get/get.dart';



class AgregarIngresosScreen extends StatefulWidget {
  
  const AgregarIngresosScreen({super.key});

  @override
  State<AgregarIngresosScreen> createState() => _AgregarIngresosState();
}

class _AgregarIngresosState extends State<AgregarIngresosScreen> {
   List<Ingreso> _ingreso = [];

  @override
  void initState() {
    super.initState();
    _loadIngreso();
  }
  
  Future<void> _loadIngreso() async {
    try {
      final ingreso = await DBHelper.queryIngresos(
      );
      setState(() {
        _ingreso = ingreso;
      });
    } catch (e) {
      print('Error al cargar usuarios: $e');
    }
  }


     Future<void> agregarIngresos() async {
      final DataController dataController= Get.put(DataController());
  
      Ingreso ingreso1 = Ingreso(
        monto: 200,
        fecha: DateTime(2024, 8, 19),
        cuentaId: 1,
        descripcion: 'Pollo con Tajadas'
      );
     Ingreso ingreso2 = Ingreso(
        monto: 350,
        fecha: DateTime(2024, 8, 19),
        cuentaId: 1,
        descripcion: 'Pelota'
      );
      
        try {
      int in1= await dataController.addIngreso(ingreso1);
      int int2 = await dataController.addIngreso(ingreso2);
      print('Ingresos agregados con éxito. IDs: $in1, $int2');
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
            onPressed: agregarIngresos,
            child: Text('Agregar Monedas'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _ingreso.length,
              itemBuilder: (context, index) {
                final ingreso = _ingreso[index];
                return ListTile(
                  title: Text(ingreso.descripcion),
                  subtitle: Text('${ingreso.monto}'),
            );
            },
            
            ),
          ),
           Expanded(
            child: ListView.builder(
              itemCount: _ingreso.length,
              itemBuilder: (context, index) {
                final ingresos = _ingreso[index];
                return ListTile(
                  title: Text('Ingreso: ${ingresos.descripcion}'),
                  subtitle: Text('${ingresos.monto} - ${ingresos.fecha}'),
            );
            },
            
            ),
          ),
        ],
      ),
    );
  }
}