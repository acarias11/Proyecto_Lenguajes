import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_ahorro/Base%20De%20Datos/db_helper.dart';
import 'package:app_ahorro/Base%20De%20Datos/cuenta.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _goalController = TextEditingController();
  double _goal = 1000.0;
  List<Cuenta> _cuentas = [];
  String? _selectedCurrency;
  String? _selectedCuenta;

  final List<String> _currencySymbols = ['L', '\$', '€']; // Símbolos de moneda
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
    _loadCuentas();
    _loadSelectedCuenta();
  }

  Future<void> _loadCuentas() async {
    List<Cuenta> cuentas = await DBHelper.queryCuentas();
    setState(() {
      _cuentas = cuentas;
    });
  }

  Future<void> _loadSelectedCuenta() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedCuenta = prefs.getString('selectedCuenta');
    });
  }

  void _onCuentaSelected(String? value) async {
    setState(() {
      _selectedCuenta = value;
    });

    // Guardar la cuenta seleccionada en SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedCuenta', value ?? '');
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

  void logout() async {
    await DBHelper.clearUserId();
    Navigator.of(context).pushReplacementNamed('/login'); // Redirige a la pantalla de login
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
          
          // Cambiar Cuenta
          ListTile(
            title: const Text('Cambiar Cuenta'),
            leading: const Icon(Icons.person),
            trailing: DropdownButton<String>(
              value: _selectedCuenta,
              hint: Text('Seleccione una cuenta'),
              onChanged: _onCuentaSelected,
              items: _cuentas.map((cuenta) {
                return DropdownMenuItem<String>(
                  value: cuenta.nombre,
                  child: Text(cuenta.nombre),
                );
              }).toList(),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Log Out
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out')),
              );
              logout();
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
