import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SelectCurrencyScreen extends StatefulWidget {
  const SelectCurrencyScreen({super.key});

  @override
  _SelectCurrencyScreenState createState() => _SelectCurrencyScreenState();
}

class _SelectCurrencyScreenState extends State<SelectCurrencyScreen> {
  String _moneda = 'USD';
  List<String> _monedas = [];
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _fetchMonedas();
  }

  Future<void> _fetchMonedas() async {
    final response = await supabase.from('monedas').select('nombre');

    setState(() {
      _monedas = List<String>.from(response.map((moneda) => moneda['nombre']));
      _moneda = _monedas.isNotEmpty ? _monedas[0] : '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Base Currency'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Select Base Currency', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            _monedas.isEmpty
                ? const CircularProgressIndicator()
                : DropdownButtonFormField<String>(
                    decoration:
                        const InputDecoration(labelText: 'Base Currency'),
                    value: _moneda,
                    onChanged: (newValue) {
                      setState(() {
                        _moneda = newValue!;
                      });
                    },
                    items: _monedas.map((moneda) {
                      return DropdownMenuItem(
                        value: moneda,
                        child: Text(moneda),
                      );
                    }).toList(),
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/set_account_details', // Cambiamos la ruta aquí
                  arguments: _moneda,
                );
              },
              child: const Text('Confirmar moneda'),
            ),
          ],
        ),
      ),
    );
  }
}