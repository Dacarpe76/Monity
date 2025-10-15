import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monity/data/database.dart';
import 'package:intl/intl.dart';

class AddCreditScreen extends ConsumerStatefulWidget {
  final Credito? credit;
  const AddCreditScreen({super.key, this.credit});

  @override
  ConsumerState<AddCreditScreen> createState() => _AddCreditScreenState();
}

class _AddCreditScreenState extends ConsumerState<AddCreditScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _pendingController;
  late final TextEditingController _paymentController;
  DateTime? _endDate;
  int? _paymentDay;
  Cuenta? _selectedAccount;
  List<Cuenta> _accounts = [];

  int get _monthsLeft {
    if (_endDate == null) return 0;
    final now = DateTime.now();
    return (_endDate!.year - now.year) * 12 + (_endDate!.month - now.month) + 1;
  }

  double get _baseAmortized {
    final pending = double.tryParse(_pendingController.text) ?? 0;
    return _monthsLeft > 0 ? pending / _monthsLeft : 0;
  }

  double get _interestEstimated {
    final cuota = double.tryParse(_paymentController.text) ?? 0;
    final base = _baseAmortized;
    return cuota > base ? cuota - base : 0;
  }

  bool get isEditing => widget.credit != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.credit?.name);
    _pendingController = TextEditingController(
        text: widget.credit?.remainingAmount.toString() ?? '');
    _paymentController = TextEditingController(
        text: widget.credit?.paymentAmount.toString() ?? '');
    if (widget.credit?.plazoEnMeses != null &&
        widget.credit?.plazoEnMeses != 0) {
      final now = DateTime.now();
      _endDate =
          DateTime(now.year, now.month + (widget.credit!.plazoEnMeses - 1));
    }
    _paymentDay = widget.credit?.paymentDay ?? DateTime.now().day;
    _loadAccounts();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pendingController.dispose();
    _paymentController.dispose();
    super.dispose();
  }

  Future<void> _loadAccounts() async {
    final db = ref.read(databaseProvider);
    final accounts = await db.cuentasDao.allCuentas;
    setState(() {
      _accounts = accounts;
      if (isEditing) {
        _selectedAccount =
            _accounts.firstWhere((a) => a.id == widget.credit!.linkedAccountId);
      } else if (_accounts.isNotEmpty) {
        _selectedAccount = _accounts.first;
      }
    });
  }

  Future<void> _saveCredit() async {
    if (_formKey.currentState!.validate() &&
        _selectedAccount != null &&
        _endDate != null &&
        _paymentDay != null) {
      final db = ref.read(databaseProvider);
      final months = _monthsLeft;
      final pending = double.parse(_pendingController.text);
      final cuota = double.parse(_paymentController.text);
      final companion = CreditosCompanion(
        id: isEditing ? Value(widget.credit!.id) : const Value.absent(),
        name: Value(_nameController.text),
        totalAmount: Value(pending),
        remainingAmount:
            isEditing ? Value(widget.credit!.remainingAmount) : Value(pending),
        paymentAmount: Value(cuota),
        interestRate: const Value(0), // No se pide
        paymentDay: Value(_paymentDay!),
        creditType: Value(CreditType.fijo),
        linkedAccountId: Value(_selectedAccount!.id),
        createdAt:
            isEditing ? Value(widget.credit!.createdAt) : Value(DateTime.now()),
        lastPaymentDate: isEditing
            ? Value(widget.credit!.lastPaymentDate)
            : const Value.absent(),
        plazoEnMeses: Value(months),
        comisionAmortizacionParcial: const Value.absent(),
        comisionCancelacionTotal: const Value.absent(),
      );
      await db.creditosDao.upsertCredito(companion);
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> _pickEndDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 30, 12, 31),
      helpText: 'Selecciona la fecha de fin',
      fieldLabelText: 'Fecha de fin',
      fieldHintText: 'mm/aaaa',
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      // Permitir cualquier día del mes
    );
    if (picked != null) {
      setState(() {
        // Ajustar internamente al primer día del mes seleccionado
        _endDate = DateTime(picked.year, picked.month);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Crédito' : 'Añadir Crédito'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveCredit,
          )
        ],
      ),
      body: _accounts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                            labelText:
                                'Nombre del crédito (ej: Hipoteca, Coche...)'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, introduce un nombre';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<Cuenta>(
                        initialValue: _selectedAccount,
                        items: _accounts.map((account) {
                          return DropdownMenuItem(
                            value: account,
                            child: Text(account.nombre),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedAccount = value;
                          });
                        },
                        decoration:
                            const InputDecoration(labelText: 'Cuenta asociada'),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _paymentController,
                        decoration:
                            const InputDecoration(labelText: 'Cuota mensual (€)'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              double.tryParse(value) == null ||
                              double.parse(value) <= 0) {
                            return 'Introduce una cuota válida';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _pendingController,
                        decoration: const InputDecoration(
                            labelText: 'Importe pendiente (€)'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              double.tryParse(value) == null ||
                              double.parse(value) <= 0) {
                            return 'Introduce un importe válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        title: Text(_endDate == null
                            ? 'Selecciona la fecha de fin (mes/año)'
                            : 'Fecha de fin: ${DateFormat('MM/yyyy').format(_endDate!)}'),
                        trailing: const Icon(Icons.calendar_today),
                        onTap: _pickEndDate,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Text('Día de cargo: '),
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              initialValue: _paymentDay,
                              items: List.generate(28, (i) => i + 1)
                                  .map((d) => DropdownMenuItem(
                                        value: d,
                                        child: Text(d.toString()),
                                      ))
                                  .toList(),
                              onChanged: (d) => setState(() => _paymentDay = d),
                              decoration: const InputDecoration(
                                labelText: 'Día de cargo (1-28)',
                              ),
                              validator: (value) =>
                                  value == null ? 'Selecciona un día' : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      if (_monthsLeft > 0)
                        Card(
                          color: Colors.blue.shade50,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Resumen automático:',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text('Meses restantes: $_monthsLeft'),
                                Text(
                                    'Amortización base mensual: ${_baseAmortized.toStringAsFixed(2)} €'),
                                Text(
                                    'Interés estimado mensual: ${_interestEstimated.toStringAsFixed(2)} €'),
                                const SizedBox(height: 4),
                                Text(
                                    'Cada vez que pagues una cuota, el sistema restará la parte de amortización base al pendiente.'),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: _saveCredit,
                        child: Text(
                            isEditing ? 'Guardar Cambios' : 'Guardar Crédito'),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}