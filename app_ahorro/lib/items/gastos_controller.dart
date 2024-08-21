import 'package:get/get.dart';
import 'package:app_ahorro/Base%20De%20Datos/gasto.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';

class GastoController extends GetxController {
  var gastos = <Gasto>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadGastos();
  }

  Future<void> _loadGastos() async {
    try {
      final fetchedGastos = await DBHelper.queryGastos();
      gastos.value = fetchedGastos;
    } catch (e) {
      print('Error al cargar gastos: $e');
    }
  }

  void addGasto(Gasto gasto) {
    gastos.add(gasto);
  }

  void removeGasto(int id) {
    gastos.removeWhere((gasto) => gasto.id == id);
  }
}
