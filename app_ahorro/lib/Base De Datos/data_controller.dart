import 'package:app_ahorro/Base De Datos/categoria.dart';
import 'package:app_ahorro/Base%20De%20Datos/cuenta.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
import 'package:app_ahorro/Base%20De%20Datos/gasto.dart';
import 'package:app_ahorro/Base%20De%20Datos/ingreso.dart';
import 'package:app_ahorro/Base%20De%20Datos/moneda.dart';
import 'package:app_ahorro/Base%20De%20Datos/usuario.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    getCuentas();
    getMonedas();
    getIngresos();
    getGastos();
    getCategorias();
    getUsuarios();
  }

  var cuentaList = <Cuenta>[].obs;
  var monedaList = <Moneda>[].obs;
  var ingresoList = <Ingreso>[].obs;
  var gastoList = <Gasto>[].obs;
  var categoriaList = <Categoria>[].obs;
  var usuarioList = <Usuario>[].obs;

  // Métodos para Cuentas
  Future<int> addCuenta(Cuenta cuenta) async {
    int result = await DBHelper.insertCuenta(cuenta);
    getCuentas();
    return result;
  }

  void getCuentas() async {
    List<Cuenta> cuentas = await DBHelper.queryCuentas();
    cuentaList.assignAll(cuentas);
  }

  Future<void> deleteCuenta(int id) async {
    await DBHelper.deleteCuenta(id);
    getCuentas();
  }

  Future<void> updateCuenta(Cuenta cuenta) async {
    await DBHelper.updateCuenta(cuenta);
    getCuentas();
  }

  // Métodos para Monedas
  Future<int> addMoneda(Moneda moneda) async {
    int result = await DBHelper.insertMoneda(moneda);
    getMonedas();
    return result;
  }

  void getMonedas() async {
    List<Moneda> monedas = await DBHelper.queryMonedas();
    monedaList.assignAll(monedas);
  }

  Future<void> deleteMoneda(int id) async {
    await DBHelper.deleteMoneda(id);
    getMonedas();
  }

  Future<void> updateMoneda(Moneda moneda) async {
    await DBHelper.updateMoneda(moneda);
    getMonedas();
  }

  // Métodos para Ingresos
  Future<int> addIngreso(Ingreso ingreso) async {
    int result = await DBHelper.insertIngreso(ingreso);
    getIngresos();
    return result;
  }

  void getIngresos() async {
    List<Ingreso> ingresos = await DBHelper.queryIngresos();
    ingresoList.assignAll(ingresos);
  }

  Future<void> deleteIngreso(int id) async {
    await DBHelper.deleteIngreso(id);
    getIngresos();
  }

  Future<void> updateIngreso(Ingreso ingreso) async {
    await DBHelper.updateIngreso(ingreso);
    getIngresos();
  }

  // Métodos para Gastos
  Future<int> addGasto(Gasto gasto) async {
    int result = await DBHelper.insertGasto(gasto);
    getGastos();
    return result;
  }

  void getGastos() async {
    List<Gasto> gastos = await DBHelper.queryGastos();
    gastoList.assignAll(gastos);
  }

  Future<void> deleteGasto(int id) async {
    await DBHelper.deleteGasto(id);
    getGastos();
  }

  Future<void> updateGasto(Gasto gasto) async {
    await DBHelper.updateGasto(gasto);
    getGastos();
  }

  // Métodos para Categorías
  Future<int> addCategoria(Categoria categoria) async {
    int result = await DBHelper.insertCategoria(categoria);
    getCategorias();
    return result;
  }

  void getCategorias() async {
    List<Categoria> categorias = await DBHelper.queryCategorias();
    categoriaList.assignAll(categorias);
  }

  Future<void> deleteCategoria(int id) async {
    await DBHelper.deleteCategoria(id);
    getCategorias();
  }

  Future<void> updateCategoria(Categoria categoria) async {
    await DBHelper.updateCategoria(categoria);
    getCategorias();
  }

  // Métodos para Usuarios
  Future<int> addUsuario(Usuario usuario) async {
    int result = await DBHelper.insertUsuario(usuario);
    getUsuarios();
    return result;
  }

  void getUsuarios() async {
    List<Usuario> usuarios = await DBHelper.queryUsuarios();
    usuarioList.assignAll(usuarios);
  }

  Future<void> deleteUsuario(int id) async {
    await DBHelper.deleteUsuario(id);
    getUsuarios();
  }

  Future<void> updateUsuario(Usuario usuario) async {
    await DBHelper.updateUsuario(usuario);
    getUsuarios();
  }
}