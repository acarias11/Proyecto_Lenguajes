import 'package:flutter/material.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
import 'package:app_ahorro/Base De Datos/ingreso.dart';
import 'Base De Datos/gasto.dart';
//import 'package:app_ahorro/Base De Datos/categoria.dart';
//import 'package:app_ahorro/Base De Datos/usuario.dart';



class HistorialPage extends StatefulWidget {
  
  const HistorialPage({super.key});

  @override
  State<HistorialPage> createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
   List<Ingreso> _ingreso = [];
   List<Gasto> _gastos=[];

  @override
  void initState() {
    super.initState();
    _loadIngreso();
    _loadGastos();
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
  Future<void> _loadGastos() async {
    try {
      final gastos = await DBHelper.queryGastos(
      );
      setState(() {
        _gastos = gastos;
      });
    } catch (e) {
      print('Error al cargar usuarios: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(
            children: [
                     ListView.builder(
                shrinkWrap: true,
                  itemCount: _ingreso.length,
                  itemBuilder: (context, index) {
                    final ingresos = _ingreso[index];
                    return Card(
                      color: Colors.green[ingresos.monto.truncate()],
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10.0),
                        title: Text(
                          'Ingreso: ${ingresos.descripcion} \t${ingresos.monto}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        
                      ),
                    );
                  },
                ),
                 ListView.builder(
                shrinkWrap: true,
                  itemCount: _gastos.length,
                  itemBuilder: (context, index) {
                    final gastos = _gastos[index];
                    return SizedBox(
                      child: Card(
                        color: Colors.red[gastos.monto.truncate()],
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10.0),
                          title: Text(
                            'Gasto: ${gastos.descripcion} \t${gastos.monto}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ), 
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}