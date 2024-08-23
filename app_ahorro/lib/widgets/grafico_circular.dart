import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
import 'package:app_ahorro/Base%20De%20Datos/ingreso.dart';
import 'package:app_ahorro/Base%20De%20Datos/gasto.dart';
import 'package:app_ahorro/widgets/inidcator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;
  double totalIngresos = 0;
  double totalGastos = 0;

  @override
  void initState() {
    super.initState();
    _calculateTotals();
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
      setState(() {
        totalIngresos = filteredIngresos.fold(0, (sum, item) => sum + item.monto);
        totalGastos = filteredGastos.fold(0, (sum, item) => sum + item.monto);
      });
    } catch (e) {
      print('Error al calcular totales: $e');
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(height: 18),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                color: Colors.green,
                text: 'Ingresos',
                isSquare: true,
              ),
              SizedBox(height: 4),
              Indicator(
                color: Colors.red,
                text: 'Gastos',
                isSquare: true,
              ),
              SizedBox(height: 18),
            ],
          ),
          const SizedBox(width: 28),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    final total = totalIngresos + totalGastos;
    if (total == 0) {
      return [
        PieChartSectionData(
          color: Colors.grey,
          value: 100,
          title: 'Sin datos',
          radius: 50.0,
          titleStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [Shadow(color: Colors.black, blurRadius: 2)],
          ),
        ),
      ];
    }

    return [
      PieChartSectionData(
        color: Colors.green,
        value: (totalIngresos > 0) ? totalIngresos / total * 100 : 0,
        title: (totalIngresos > 0)
            ? '${(totalIngresos / total * 100).toStringAsFixed(1)}%'
            : '',
        radius: touchedIndex == 0 ? 60.0 : 50.0,
        titleStyle: TextStyle(
          fontSize: touchedIndex == 0 ? 25.0 : 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: const [Shadow(color: Colors.black, blurRadius: 2)],
        ),
      ),
      PieChartSectionData(
        color: Colors.red,
        value: (totalGastos > 0) ? totalGastos / total * 100 : 0,
        title: (totalGastos > 0)
            ? '${(totalGastos / total * 100).toStringAsFixed(1)}%'
            : '',
        radius: touchedIndex == 1 ? 60.0 : 50.0,
        titleStyle: TextStyle(
          fontSize: touchedIndex == 1 ? 25.0 : 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: const [Shadow(color: Colors.black, blurRadius: 2)],
        ),
      ),
    ];
  }
}
