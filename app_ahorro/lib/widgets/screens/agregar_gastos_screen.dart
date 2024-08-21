import 'package:app_ahorro/Base%20De%20Datos/gasto.dart';
import 'package:flutter/material.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
import 'package:app_ahorro/Base%20De%20Datos/cuenta.dart';

class AgregarGastoPage extends StatefulWidget {
  @override
  _AgregarGastoPageState createState() => _AgregarGastoPageState();
}

class _AgregarGastoPageState extends State<AgregarGastoPage> {
  final TextEditingController _montoController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  List<Cuenta> _cuentas = [];
  Cuenta? _selectedCuenta;

  @override
  void initState() {
    super.initState();
    _loadCuentas();
  }

  Future<void> _loadCuentas() async {
    try {
      final cuentas = await DBHelper.queryCuentas();
      setState(() {
        _cuentas = cuentas;
      });
    } catch (e) {
      print('Error al cargar cuentas: $e');
    }
  }

  void _saveGasto() async {
    final monto = double.tryParse(_montoController.text);
    final descripcion = _descripcionController.text;

    if (monto == null || descripcion.isEmpty || _selectedCuenta == null) {
      ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text('Por favor, ingrese un monto, descripción y seleccione una cuenta')),
      );
      return;
    }

    final gasto = Gasto(
      monto: monto,
      fecha: DateTime.now(),
      cuentaId: _selectedCuenta!.id,
      descripcion: descripcion,
    );

    try {
      await DBHelper.insertGasto(gasto);
      Navigator.pop(context);  
    } catch (e) {
      print('Error al agregar ingreso: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al agregar el gasto')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Gasto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _montoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Monto'),
            ),
            TextField(
              controller: _descripcionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            DropdownButton<Cuenta>(
              hint: Text('Selecciona una cuenta'),
              value: _selectedCuenta,
              onChanged: (Cuenta? newValue) {
                setState(() {
                  _selectedCuenta = newValue;
                });
              },
              items: _cuentas.map<DropdownMenuItem<Cuenta>>((Cuenta cuenta) {
                return DropdownMenuItem<Cuenta>(
                  value: cuenta,
                  child: Text(cuenta.nombre),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveGasto,
              child: const Text('Guardar Gasto'),
            ),
          ],
        ),
      ),
    );
  }
}