import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _goalController = TextEditingController();
  double _goal = 1000.0;
  String? _selectedCurrency;
  final List<String> _currencySymbols = ['L', '\$', '€']; // Simbolos de moneda
  final Map<String, String> _currencyNames = {
    'L': 'Lempira',
    '\$': 'Dólar',
    '€': 'Euro',
  };

  @override
  void initState() {
    super.initState();
    _loadGoal();
    _loadCurrency();
  }

  Future<void> _loadGoal() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _goal = prefs.getDouble('goal') ?? _goal;
      _goalController.text = _goal.toString();
    });
  }

  Future<void> _saveGoal() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _goal = double.tryParse(_goalController.text) ?? _goal;
      prefs.setDouble('goal', _goal);
    });
  }

  Future<void> _loadCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedCurrency = prefs.getString('currency') ?? _currencySymbols.first;
    });
  }

  Future<void> _changeCurrency(String newCurrency) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedCurrency = newCurrency;
      prefs.setString('currency', newCurrency);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuraciones'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Cambiar Meta de Ahorro
          ListTile(
            title: const Text('Meta de Ahorro'),
            leading: const Icon(Icons.assessment),
            subtitle: TextField(
              controller: _goalController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ingrese nueva meta',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _saveGoal,
            child: const Text('Guardar Meta'),
          ),
          const SizedBox(height: 20),
          
          // Cambiar Moneda
          ListTile(
            title: const Text('Cambiar Moneda'),
            leading: const Icon(Icons.monetization_on),
            subtitle: _selectedCurrency != null 
              ? Text('Moneda actual: ${_currencyNames[_selectedCurrency!]}') 
              : const Text('Cargando...'),
            trailing: DropdownButton<String>(
              value: _selectedCurrency,
              items: _currencySymbols.map((String symbol) {
                return DropdownMenuItem<String>(
                  value: symbol,
                  child: Text(_currencyNames[symbol]!),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  _changeCurrency(newValue);
                }
              },
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Log Out
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out')),
              );
              Navigator.of(context).pop('/');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text(
              'Log Out',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
