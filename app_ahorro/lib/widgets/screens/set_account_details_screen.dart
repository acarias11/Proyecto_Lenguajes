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

  Future<void> agregarUsuarios() async {
    final DataController dataController = Get.put(DataController());
    final String moneda = ModalRoute.of(context)!.settings.arguments as String;
    final userid = Usuario.fromJson(dataController as Map<String, dynamic>).userId;

    Cuenta nuevaCuenta = Cuenta(
        nombre: _nombreCuenta,
        userid: userid,
        tipo: _tipoCuenta,
        moneda: moneda);

    dataController.addCuenta(nuevaCuenta).then((result) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cuenta creada con exito!')));
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) return;
                  agregarUsuarios();
                  Navigator.of(context).popAndPushNamed('/inicio');
                },
                child: const Text('Registrar cuenta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}