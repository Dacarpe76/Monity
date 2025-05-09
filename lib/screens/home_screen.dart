import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:monity/services/hive_service.dart';
import '../widgets/accounts_list.dart'; // Importamos el widget de lista de cuentas

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _log = Logger('HomeScreen');
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      setState(() => _isLoading = true);
      await HiveService.saveBoxes();
      _log.info('Boxes guardados correctamente');
    } catch (e) {
      _log.severe('Error al guardar boxes: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al inicializar: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monity'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: const [
                // Aquí podrías volver a añadir BalanceSummary() si lo deseas y lo tienes definido
                Expanded(
                  child:
                      AccountsList(), // Volvemos a añadir la lista de cuentas
                ),
              ],
            ),
    );
  }
}
