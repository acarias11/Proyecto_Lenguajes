import 'package:flutter/material.dart';

class SetCashBalanceScreen extends StatefulWidget {
  const SetCashBalanceScreen({super.key});

  @override
  _SetCashBalanceScreenState createState() => _SetCashBalanceScreenState();
}

class _SetCashBalanceScreenState extends State<SetCashBalanceScreen> {
  final _formKey = GlobalKey<FormState>();
  String _saldo = '';

  @override
  Widget build(BuildContext context) {
    final Map<String, String> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String moneda = args['moneda']!;
    final String tipoCuenta = args['tipoCuenta']!;
    final String nombreCuenta = args['nombreCuenta']!;

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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    print('Moneda: $moneda');

                    print('Tipo de Cuenta: $tipoCuenta');
                    print('Nombre de la Cuenta: $nombreCuenta');
                    print('Saldo: $_saldo');
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
