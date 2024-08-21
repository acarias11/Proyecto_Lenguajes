import 'package:app_ahorro/Base%20De%20Datos/ingreso.dart';
import 'package:app_ahorro/Base%20De%20Datos/moneda.dart';
import 'package:app_ahorro/Base De Datos/gasto.dart';
import 'package:flutter/material.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
import 'package:app_ahorro/Base De Datos/cuenta.dart';
import 'package:app_ahorro/Base De Datos/usuario.dart';



class AhorroPage extends StatefulWidget {
  
  const AhorroPage({super.key});

  @override
  State<AhorroPage> createState() => _AhorroPageState();
}

class _AhorroPageState extends State<AhorroPage> {
   List<Ingreso> _ingreso = [];
   List<Usuario> _usuario=[];
   List<Moneda> _moneda=[];
   List<Gasto> _gastos=[];
   List<Cuenta> _cuentas=[];


  @override
  void initState() {
    super.initState();
    _loadIngreso();
    _loadUsuarios();
    _loadMoneda();
    _loadGastos();
    _loadCuenta();
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
  Future<void> _loadUsuarios() async {
    try {
      final usuarios = await DBHelper.queryUsuarios(
      );
      setState(() {
        _usuario = usuarios;
      });
    } catch (e) {
      print('Error al cargar usuarios: $e');
    }
  }
  Future<void> _loadMoneda() async {
    try {
      final moneda = await DBHelper.queryMonedas(
      );
      setState(() {
        _moneda = moneda;
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
  Future<void> _loadCuenta() async {
    try {
      final cuentas = await DBHelper.queryCuentas(
      );
      setState(() {
        _cuentas = cuentas;
      });
    } catch (e) {
      print('Error al cargar usuarios: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página de Inicio'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              width: 300,
              child: ListView.builder(
                itemCount: _usuario.length,
                itemBuilder: (context, index) {
                  final usuario = _usuario[index];
                  return ListTile(
                    title: Text('${usuario.id}, ${usuario.userId},${usuario.email}, ${usuario.nombre},  ${usuario.contrasena}'),
              );
              }
              ),
            ),
              SizedBox(
                height: 100,
              width: 300,
              child: ListView.builder(
                itemCount: _cuentas.length,
                itemBuilder: (context, index) {
                  final cuentas = _cuentas[index];
                  return ListTile(
                    title: Text('${cuentas.id}, ${cuentas.moneda},${cuentas.nombre} '),
              );
              }
              ),
            ),
            
            SizedBox(
              height: 100,
              width: 300,
              child: ListView.builder(
                itemCount: _moneda.length,
                itemBuilder: (context, index) {
                  final moneda = _moneda[index];
                  return ListTile(
                    title: Text('${moneda.id}, ${moneda.nombre},${moneda.simbolo}'),
              );
              },
              
              ),
            ),
             SizedBox(
              height: 100,
              width: 300,
              child: ListView.builder(
                itemCount: _ingreso.length,
                itemBuilder: (context, index) {
                  final ingresos = _ingreso[index];
                  return ListTile(
                    title: Text('Ingreso: ${ingresos.descripcion}'),
                    subtitle: Text('${ingresos.monto} - ${ingresos.fecha}'),
              );
              },
              ),
            ),
             SizedBox(
              height: 100,
              width: 300,
              child: ListView.builder(
                itemCount: _gastos.length,
                itemBuilder: (context, index) {
                  final gastos = _gastos[index];
                  return ListTile(
                    title: Text('${gastos.id}, ${gastos.monto},${gastos.descripcion}, ${gastos.fecha}'),
              );
              },
              
              ),
            ),
          ],
        ),
      ),
    );
  }
}