import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SetCashBalanceScreen extends StatefulWidget {
  const SetCashBalanceScreen({super.key});

  @override
  _SetCashBalanceScreenState createState() => _SetCashBalanceScreenState();
}

class _SetCashBalanceScreenState extends State<SetCashBalanceScreen> {
  final _formKey = GlobalKey<FormState>();
  String _saldo = '';
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    // Obtener el ID de la cuenta pasada como argumento
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int cuentaId = args['idCuenta'] as int;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Cash Balance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Set up your cash balance',
                  style: TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Cash Balance'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _saldo = value ?? '0';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your cash balance';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Guardar el saldo inicial en la tabla ingresos
                    final response = await supabase.from('ingresos').insert({
                      'cuenta_id': cuentaId,
                      'monto': _saldo,
                      'categoria_id': 1, // Puedes ajustar esto según sea necesario en este caso ingresos inicial
                      'descripcion': 'Ingreso inicial',
                      'fecha': DateTime.now().toIso8601String(), // Puedes ajustar la fecha según sea necesario
                    });

                    if (response.error == null) {
                      // Navegar a la siguiente pantalla o mostrar un mensaje de éxito
                      print('Ingreso registrado exitosamente');
                      print(response);
                    } else {
                      print('Error al guardar el ingreso: ${response.error!.message}');
                    }
                  }
                },
                child: const Text('Confirmar saldo Inicial'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
