import 'package:flutter/material.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
import 'package:app_ahorro/Base De Datos/ingreso.dart';
import 'package:app_ahorro/Base De Datos/gasto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class MetaPage extends StatefulWidget {
  const MetaPage({super.key});

  @override
  _MetaPageState createState() => _MetaPageState();
}

class _MetaPageState extends State<MetaPage> {
  double _meta = 1000.0;
  String? selectedCuenta;
  double totalIngresos = 0;
  double totalGastos = 0;
  double _total = 0;

  @override
  void initState() {
    super.initState();
    _loadMeta();
    _laodComparacion();
    _calculateTotals();
  }

  Future<void> _laodComparacion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedCuenta = prefs.getString('selectedCuenta') ?? '';
    });
  }

  Future<void> _calculateTotals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedCuenta = prefs.getString('selectedCuenta');

    if (mounted && selectedCuenta != null) {
      try {
        List<Ingreso> ingresos = await DBHelper.queryIngresos();
        List<Gasto> gastos = await DBHelper.queryGastos();

        List<Ingreso> filteredIngresos = ingresos.where((ingreso) {
          return ingreso.cuentaId == selectedCuenta;
        }).toList();

        List<Gasto> filteredGastos = gastos.where((gasto) {
          return gasto.cuentaId == selectedCuenta;
        }).toList();

        double totalIngresos = filteredIngresos.fold(0, (sum, item) => sum + item.monto);
        double totalGastos = filteredGastos.fold(0, (sum, item) => sum + item.monto);

        setState(() {
          _total = totalIngresos - totalGastos;

          if (_total < 0) {
            _total = 0;  // Evitar números negativos
          }
        });
      } catch (e) {
        print('Error al calcular totales: $e');
      }
    }
  }

  Future<void> _loadMeta() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _meta = prefs.getDouble('Meta') ?? 1000.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_meta > 0) ? (_total / _meta) : 0.0;

  return Scaffold(
  body: SingleChildScrollView(
    child: Column(
      children: [
        const SizedBox( height: 100,width: 100),
        const Text('Progreso', style: TextStyle(fontSize: 40)),
        LiquidCustomProgressIndicator(
          value: progress,
          valueColor: const AlwaysStoppedAnimation(Colors.yellow),
          backgroundColor: Colors.grey[300],
          direction: Axis.vertical,
          shapePath: _buildShapePath(),
          center: const Text('Meta', style: TextStyle(fontSize: 30)),
        ),
        const SizedBox(height: 10),
        // Lista de ahorros
        LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: constraints.maxWidth, // Ocupa todo el ancho disponible
              height: 200,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 227, 209, 222),
                  Color.fromARGB(255, 174, 207, 202),
                ]),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'NUNCA TE RINDAS, RECUERDA QUE EL QUE PERSEVERA ALCANZA',
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),
      ],
    ),
  ),
);

  }
  Path _buildShapePath() {
    final path = Path();
    path.lineTo(0, 200); 
    path.lineTo(200, 200); 
    path.lineTo(200, 0); 
    return path;
  }
}
