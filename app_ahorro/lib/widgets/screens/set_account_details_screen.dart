import 'package:app_ahorro/Base%20De%20Datos/cuenta.dart';
import 'package:app_ahorro/Base%20De%20Datos/data_controller.dart';
import 'package:app_ahorro/Base%20De%20Datos/usuario.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetAccountDetailsScreen extends StatefulWidget {
  const SetAccountDetailsScreen({super.key});

  @override
  State<SetAccountDetailsScreen> createState() =>
      _SetAccountDetailsScreenState();
}

class _SetAccountDetailsScreenState extends State<SetAccountDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  String _tipoCuenta = '';
  String _nombreCuenta = '';
  String? _moneda;

  Future<void> agregarUsuarios() async {
    final DataController dataController = Get.find<DataController>(); // Obtener el DataController usando GetX
    final Usuario? usuarioActual = await dataController.getCurrentUser();

    if (usuarioActual == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se encontró el usuario actual')));
      return;
    }

    // Crear una nueva cuenta con los detalles ingresados
    Cuenta nuevaCuenta = Cuenta(
        nombre: _nombreCuenta,
        userid: usuarioActual.userId, 
        tipo: _tipoCuenta,
        moneda: _moneda ?? '');

    // Agregar la cuenta al controlador y manejar el resultado
    dataController.addCuenta(nuevaCuenta).then((result) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cuenta creada con éxito!')));
      Navigator.of(context).pushNamed(
        '/select_currency_screen',
        arguments: _moneda,
      );
    }).catchError((e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Account Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Set Account Details', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Account Type'),
                onSaved: (value) {
                  _tipoCuenta = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the account type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Account Name'),
                onSaved: (value) {
                  _nombreCuenta = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the account name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Currency'),
                items: const [
                  DropdownMenuItem(value: 'Lempira', child: Text('Lempira')),
                  DropdownMenuItem(value: 'Euro', child: Text('Euro')),
                  DropdownMenuItem(value: 'Dólar', child: Text('Dólar')),
                ],
                onChanged: (value) {
                  setState(() {
                    _moneda = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a currency';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    agregarUsuarios();
                  }
                },
                child: const Text('Register Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
