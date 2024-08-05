import 'package:flutter/material.dart';

class SetAccountDetailsScreen extends StatefulWidget {
  const SetAccountDetailsScreen({super.key});

  @override
  _SetAccountDetailsScreenState createState() =>
      _SetAccountDetailsScreenState();
}

class _SetAccountDetailsScreenState extends State<SetAccountDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  String _tipoCuenta = '';
  String _nombreCuenta = '';

  @override
  Widget build(BuildContext context) {
    final String moneda = ModalRoute.of(context)!.settings.arguments as String;

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
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pushNamed(
                      context,
                      '/set_cash_balance',
                      arguments: {
                        'moneda': moneda,
                        'tipoCuenta': _tipoCuenta,
                        'nombreCuenta': _nombreCuenta,
                      },
                    );
                  }
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
