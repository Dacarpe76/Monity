import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monity/data/currencies.dart';
import 'package:monity/data/database.dart';
import 'package:monity/providers.dart';
import 'package:monity/ui/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drift/drift.dart' as drift;

class SetupScreen extends ConsumerStatefulWidget {
  const SetupScreen({super.key});

  @override
  SetupScreenState createState() => SetupScreenState();
}

class SetupScreenState extends ConsumerState<SetupScreen> {
  final _pageController = PageController();
  final _formKey = GlobalKey<FormState>();

  String _selectedCurrency = 'EUR';

  final _gastosPersonalesMaxController = TextEditingController();
  final _gastosPersonalesLimiteController = TextEditingController();
  final _gastosEsencialesMaxController = TextEditingController();
  final _gastosEsencialesLimiteController = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _gastosPersonalesMaxController.dispose();
    _gastosPersonalesLimiteController.dispose();
    _gastosEsencialesMaxController.dispose();
    _gastosEsencialesLimiteController.dispose();
    super.dispose();
  }

  void _finishSetup() async {
    if (_formKey.currentState!.validate()) {
      final financeService = ref.read(financeServiceProvider);
      final double gastosEsencialesMax =
          double.tryParse(_gastosEsencialesMaxController.text) ?? 0;
      final double gastosEsencialesLimite =
          double.tryParse(_gastosEsencialesLimiteController.text) ?? 0;

      // Update currency setting
      final settingsDao = ref.read(appSettingsDaoProvider);
      await settingsDao.updateSettings(AppSettingsCompanion(
        currency: drift.Value(_selectedCurrency),
      ));

      // Create accounts
      await financeService.createAccount(
          'Gastos personales',
          double.tryParse(_gastosPersonalesMaxController.text) ?? 0,
          double.tryParse(_gastosPersonalesLimiteController.text) ?? 0);
      await financeService.createAccount(
          'Gastos Esenciales', gastosEsencialesMax, gastosEsencialesLimite);
      await financeService.createAccount(
          'Imprevistos', gastosEsencialesMax * 6, gastosEsencialesLimite * 6);
      await financeService.createAccount('Fondo de emergencias',
          gastosEsencialesMax * 11, gastosEsencialesLimite * 11);
      await financeService.createAccount('Objetivos futuros', 9999999, 0);

      // Create categories
      await financeService.createDefaultCategories();

      // Mark setup as complete
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('setup_complete', true);

      // Navigate to home
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildCurrencyPage(),
            _buildWelcomePage(),
            _buildGastosPersonalesPage(),
            _buildGastosEsencialesPage(),
            _buildSummaryPage(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('1. Elige tu moneda',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 20),
          const Text(
            'Selecciona la moneda principal que usarás en la aplicación.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          DropdownButton<String>(
            value: _selectedCurrency,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedCurrency = newValue;
                });
              }
            },
            items: supportedCurrencies
                .map<DropdownMenuItem<String>>((Currency currency) {
              return DropdownMenuItem<String>(
                value: currency.code,
                child: Text('${currency.name} (${currency.symbol})'),
              );
            }).toList(),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            ),
            child: const Text('Siguiente'),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomePage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('2. ¡Bienvenido a Monity!',
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 20),
          const Text(
            'Antes de empezar, vamos a configurar tus cuentas. '
            'Esto te ayudará a gestionar tu dinero de forma efectiva.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('El Efecto Cascada',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 10),
                  const Text(
                      'Monity utiliza un sistema de "cascada". Cuando recibes un ingreso, el dinero llena primero la primera cuenta. '
                      'Lo que sobra, pasa a la siguiente, y así sucesivamente. '
                      'Los gastos se descuentan de la cuenta que elijas. Si no hay saldo suficiente, el resto se tomará de la siguiente cuenta hacia abajo en la cascada.'),
                  const SizedBox(height: 10),
                  const Text(
                      'Por eso, es crucial definir los límites de cada cuenta. ¡Vamos a ello!'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            ),
            child: const Text('Comenzar Configuración'),
          ),
        ],
      ),
    );
  }

  Widget _buildGastosPersonalesPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('3. Gastos Personales',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 10),
          const Text(
            'Esta cuenta es para tus gastos diarios y caprichos (café, snacks, etc.). El dinero que sobre aquí pasará a la siguiente cuenta.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _gastosPersonalesMaxController,
            decoration: const InputDecoration(
              labelText: 'Capacidad de la cuenta',
              helperText:
                  'Define cuánto dinero puede contener esta cuenta. El excedente pasará a la siguiente.',
              hintText: 'Ej: 300',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, introduce un valor';
              }
              if (double.tryParse(value) == null) {
                return 'Introduce un número válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _gastosPersonalesLimiteController,
            decoration: const InputDecoration(
              labelText: 'Objetivo de gasto mensual',
              helperText:
                  'Define una meta de gasto para tu presupuesto. Podrás cambiarla más tarde.',
              hintText: 'Ej: 200',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, introduce un valor';
              }
              if (double.tryParse(value) == null) {
                return 'Introduce un número válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              }
            },
            child: const Text('Siguiente'),
          ),
        ],
      ),
    );
  }

  Widget _buildGastosEsencialesPage() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('4. Gastos Esenciales',
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 10),
          const Text(
            'Para gastos fijos e importantes como facturas, alquiler o comida. El sobrante llenará las cuentas de Imprevistos y Emergencias.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _gastosEsencialesMaxController,
            decoration: const InputDecoration(
              labelText: 'Capacidad de la cuenta',
              helperText:
                  'Define cuánto dinero puede contener esta cuenta. El excedente pasará a la siguiente.',
              hintText: 'Ej: 800',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, introduce un valor';
              }
              if (double.tryParse(value) == null) {
                return 'Introduce un número válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _gastosEsencialesLimiteController,
            decoration: const InputDecoration(
              labelText: 'Objetivo de gasto mensual',
              helperText:
                  'Define una meta de gasto para tu presupuesto. Podrás cambiarla más tarde.',
              hintText: 'Ej: 700',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, introduce un valor';
              }
              if (double.tryParse(value) == null) {
                return 'Introduce un número válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {});
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              }
            },
            child: const Text('Ver Resumen'),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryPage() {
    // Parse values from controllers
    final double gastosPersonalesMax =
        double.tryParse(_gastosPersonalesMaxController.text) ?? 0;
    final double gastosPersonalesLimite =
        double.tryParse(_gastosPersonalesLimiteController.text) ?? 0;
    final double gastosEsencialesMax =
        double.tryParse(_gastosEsencialesMaxController.text) ?? 0;
    final double gastosEsencialesLimite =
        double.tryParse(_gastosEsencialesLimiteController.text) ?? 0;

    final double imprevistosMax = gastosEsencialesMax * 6;
    final double imprevistosLimite = gastosEsencialesLimite * 6;
    final double emergenciasMax = gastosEsencialesMax * 11;
    final double emergenciasLimite = gastosEsencialesLimite * 11;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('5. Resumen de Cuentas',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center),
            const SizedBox(height: 20),
            const Text(
              'Así quedarán configuradas tus cuentas:',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSummaryRow('Gastos Personales', gastosPersonalesMax,
                        gastosPersonalesLimite),
                    const Divider(),
                    _buildSummaryRow('Gastos Esenciales', gastosEsencialesMax,
                        gastosEsencialesLimite),
                    const Divider(),
                    _buildSummaryRow(
                        'Imprevistos', imprevistosMax, imprevistosLimite),
                    const Divider(),
                    _buildSummaryRow('Fondo de Emergencias', emergenciasMax,
                        emergenciasLimite),
                    const Divider(),
                    _buildSummaryRow('Objetivos Futuros', 9999999, 0),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Podrás modificar estos valores más tarde desde la pantalla de Configuración.',
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _finishSetup,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Finalizar y Guardar'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              ),
              child: const Text('Volver y corregir'),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String accountName, double max, double limit) {
    final currency =
        supportedCurrencies.firstWhere((c) => c.code == _selectedCurrency);
    final currencySymbol = currency.symbol;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(accountName,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Capacidad:'),
              Text('${max.toStringAsFixed(2)} $currencySymbol'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Límite de gasto:'),
              Text('${limit.toStringAsFixed(2)} $currencySymbol'),
            ],
          ),
        ],
      ),
    );
  }
}
