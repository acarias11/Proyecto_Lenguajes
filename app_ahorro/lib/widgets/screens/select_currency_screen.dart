import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
import 'package:app_ahorro/Base%20De%20Datos/moneda.dart';
import 'package:flutter/material.dart';

class SelectCurrencyScreen extends StatefulWidget {
  const SelectCurrencyScreen({super.key});

  @override
  State<SelectCurrencyScreen> createState() => _SelectCurrencyScreenState();
}

class _SelectCurrencyScreenState extends State<SelectCurrencyScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _currencyName;
  late String _currencySymbol;

  @override
  void initState() {
    super.initState();
    _initializeCurrency();
  }

  Future<void> _initializeCurrency() async {
    final currencyType = ModalRoute.of(context)!.settings.arguments as String;
    switch (currencyType) {
      case 'Lempira':
        _currencyName = 'Lempira';
        _currencySymbol = 'L';
        break;
      case 'Euro':
        _currencyName = 'Euro';
        _currencySymbol = '€';
        break;
      case 'Dólar':
        _currencyName = 'Dólar';
        _currencySymbol = '\$';
        break;
      default:
        _currencyName = 'Unknown';
        _currencySymbol = '?';
        break;
    }
  }

  Future<void> _addCurrency() async {
    final moneda = Moneda(nombre: _currencyName, simbolo: _currencySymbol);
    await DBHelper.insertMoneda(moneda);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Moneda $_currencyName agregada con éxito')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Moneda'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Detalles de la Moneda', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 20),
              Text('Nombre: $_currencyName', style: const TextStyle(fontSize: 18)),
              Text('Símbolo: $_currencySymbol', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _addCurrency();
                },
                child: const Text('Agregar Moneda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
