import 'package:flutter/material.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
import 'package:app_ahorro/Base%20De%20Datos/ingreso.dart';
import 'Base De Datos/gasto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistorialPage extends StatefulWidget {
  const HistorialPage({super.key});

  @override
  State<HistorialPage> createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  String _selectedCurrency = '';
  String? selectedCuenta;
  List<Ingreso> _ingreso = [];
  List<Gasto> _gastos = [];

  @override
  void initState() {
    super.initState();
    _loadIngreso();
    _loadGastos();
    _loadSelectedCurrency();
    _laodComparacion();
  }

  Future<void> _loadSelectedCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedCurrency = prefs.getString('currency') ?? '';
    });
  }
  Future<void> _laodComparacion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedCuenta = prefs.getString('selectedCuenta') ?? '';
    });
  }

  Future<void> _loadIngreso() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedCuenta = prefs.getString('selectedCuenta');
    try {
      final ingresos = await DBHelper.queryIngresos();
      final filteredIngresos = ingresos.where((ingreso) {
        return ingreso.cuentaId == selectedCuenta;
      }).toList();

      setState(() {
        _ingreso = filteredIngresos;
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedCuenta = prefs.getString('selectedCuenta');
    try {
      final gastos = await DBHelper.queryGastos();
      final filteredGastos = gastos.where((gastos) {
        return gastos.cuentaId == selectedCuenta;
      }).toList();

      setState(() {
        _gastos = filteredGastos;
      });
    } catch (e) {
      print('Error al cargar gastos: $e');
    }
  }

  Future<void> _deleteGastos(int id) async {
    try {
      await DBHelper.deleteGasto(id);
      setState(() {
        _gastos.removeWhere((gasto) => gasto.id == id);
      });
    } catch (e) {
      print('Error al eliminar gasto: $e');
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
              // Lista de ingresos
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _ingreso.length,
                itemBuilder: (context, index) {
                  final ingreso = _ingreso[index];
                  Color cardColor = ingreso.monto > 900
                      ? Colors.green[900]!
                      : (Colors.green[ingreso.monto.truncate() % 1000] ?? Colors.green);
                    return Card(
                      color: cardColor,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10.0),
                        title: Text(
                          'Ingreso: ${ingreso.descripcion} \t$_selectedCurrency${ingreso.monto}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('Fecha y hora del ingreso ${ingreso.fecha}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteIngreso(ingreso.id!),
                        ),
                      ),
                    );
                },
              ),
              // Lista de gastos
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _gastos.length,
                itemBuilder: (context, index) {
                  final gasto = _gastos[index];
                  Color cardColor = gasto.monto > 900
                      ? Colors.red[900]!
                      : (Colors.red[gasto.monto.truncate() % 1000] ?? Colors.red);
                  return Card(
                    color: cardColor,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10.0),
                      title: Text(
                        'Gasto: ${gasto.descripcion} \t$_selectedCurrency${gasto.monto}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Fecha y hora del gasto ${gasto.fecha}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.green),
                        onPressed: () => _deleteGastos(gasto.id!),
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
