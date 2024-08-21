import 'package:app_ahorro/widgets/grafico_circular.dart';
import 'package:flutter/material.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
import 'package:app_ahorro/Base De Datos/ingreso.dart';
import 'Base De Datos/gasto.dart';
import 'package:app_ahorro/widgets/graph.dart';
import 'widgets/grafico_gastos.dart';
class HomePage extends StatefulWidget {
   HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Ingreso> _ingreso = [];

  List<Gasto> _gastos = [];

  @override
  void initState() {
    super.initState();
    _loadIngreso();
    _loadGastos();
  }

  Future<void> _loadIngreso() async {
    try {
      final ingreso = await DBHelper.queryIngresos();
      setState(() {
        _ingreso = ingreso;
      });
    } catch (e) {
      print('Error al cargar ingresos: $e');
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

  Future<void> _loadGastos() async {
    try {
      final gastos = await DBHelper.queryGastos();
      setState(() {
        _gastos = gastos;
      });
    } catch (e) {
      print('Error al cargar gastos: $e');
    }
  }

  Future<void> _deleteGastos(int id) async {
    try {
      await DBHelper.deleteGasto(id);
      setState(() {
        _gastos.removeWhere((gastos) => gastos.id == id);
      });
    } catch (e) {
      print('Error al eliminar gastos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
             const SizedBox(height: 50.0),
           const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:  Row(
                  children: [
                     SizedBox(
                      height: 250,
                      width: 400,
                      child:PieChartSample2()
                    ),
                     SizedBox(
                      height: 200,
                      width: 350,                      child: LineChartWidget(
                        gradientColor1: Color.fromARGB(255, 26, 171, 13),
                        gradientColor2: Color.fromARGB(255, 105, 168, 110),
                        gradientColor3: Color.fromARGB(255, 57, 103, 52),
                        indicatorStrokeColor: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                     SizedBox(
                      height: 200,
                      width: 300,  
                     child: LineChartGastosWidget(gradientColor1: Color.fromARGB(255, 212, 5, 5),
                        gradientColor2: Color.fromARGB(255, 218, 107, 79),
                        gradientColor3: Color.fromARGB(255, 240, 143, 16),
                        indicatorStrokeColor: Color.fromARGB(255, 0, 0, 0),)
                     ),
                  ],
                ),
              ),

              // Lista de ingresos
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _ingreso.length,
                itemBuilder: (context, index) {
                  final ingresos = _ingreso[index];
                  return Card(
                    color: Colors.green[ingresos.monto.truncate()],
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
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
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _gastos.length,
                itemBuilder: (context, index) {
                  final gastos = _gastos[index];
                  return Card(
                    color: Colors.red[gastos.monto.floor()],
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
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