import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  final supabase = Supabase.instance.client;

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
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Guardar los datos en Supabase
                    final response = await supabase.from('cuentas').insert({
                      'usuario_id':
                          1, // Aquí debes establecer el ID del usuario actual
                      'tipo': _tipoCuenta,
                      'nombre': _nombreCuenta,
                      'moneda': moneda, // Aquí se incluye el ID de la moneda
                    });

                    // Obtener el ID de la cuenta recién creada
                    final selectResponse = await supabase
                        .from('cuentas')
                        .select('id')
                        .eq('usuario_id',
                            1) // Aquí debes establecer el ID del usuario actual
                        .eq('tipo', _tipoCuenta)
                        .eq('nombre', _nombreCuenta)
                        .eq('moneda', moneda)
                        .single();
                    final selectResponseId = selectResponse['id'];
                    Navigator.pushNamed(
                      context,
                      '/set_cash_balance',
                      arguments: {
                        'idCuenta': selectResponseId,
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
