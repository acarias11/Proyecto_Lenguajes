import 'package:app_ahorro/Base%20De%20Datos/cuenta.dart';
import 'package:app_ahorro/Base%20De%20Datos/gasto.dart';
import 'package:app_ahorro/Base%20De%20Datos/ingreso.dart';
import 'package:app_ahorro/Base%20De%20Datos/moneda.dart';
import 'package:app_ahorro/Base%20De%20Datos/usuario.dart';
import 'package:app_ahorro/Base%20De%20Datos/ahorro.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _cuentasTable = "cuentas";
  static final String _monedasTable = "monedas";
  static final String _ingresosTable = "ingresos";
  static final String _gastosTable = "gastos";
  static final String _usuariosTable = "usuarios";
  static final String _ahorroTable = "ahorro";

  // Inicializar la base de datos
  static Future<void> initDB() async {
    if (_db != null) return;

    try {
      String _path = join(await getDatabasesPath(), 'app_ahorro.db');
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          db.execute(
            "CREATE TABLE $_cuentasTable ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "userID TEXT,"
            "nombre TEXT,"
            "tipo TEXT,"
            "moneda TEXT"
            ")",
          );
          db.execute(
            "CREATE TABLE $_monedasTable ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "nombre TEXT,"
            "simbolo TEXT"
            ")",
          );
          db.execute(
            "CREATE TABLE $_ingresosTable ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "monto REAL,"
            "fecha TEXT,"
            "cuentaId INTEGER,"
            "descripcion TEXT,"
            "FOREIGN KEY (cuentaId) REFERENCES $_cuentasTable (id)"
            ")",
          );
          db.execute(
            "CREATE TABLE $_gastosTable ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "monto REAL,"
            "fecha TEXT,"
            "cuentaId INTEGER,"
            "descripcion TEXT,"
            "FOREIGN KEY (cuentaId) REFERENCES $_cuentasTable (id)"
            ")",
          );
          db.execute(
            "CREATE TABLE $_usuariosTable ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "userID TEXT,"
            "nombre TEXT,"
            "email TEXT,"
            "contrasena TEXT"
            ")",
          );
          db.execute(
            "CREATE TABLE $_ahorroTable ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "monto REAL,"
            "fecha TEXT,"
            "cuentaId INTEGER,"
            "descripcion TEXT,"
            "FOREIGN KEY (cuentaId) REFERENCES $_cuentasTable (id)"
            ")",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  // Métodos para Cuentas
  static Future<int> insertCuenta(Cuenta? cuenta) async {
    if (_db == null) throw Exception('Database not initialized');
    return await _db!.insert(_cuentasTable, cuenta!.toJson());
  }

  static Future<List<Cuenta>> queryCuentas() async {
    if (_db == null) throw Exception('Database not initialized');
    final List<Map<String, dynamic>> maps = await _db!.query(_cuentasTable);
    return List.generate(maps.length, (i) => Cuenta.fromJson(maps[i]));
  }

  static Future<int> deleteCuenta(int id) async {
    if (_db == null) throw Exception('Database not initialized');
    return await _db!.delete(_cuentasTable, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> updateCuenta(Cuenta cuenta) async {
    if (_db == null) throw Exception('Database not initialized');
    return await _db!.update(
      _cuentasTable,
      cuenta.toJson(),
      where: 'id = ?',
      whereArgs: [cuenta.id],
    );
  }

  // Métodos para Monedas
  static Future<int> insertMoneda(Moneda? moneda) async {
    if (_db == null) throw Exception('Database not initialized');
    return await _db!.insert(_monedasTable, moneda!.toJson());
  }

  static Future<List<Moneda>> queryMonedas() async {
    if (_db == null) throw Exception('Database not initialized');
    final List<Map<String, dynamic>> maps = await _db!.query(_monedasTable);
    return List.generate(maps.length, (i) => Moneda.fromJson(maps[i]));
  }

  static Future<int> deleteMoneda(int id) async {
    if (_db == null) throw Exception('Database not initialized');
    return await _db!.delete(_monedasTable, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> updateMoneda(Moneda moneda) async {
    if (_db == null) throw Exception('Database not initialized');
    return await _db!.update(
      _monedasTable,
      moneda.toJson(),
      where: 'id = ?',
      whereArgs: [moneda.id],
    );
  }

  // Métodos para Ingresos
  static Future<int> insertIngreso(Ingreso? ingreso) async {
    if (_db == null) throw Exception('Database not initialized');
    return await _db!.insert(_ingresosTable, ingreso!.toJson());
  }

  static Future<List<Ingreso>> queryIngresos() async {
    if (_db == null) throw Exception('Database not initialized');
    final List<Map<String, dynamic>> maps = await _db!.query(_ingresosTable);
    return List.generate(maps.length, (i) => Ingreso.fromJson(maps[i]));
  }

  static Future<int> deleteIngreso(int id) async {
    if (_db == null) throw Exception('Database not initialized');
    return await _db!.delete(_ingresosTable, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> updateIngreso(Ingreso ingreso) async {
    if (_db == null) throw Exception('Database not initialized');
    return await _db!.update(
      _ingresosTable,
      ingreso.toJson(),
      where: 'id = ?',
      whereArgs: [ingreso.id],
    );
  }

  // Métodos para Gastos
  static Future<int> insertGasto(Gasto? gasto) async {
    if (_db == null) throw Exception('Database not initialized');
    return await _db!.insert(_gastosTable, gasto!.toJson());
  }

  static Future<List<Gasto>> queryGastos() async {
    if (_db == null) throw Exception('Database not initialized');
    final List<Map<String, dynamic>> maps = await _db!.query(_gastosTable);
    return List.generate(maps.length, (i) => Gasto.fromJson(maps[i]));
  }

  static Future<int> deleteGasto(int id) async {
    if (_db == null) throw Exception('Database not initialized');
    return await _db!.delete(_gastosTable, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> updateGasto(Gasto gasto) async {
    if (_db == null) throw Exception('Database not initialized');
    return await _db!.update(
      _gastosTable,
      gasto.toJson(),
      where: 'id = ?',
      whereArgs: [gasto.id],
    );
  }
  // Métodos para Usuarios
  static Future<int> insertUsuario(Usuario? usuario) async {
    if (_db == null) throw Exception('Database not initialized');
    return await _db!.insert(_usuariosTable, usuario!.toJson());
  }

  static Future<List<Usuario>> queryUsuarios() async {
    if (_db == null) throw Exception('Database not initialized');
    final List<Map<String, dynamic>> maps = await _db!.query(_usuariosTable);
    return List.generate(maps.length, (i) => Usuario.fromJson(maps[i]));
  }

  static Future<int> deleteUsuario(int id) async {
    if (_db == null) throw Exception('Database not initialized');
    return await _db!.delete(_usuariosTable, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> updateUsuario(Usuario usuario) async {
    if (_db == null) throw Exception('Database not initialized');
    return await _db!.update(
      _usuariosTable,
      usuario.toJson(),
      where: 'id = ?',
      whereArgs: [usuario.id],
    );
  }

  // Métodos para Ahorro
  static Future<int> insertAhorro(Ahorro? ahorro) async {
    if (_db == null) throw Exception('Database not initialized');
    return await _db!.insert(_ahorroTable, ahorro!.toJson());
  }

  static Future<List<Ahorro>> queryAhorro() async {
    if (_db == null) throw Exception('Database not initialized');
    final List<Map<String, dynamic>> maps = await _db!.query(_ahorroTable);
    return List.generate(maps.length, (i) => Ahorro.fromJson(maps[i]));
  }

  static Future<int> deleteAhorro(int id) async {
    if (_db == null) throw Exception('Database not initialized');
    return await _db!.delete(_ahorroTable, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> updateAhorro(Ahorro ahorro) async {
    if (_db == null) throw Exception('Database not initialized');
    return await _db!.update(
      _ahorroTable,
      ahorro.toJson(),
      where: 'id = ?',
      whereArgs: [ahorro.id],
    );
  }
}
