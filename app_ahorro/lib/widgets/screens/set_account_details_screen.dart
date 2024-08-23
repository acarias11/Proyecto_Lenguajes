import 'package:app_ahorro/Base%20De%20Datos/cuenta.dart';
import 'package:app_ahorro/Base%20De%20Datos/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetAccountDetailsScreen extends StatefulWidget {
  const SetAccountDetailsScreen({super.key, required this.usuario});
  final usuario;

  @override
  State<SetAccountDetailsScreen> createState() => _SetAccountDetailsScreenState();
}

class _SetAccountDetailsScreenState extends State<SetAccountDetailsScreen> {
  final pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _tipoCuenta = '';
  String _nombreCuenta = '';
  String? _moneda;

  @override
  Widget build(BuildContext context) {
    final userID = ModalRoute.of(context)!.settings.arguments as String;

    Future<void> agregarUsuarios(BuildContext context) async {
      final DataController dataController = Get.find<DataController>();

      Cuenta nuevaCuenta = Cuenta(
        nombre: _nombreCuenta,
        userid: userID,
        tipo: _tipoCuenta,
        moneda: _moneda ?? '',
      );

      // Comprobar si la cuenta tiene todos los datos completos
      if (nuevaCuenta.isDataComplete) {
        // Agregar la cuenta al controlador y manejar el resultado
        dataController.addCuenta(nuevaCuenta).then((result) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cuenta creada con éxito!')),
          );
          Navigator.of(context).pushReplacementNamed('/monto');
        }).catchError((e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        });
      } else {
        // Mostrar un mensaje de error si la cuenta no está completa
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, complete todos los campos')),
        );
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        
        child: Stack(
             children: [
            Container(
              height: 900,
              width: 600,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 8, 90, 8),
                    Color.fromARGB(255, 3, 49, 23),
                  ],
                ),
              ),
               child: const Padding(
                padding: EdgeInsets.only(top: 60.0, left: 22),
                child: Text(
                  'Agrega detalles de \ntu Cuenta!',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                height: 690,
                width: 600,            
           child:  Form(
            key: _formKey,
              child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Account Type',
                  hintText: 'Ingrese el tipo de cuenta',
                  ),
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
                const SizedBox(height: 70),
                 Container(
                        height: 55,
                        width: 300,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 11, 103, 46),
                              Color.fromARGB(255, 1, 71, 20),
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: TextButton(
                           onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      agregarUsuarios(context);
                    }
                  },
                          child: const Text(
                            'Guardar',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            )],
        ),
      ),
    );
  }
}
