import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monity/data/database.dart';
import 'package:monity/providers.dart';
import 'package:monity/ui/screens/add_expense_screen.dart';
import 'package:monity/ui/screens/add_income_screen.dart';
import 'package:monity/ui/screens/add_transfer_screen.dart';
import 'package:monity/ui/screens/add_credit_screen.dart';
import 'package:monity/ui/screens/settings_screen.dart';
import 'package:monity/ui/screens/manual_screen.dart'; // Import the new manual screen
import 'package:monity/ui/screens/setup_screen.dart';
import 'package:monity/ui/widgets/account_card.dart';
import 'package:monity/ui/screens/daily_balance_chart_screen.dart';




class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showAmounts = ref.watch(showAmountsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monity'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    tooltip: 'Añadir Gasto',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const AddExpenseScreen()),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    tooltip: 'Añadir Ingreso',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const AddIncomeScreen()),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.swap_horiz),
                    tooltip: 'Transferencia entre cuentas',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const AddTransferScreen()),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.credit_card),
                    tooltip: 'Añadir/Gestionar Créditos',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const AddCreditScreen()),
                      );
                    },
                  ),


                  IconButton(
                    icon: Icon(
                        showAmounts ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      ref.read(showAmountsProvider.notifier).state = !showAmounts;
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.book),
                    tooltip: 'Manual de Usuario',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const ManualScreen()),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const SettingsScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.3,
                    child: Image.asset(
                      'assets/icons/Fuente2.png',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  StreamBuilder<List<Cuenta>>(
                    stream: ref.watch(cuentasDaoProvider).watchAllCuentas(),
                    builder: (context, cuentasSnapshot) {
                      return StreamBuilder<List<Credito>>(
                        stream: ref
                            .watch(databaseProvider)
                            .creditosDao
                            .watchAllCreditos(),
                        builder: (context, creditosSnapshot) {
                          if (cuentasSnapshot.connectionState ==
                                  ConnectionState.waiting ||
                              creditosSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (cuentasSnapshot.hasError ||
                              creditosSnapshot.hasError) {
                            return const Center(
                                child: Text('Error al cargar los datos'));
                          }
                          if (!cuentasSnapshot.hasData ||
                              cuentasSnapshot.data!.isEmpty) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const SetupScreen(),
                                ),
                              );
                            });
                            return const Center(child: CircularProgressIndicator());
                          }

                          final cuentas = cuentasSnapshot.data!;
                          final creditos = creditosSnapshot.data ?? [];

                          final creditosPorCuenta = <int, List<Credito>>{};
                          for (final credito in creditos) {
                            (creditosPorCuenta[credito.linkedAccountId] ??= [])
                                .add(credito);
                          }

                          // Calculate total balance
                          final totalAccountBalance = cuentas.fold<double>(
                              0.0, (sum, cuenta) => sum + cuenta.saldoActual);
                          final totalCreditPending = creditos.fold<double>(0.0,
                              (sum, credito) => sum + credito.remainingAmount);
                          final accumulatedBalance =
                              totalAccountBalance - totalCreditPending;

                          return ListView(
                            padding: const EdgeInsets.all(8.0),
                            children: [
                              ...cuentas.expand((cuenta) {
                                final linkedCredits =
                                    creditosPorCuenta[cuenta.id] ?? [];
                                return [
                                  AccountCard(
                                      cuenta: cuenta, showAmounts: showAmounts),
                                  ...linkedCredits.map((c) => _CreditListTile(
                                      credit: c, showAmounts: showAmounts)),
                                ];
                              }),
                              // Display accumulated balance
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const DailyBalanceChartScreen(),
                                    ),
                                  );
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: Colors.black, width: 1),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  margin: const EdgeInsets.all(8.0),
                                  color: accumulatedBalance >= 0
                                      ? Colors.green.shade100
                                      : Colors.red
                                          .shade100, // Conditional background color
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween, // Align items to start and end
                                      children: [
                                        const Text(
                                          'Total acumulado:',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          showAmounts
                                              ? '${accumulatedBalance.toStringAsFixed(2)} €'
                                              : '***',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: accumulatedBalance >= 0
                                                ? Colors.green.shade800
                                                : Colors.red
                                                    .shade800, // Adjust text color for contrast
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 80.0),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreditListTile extends StatefulWidget {
  final Credito credit;
  final bool showAmounts;

  const _CreditListTile(
      {required this.credit, required this.showAmounts});

  @override
  State<_CreditListTile> createState() => _CreditListTileState();
}

class _CreditListTileState extends State<_CreditListTile> {
  bool _hidden = true;

  void _toggleHidden() {
    setState(() {
      _hidden = !_hidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    final show = widget.showAmounts && !_hidden;
    return InkWell(
      onTap: _toggleHidden,
      child: show
          ? Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: Colors.orange,
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.credit.name}      Restante: ${widget.credit.remainingAmount.toStringAsFixed(2)} €      Cuota: ${widget.credit.paymentAmount.toStringAsFixed(2)} €',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: Colors.orange,
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.credit.name}      Restante: ****      Cuota: ****',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}