import 'package:flutter/material.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
import 'package:app_ahorro/Base De Datos/ingreso.dart';
import 'Base De Datos/gasto.dart';
//import 'package:app_ahorro/Base De Datos/categoria.dart';
//import 'package:app_ahorro/Base De Datos/usuario.dart';
import 'package:app_ahorro/widgets/graph.dart';



class HomePage extends StatefulWidget {
  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   List<Ingreso> _ingreso = [];
   List<Gasto> _gastos=[];

  @override
  void initState() {
    super.initState();
    _loadIngreso();
    _loadGastos();
    _deleteIngreso(0);
    _deleteGastos(0);
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
   Future<void> _deleteIngreso(int id) async {
    try {
      await DBHelper.deleteIngreso(id);
      setState(() {
        _ingreso.removeWhere((ingreso) => ingreso.id == id);
      });
    } catch (e) {
      print('Error al eliminar ingreso: $e');
    }
  }
  Future<void> _deleteGastos(int id) async {
    try {
      await DBHelper.deleteGasto(id);
      setState(() {
        _gastos.removeWhere((gastos) => gastos.id == id);
      });
    } catch (e) {
      print('Error al eliminar Gastos: $e');
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
              // Agregar el gráfico aquí
             const Padding(
                padding:  EdgeInsets.all(30.0),
                child: SizedBox(
                  height: 200, // Ajusta la altura del gráfico
                  child: LineChartWidget(
                   gradientColor1: Color.fromARGB(255, 26, 171, 13), gradientColor2: Color.fromARGB(255, 105, 168, 110),
                   gradientColor3: Color.fromARGB(255, 57, 103, 52), indicatorStrokeColor: Color.fromARGB(255, 0, 0, 0), 
                  ),
                ),
              ),
              // Lista de ingresos
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
                         trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteIngreso(ingresos.id!),
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
                           trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.green),
                          onPressed: () => _deleteGastos(gastos.id!),
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