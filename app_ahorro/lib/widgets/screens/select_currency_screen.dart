import 'package:app_ahorro/Base%20De%20Datos/moneda.dart';
import 'package:flutter/material.dart';

class SelectCurrencyScreen extends StatefulWidget {
  const SelectCurrencyScreen({super.key});

  @override
  State<SelectCurrencyScreen> createState() => _SelectCurrencyScreenState();
}

class _SelectCurrencyScreenState extends State<SelectCurrencyScreen> {
  Moneda? monedaSeleccionada;
  final listaDeMonedas = [
    Moneda(nombre: 'Dólar', simbolo: '\$'),
    Moneda(nombre: 'Euro', simbolo: '€'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccione una moneda'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Select Base Currency', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            monedaSeleccionada == null
                ? const CircularProgressIndicator()
                : DropdownButtonFormField<Moneda>(
                    decoration:
                        const InputDecoration(labelText: 'Base Currency'),
                    value: monedaSeleccionada,
                    onChanged: (newValue) {
                      setState(() {
                        monedaSeleccionada = newValue!;
                      });
                    },
                    items: listaDeMonedas.map((moneda) {
                      return DropdownMenuItem<Moneda>(
                        value: moneda,
                        child: Text(moneda as String),
                      );
                    }).toList(),
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                Navigator.pushNamed(
                  context,
                  'inicio', 
                  arguments: monedaSeleccionada,
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
