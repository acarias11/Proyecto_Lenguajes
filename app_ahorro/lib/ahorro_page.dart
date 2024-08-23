import 'package:flutter/material.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
import 'Base De Datos/ahorro.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';


class AhorroPage extends StatefulWidget {
  const AhorroPage({super.key});

  @override
  State<AhorroPage> createState() => _AhorroPageState();
}

class _AhorroPageState extends State<AhorroPage> {
  List<Ahorro> _ahorro = [];
  double _totalAhorros = 0.0;
  double _goal = 1000.0; // Valor predeterminado
  String? selectedCuenta;
  


  @override
  void initState() {
    super.initState();
    _loadAhorros();
    _loadGoal();
        _laodComparacion();

  }
 Future<void> _laodComparacion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedCuenta = prefs.getString('selectedCuenta') ?? '';
    });
  }
   Future<void> _loadAhorros() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedCuenta = prefs.getString('selectedCuenta');
    try {
      final ahorros = await DBHelper.queryAhorro();
      final filteredAhorro = ahorros.where((ahorro) {
        return ahorro.cuentaId == selectedCuenta;
      }).toList();

      setState(() {
        _ahorro = filteredAhorro;
        _totalAhorros = _ahorro.fold(0.0, (sum, item) => sum + item.monto);
      });
    } catch (e) {
      print('Error al cargar ingresos: $e');
    }
  }
  Future<void> _deleteAhorro(int id) async {
    try {
      await DBHelper.deleteAhorro(id);
      setState(() {
        _ahorro.removeWhere((ahorros) => ahorros.id == id);
        _totalAhorros = _ahorro.fold(0.0, (sum, item) => sum + item.monto);
      });
    } catch (e) {
      print('Error al eliminar Ahorros: $e');
    }
  }

  Future<void> _loadGoal() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _goal = prefs.getDouble('goal') ?? 1000.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_goal > 0) ? (_totalAhorros / _goal) : 0.0;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              const Text('Progreso',style: TextStyle(fontSize: 40)),
              LiquidCustomProgressIndicator(
                value: progress,
                valueColor: const AlwaysStoppedAnimation(Colors.yellow),
                backgroundColor: Colors.grey[300],
                direction: Axis.vertical,
                shapePath: _buildShapePath(),
                center: const Text('Meta', style: TextStyle(fontSize: 30),),
              ),
              const SizedBox(height: 10),
              // Lista de ahorros
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _ahorro.length,
                itemBuilder: (context, index) {
                  final ahorros = _ahorro[index];
                  Color cardColor = ahorros.monto > 900
                      ? Colors.yellow[900]!
                      : (Colors.yellow[ahorros.monto.truncate() % 1000] ?? Colors.yellow); 
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
                        'Ahorros: ${ahorros.descripcion} \t${ahorros.monto}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteAhorro(ahorros.id!),
                      ),
                    ),
                  );
                }
              ),
            ],
          ),
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

